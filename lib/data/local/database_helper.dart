import 'dart:convert';
import 'package:hive_flutter/hive_flutter.dart';
import '../../core/constants/app_constants.dart';
import '../models/student_model.dart';
import '../models/transaction_model.dart';
import '../models/payment_model.dart';

/// Centralized local database access (Hive). Singleton.
class DatabaseHelper {
  DatabaseHelper._();
  static final DatabaseHelper instance = DatabaseHelper._();

  late Box<Student> studentsBox;
  late Box<Transaction> transactionsBox;
  late Box<Payment> paymentsBox;
  late Box settingsBox;

  Future<void> init() async {
    await Hive.initFlutter();

    if (!Hive.isAdapterRegistered(0)) Hive.registerAdapter(StudentAdapter());
    if (!Hive.isAdapterRegistered(2)) {
      Hive.registerAdapter(TransactionAdapter());
    }
    if (!Hive.isAdapterRegistered(3)) Hive.registerAdapter(PaymentAdapter());

    studentsBox = await Hive.openBox<Student>(AppConstants.studentsBox);
    transactionsBox = await Hive.openBox<Transaction>(
      AppConstants.transactionsBox,
    );
    paymentsBox = await Hive.openBox<Payment>(AppConstants.paymentsBox);
    settingsBox = await Hive.openBox(AppConstants.settingsBox);
  }

  // ---------------- Students ----------------
  List<Student> getStudents() => studentsBox.values.toList();

  Future<void> saveStudent(Student s) => studentsBox.put(s.id, s);

  Future<void> deleteStudent(String id) async {
    await studentsBox.delete(id);
    final relatedPaymentKeys = paymentsBox.values
        .where((p) => p.studentId == id)
        .map((p) => p.id)
        .toList();
    for (final key in relatedPaymentKeys) {
      await paymentsBox.delete(key);
      await transactionsBox.delete(key);
    }
    // Also clean any transaction directly linked to this student
    final relatedTxnKeys = transactionsBox.values
        .where((t) => t.linkedStudentId == id)
        .map((t) => t.id)
        .toList();
    for (final key in relatedTxnKeys) {
      await transactionsBox.delete(key);
    }
  }

  // ---------------- Payments & Auto-sync with Transactions ----------------
  List<Payment> getPayments() => paymentsBox.values.toList();

  Future<void> savePayment(Payment p, {String? studentName}) async {
    await paymentsBox.put(p.id, p);

    // Auto-sync into transactions as an Income record under 'Tuition'
    final label = studentName != null && studentName.isNotEmpty
        ? 'Tuition fee - $studentName (${p.receiptNo})'
        : 'Tuition fee (${p.receiptNo})';
    final fullNote = p.note != null && p.note!.isNotEmpty
        ? '$label · ${p.note}'
        : label;

    final txn = Transaction(
      id: p.id,
      amount: p.amount,
      type: TxnType.income,
      category: 'Tuition',
      date: p.paymentDate,
      note: fullNote,
      linkedStudentId: p.studentId,
    );
    await transactionsBox.put(p.id, txn);
  }

  Future<void> deletePayment(String id) async {
    await paymentsBox.delete(id);
    await transactionsBox.delete(id);
  }

  // ---------------- Transactions ----------------
  List<Transaction> getTransactions() {
    final list = transactionsBox.values.toList();
    list.sort((a, b) => b.date.compareTo(a.date));
    return list;
  }

  Future<void> saveTransaction(Transaction t) => transactionsBox.put(t.id, t);

  Future<void> deleteTransaction(String id) async {
    await transactionsBox.delete(id);
    // If this transaction was created by a payment with same ID, remove payment too
    if (paymentsBox.containsKey(id)) {
      await paymentsBox.delete(id);
    }
  }

  // ---------------- Settings ----------------
  T? getSetting<T>(String key) => settingsBox.get(key) as T?;

  Future<void> setSetting(String key, dynamic value) =>
      settingsBox.put(key, value);

  // ---------------- Backup / Restore (JSON) ----------------
  Map<String, dynamic> exportAllToJson() => <String, dynamic>{
    'version': 2,
    'exportedAt': DateTime.now().toIso8601String(),
    'students': getStudents().map((s) => s.toJson()).toList(),
    'transactions': getTransactions().map((t) => t.toJson()).toList(),
    'payments': getPayments().map((p) => p.toJson()).toList(),
  };

  String exportAllToJsonString() =>
      const JsonEncoder.withIndent('  ').convert(exportAllToJson());

  /// Imports data, replacing all existing local data.
  Future<void> importFromJsonString(String jsonStr) async {
    final Map<String, dynamic> data =
        jsonDecode(jsonStr) as Map<String, dynamic>;

    await studentsBox.clear();
    await transactionsBox.clear();
    await paymentsBox.clear();

    final students = (data['students'] as List? ?? []).map(
      (e) => Student.fromJson(e as Map<String, dynamic>),
    );
    for (final s in students) {
      await studentsBox.put(s.id, s);
    }

    final txns = (data['transactions'] as List? ?? []).map(
      (e) => Transaction.fromJson(e as Map<String, dynamic>),
    );
    for (final t in txns) {
      await transactionsBox.put(t.id, t);
    }

    final payments = (data['payments'] as List? ?? []).map(
      (e) => Payment.fromJson(e as Map<String, dynamic>),
    );
    for (final p in payments) {
      await paymentsBox.put(p.id, p);
    }
  }

  Future<void> clearAllData() async {
    await studentsBox.clear();
    await transactionsBox.clear();
    await paymentsBox.clear();
  }
}
