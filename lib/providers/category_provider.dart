import 'package:flutter/foundation.dart';
import '../core/constants/app_constants.dart';
import '../data/local/database_helper.dart';

/// Manages user-editable Income / Expense categories, persisted in Hive
/// settings box. Falls back to the default lists on first run.
class CategoryProvider extends ChangeNotifier {
  final DatabaseHelper _db = DatabaseHelper.instance;

  static const _incomeKey = 'income_categories';
  static const _expenseKey = 'expense_categories';

  List<String> _income = [];
  List<String> _expense = [];

  List<String> get incomeCategories => List.unmodifiable(_income);
  List<String> get expenseCategories => List.unmodifiable(_expense);

  CategoryProvider() {
    _load();
  }

  void _load() {
    final storedIncome = _db.getSetting<List>(_incomeKey);
    final storedExpense = _db.getSetting<List>(_expenseKey);

    _income = storedIncome != null
        ? storedIncome.map((e) => e.toString()).toList()
        : List<String>.from(AppConstants.incomeCategories);

    _expense = storedExpense != null
        ? storedExpense.map((e) => e.toString()).toList()
        : List<String>.from(AppConstants.expenseCategories);

    notifyListeners();
  }

  Future<void> _persist() async {
    await _db.setSetting(_incomeKey, _income);
    await _db.setSetting(_expenseKey, _expense);
  }

  List<String> categoriesFor(TxnType type) =>
      type == TxnType.income ? incomeCategories : expenseCategories;

  Future<void> addCategory(TxnType type, String name) async {
    final trimmed = name.trim();
    if (trimmed.isEmpty) return;
    final list = type == TxnType.income ? _income : _expense;
    if (list.any((c) => c.toLowerCase() == trimmed.toLowerCase())) return;
    list.add(trimmed);
    await _persist();
    notifyListeners();
  }

  Future<void> renameCategory(
    TxnType type,
    String oldName,
    String newName,
  ) async {
    final trimmed = newName.trim();
    if (trimmed.isEmpty) return;
    final list = type == TxnType.income ? _income : _expense;
    final index = list.indexOf(oldName);
    if (index == -1) return;
    list[index] = trimmed;
    await _persist();
    notifyListeners();
  }

  Future<void> deleteCategory(TxnType type, String name) async {
    final list = type == TxnType.income ? _income : _expense;
    if (list.length <= 1) return; // Keep at least one category.
    list.remove(name);
    await _persist();
    notifyListeners();
  }
}
