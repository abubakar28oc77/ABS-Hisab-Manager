import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';
import '../data/local/database_helper.dart';
import '../data/models/payment_model.dart';

class PaymentProvider extends ChangeNotifier {
  final DatabaseHelper _db = DatabaseHelper.instance;
  final _uuid = const Uuid();

  List<Payment> _payments = [];
  List<Payment> get payments => List.unmodifiable(_payments);

  PaymentProvider() {
    loadPayments();
  }

  void loadPayments() {
    _payments = _db.getPayments()
      ..sort((a, b) => b.paymentDate.compareTo(a.paymentDate));
    notifyListeners();
  }

  List<Payment> forStudent(String studentId) =>
      _payments.where((p) => p.studentId == studentId).toList()
        ..sort((a, b) => b.paymentDate.compareTo(a.paymentDate));

  double totalPaid(String studentId) => forStudent(
    studentId,
  ).fold(0.0, (s, p) => s + p.amount);

  List<Payment> inRange(DateTime start, DateTime end) => _payments
      .where(
        (p) =>
            !p.paymentDate.isBefore(start) && p.paymentDate.isBefore(end),
      )
      .toList();

  String nextReceiptNo() {
    final now = DateTime.now();
    final prefix =
        'RCT-${now.year}${now.month.toString().padLeft(2, '0')}-';
    final countThisMonth = _payments
        .where((p) => p.receiptNo.startsWith(prefix))
        .length;
    return '$prefix${(countThisMonth + 1).toString().padLeft(4, '0')}';
  }

  Future<Payment> addPayment({
    required String studentId,
    String? studentName,
    required double amount,
    required PaymentMethod method,
    required DateTime paymentDate,
    required String forMonth,
    String? note,
    bool receiptGiven = true,
  }) async {
    final payment = Payment(
      id: _uuid.v4(),
      studentId: studentId,
      amount: amount,
      method: method,
      paymentDate: paymentDate,
      forMonth: forMonth,
      note: note,
      receiptNo: nextReceiptNo(),
      receiptGiven: receiptGiven,
    );
    await _db.savePayment(payment, studentName: studentName);
    loadPayments();
    return payment;
  }

  Future<void> deletePayment(String id) async {
    await _db.deletePayment(id);
    loadPayments();
  }
}
