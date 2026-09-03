import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';
import '../core/constants/app_constants.dart';
import '../data/local/database_helper.dart';
import '../data/models/transaction_model.dart';

class TransactionProvider extends ChangeNotifier {
  final DatabaseHelper _db = DatabaseHelper.instance;
  final _uuid = const Uuid();

  List<Transaction> _transactions = [];
  List<Transaction> get transactions => List.unmodifiable(_transactions);

  TransactionProvider() {
    loadTransactions();
  }

  void loadTransactions() {
    _transactions = _db.getTransactions();
    notifyListeners();
  }

  Future<void> addTransaction({
    required double amount,
    required TxnType type,
    required String category,
    required DateTime date,
    String? note,
    String? linkedStudentId,
  }) async {
    final txn = Transaction(
      id: _uuid.v4(),
      amount: amount,
      type: type,
      category: category,
      date: date,
      note: note,
      linkedStudentId: linkedStudentId,
    );
    await _db.saveTransaction(txn);
    loadTransactions();
  }

  Future<void> updateTransaction(Transaction t) async {
    await _db.saveTransaction(t);
    loadTransactions();
  }

  Future<void> deleteTransaction(String id) async {
    await _db.deleteTransaction(id);
    loadTransactions();
  }

  // ---------------- Summary helpers ----------------
  double get totalIncome => _transactions
      .where((t) => t.type == TxnType.income)
      .fold(0.0, (sum, t) => sum + t.amount);

  double get totalExpense => _transactions
      .where((t) => t.type == TxnType.expense)
      .fold(0.0, (sum, t) => sum + t.amount);

  double get netBalance => totalIncome - totalExpense;

  List<Transaction> get recent => _transactions.take(6).toList();

  List<Transaction> forMonth(int month, int year) => _transactions
      .where((t) => t.date.month == month && t.date.year == year)
      .toList();

  double incomeForMonth(int month, int year) => forMonth(
    month,
    year,
  ).where((t) => t.type == TxnType.income).fold(0.0, (s, t) => s + t.amount);

  double expenseForMonth(int month, int year) => forMonth(
    month,
    year,
  ).where((t) => t.type == TxnType.expense).fold(0.0, (s, t) => s + t.amount);

  /// category -> total amount (expenses only), for pie chart breakdown.
  Map<String, double> categoryBreakdown({TxnType type = TxnType.expense}) {
    final Map<String, double> map = {};
    for (final t in _transactions.where((t) => t.type == type)) {
      map[t.category] = (map[t.category] ?? 0) + t.amount;
    }
    return map;
  }

  /// category -> total amount for specific month, for pie chart breakdown.
  Map<String, double> categoryBreakdownForMonth(
    int month,
    int year, {
    TxnType type = TxnType.expense,
  }) {
    final Map<String, double> map = {};
    for (final t in forMonth(month, year).where((t) => t.type == type)) {
      map[t.category] = (map[t.category] ?? 0) + t.amount;
    }
    return map;
  }

  /// Returns recent transactions strictly for the given month.
  List<Transaction> recentForMonth(int month, int year, {int limit = 6}) {
    final list = forMonth(month, year);
    list.sort((a, b) => b.date.compareTo(a.date));
    return list.take(limit).toList();
  }
}
