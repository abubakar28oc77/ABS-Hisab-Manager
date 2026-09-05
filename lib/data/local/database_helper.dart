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

    if (studentsBox.isEmpty) {
      final initialStudents = [
        Student(
          id: 'std-1',
          name: 'MD. HASAN MANDAL',
          className: 'Class 6',
          rollNumber: '6',
          section: 'A',
          monthlyFee: 500,
          admissionDate: DateTime(2026, 7, 20),
          fatherName: 'MD. BABUL MONDAL',
          fatherPhone: '01741264228',
          address: 'Betbari, Tangail Sadar, Tangail',
        ),
        Student(
          id: 'std-2',
          name: 'NIROB',
          className: 'Class 6',
          rollNumber: '13',
          section: 'A',
          monthlyFee: 500,
          admissionDate: DateTime(2026, 7, 20),
          fatherName: 'MD. NAZRUL ISLAM',
          fatherPhone: '01719399022',
          address: 'Betbari, Tangail Sadar, Tangail',
        ),
        Student(
          id: 'std-3',
          name: 'NAFIZUL UL HAQUE',
          className: 'Class 6',
          rollNumber: '14',
          section: 'A',
          monthlyFee: 500,
          admissionDate: DateTime(2026, 7, 20),
          fatherName: 'SAJEDUL ISLAM',
          fatherPhone: '01710259032',
          address: 'Betbari, Tangail Sadar, Tangail',
        ),
        Student(
          id: 'std-4',
          name: 'MAHIM BHUIYA',
          className: 'Class 6',
          rollNumber: '28',
          section: 'A',
          monthlyFee: 500,
          admissionDate: DateTime(2026, 7, 20),
          fatherName: 'MD. MOSHARAF BHUYAN',
          fatherPhone: '01753152326',
          address: 'Tuni Magra, Kalihati, Tangail',
        ),
        Student(
          id: 'std-5',
          name: 'IMRAN',
          className: 'Class 6',
          rollNumber: '79',
          section: 'A',
          monthlyFee: 500,
          admissionDate: DateTime(2026, 7, 20),
          fatherName: 'JOHER',
          fatherPhone: '01710689846',
          address: 'Dholkan Palpara, Kalihati, Tangail',
        ),
        Student(
          id: 'std-6',
          name: 'SHIMANTA DAS',
          className: 'Class 6',
          rollNumber: '96',
          section: 'A',
          monthlyFee: 500,
          admissionDate: DateTime(2026, 7, 20),
          fatherName: 'KHUSHI CHANDRA DAS',
          fatherPhone: '01753539680',
          address: 'Betbari, Tangail Sadar, Tangail',
        ),
        Student(
          id: 'std-7',
          name: 'SUPTO GHOSH',
          className: 'Class 7',
          rollNumber: '1',
          section: 'A',
          monthlyFee: 500,
          admissionDate: DateTime(2026, 7, 20),
          fatherName: 'SHUKUMAR CHANDRA GHOSH',
          fatherPhone: '01723450534',
          address: 'Dholkan Palpara, Kalihati, Tangail',
        ),
        Student(
          id: 'std-8',
          name: 'ASIF FUYAD',
          className: 'Class 7',
          rollNumber: '4',
          section: 'A',
          monthlyFee: 500,
          admissionDate: DateTime(2026, 7, 20),
          fatherName: 'MD. ISMAIL HOSSAIN BHUIYAN',
          fatherPhone: '01756346890',
          address: 'Dasokia, Kalihati, Tangail',
        ),
        Student(
          id: 'std-9',
          name: 'MD. IMRAN',
          className: 'Class 7',
          rollNumber: '6',
          section: 'A',
          monthlyFee: 500,
          admissionDate: DateTime(2026, 7, 20),
          fatherName: 'MD. ABDUR RASHID',
          fatherPhone: '01720584931',
          address: 'Betbari, Tangail Sadar, Tangail',
        ),
        Student(
          id: 'std-10',
          name: 'MD. ABDULLAH',
          className: 'Class 7',
          rollNumber: '11',
          section: 'A',
          monthlyFee: 500,
          admissionDate: DateTime(2026, 7, 20),
          fatherName: 'MD. MOKADDES ALI',
          fatherPhone: '01917213701',
          address: 'South Khasmagra, Kalihati, Tangail',
        ),
        Student(
          id: 'std-11',
          name: 'ALIF HOSSAIN',
          className: 'Class 7',
          rollNumber: '24',
          section: 'A',
          monthlyFee: 500,
          admissionDate: DateTime(2026, 7, 20),
          fatherName: 'MD. DULAL HOSSAIN',
          fatherPhone: '01746062194',
          address: 'Kuizbari, Tangail Sadar, Tangail',
        ),
        Student(
          id: 'std-12',
          name: 'MD. SAMIUL',
          className: 'Class 7',
          rollNumber: '30',
          section: 'A',
          monthlyFee: 500,
          admissionDate: DateTime(2026, 7, 20),
          fatherName: 'MD. ABUBAKAR SIDDIK',
          fatherPhone: '01725313663',
          address: 'Tuni Magra, Kalihati, Tangail',
        ),
        Student(
          id: 'std-13',
          name: 'SAMIUL ISLAM',
          className: 'Class 7',
          rollNumber: '39',
          section: 'A',
          monthlyFee: 500,
          admissionDate: DateTime(2026, 7, 20),
          fatherName: 'MD. SHAHIDUL ISLAM',
          fatherPhone: '01602727295',
          address: 'Dholkan Palpara, Kalihati, Tangail',
        ),
        Student(
          id: 'std-14',
          name: 'ADITTO KARMAKAR',
          className: 'Class 7',
          rollNumber: '41',
          section: 'A',
          monthlyFee: 500,
          admissionDate: DateTime(2026, 7, 20),
          fatherName: 'BUDDHADEB KARMAKAR',
          fatherPhone: '01730603155',
          address: 'Tuni Magra, Kalihati, Tangail',
        ),
        Student(
          id: 'std-15',
          name: 'MD. ALHAZ',
          className: 'Class 7',
          rollNumber: '46',
          section: 'A',
          monthlyFee: 500,
          admissionDate: DateTime(2026, 7, 20),
          fatherName: 'MD. ABU TALEB',
          fatherPhone: '01720812611',
          address: 'Betbari, Tangail Sadar, Tangail',
        ),
        Student(
          id: 'std-16',
          name: 'MD. RIYAD HOSEN',
          className: 'Class 7',
          rollNumber: '59',
          section: 'A',
          monthlyFee: 500,
          admissionDate: DateTime(2026, 7, 20),
          fatherName: 'MD. BABUL HOSSAIN',
          fatherPhone: '01741007262',
          address: 'Dholkan Palpara, Kalihati, Tangail',
        ),
        Student(
          id: 'std-17',
          name: 'RAIYAN',
          className: 'Class 7',
          rollNumber: '66',
          section: 'A',
          monthlyFee: 500,
          admissionDate: DateTime(2026, 7, 20),
          fatherName: 'MD. RANA',
          fatherPhone: '01316885870',
          address: 'South Magra, Tangail Sadar, Tangail',
        ),
      ];
      for (final s in initialStudents) {
        await studentsBox.put(s.id, s);
      }
    }
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
