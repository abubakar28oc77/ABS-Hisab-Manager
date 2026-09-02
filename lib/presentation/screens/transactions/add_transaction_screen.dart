import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/app_strings.dart';
import '../../../core/utils/formatters.dart';
import '../../../data/models/transaction_model.dart';
import '../../../providers/category_provider.dart';
import '../../../providers/transaction_provider.dart';
import '../settings/manage_categories_screen.dart';

class AddTransactionScreen extends StatefulWidget {
  final Transaction? existing;
  const AddTransactionScreen({super.key, this.existing});

  @override
  State<AddTransactionScreen> createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  final _formKey = GlobalKey<FormState>();
  final _amountCtrl = TextEditingController();
  final _noteCtrl = TextEditingController();
  TxnType _type = TxnType.expense;
  String? _category;
  DateTime _date = DateTime.now();

  List<String> _categoriesFor(BuildContext context) =>
      context.watch<CategoryProvider>().categoriesFor(_type);

  @override
  void initState() {
    super.initState();
    final t = widget.existing;
    if (t != null) {
      _amountCtrl.text = t.amount.toStringAsFixed(2);
      _noteCtrl.text = t.note ?? '';
      _type = t.type;
      _category = t.category;
      _date = t.date;
    }
  }

  @override
  void dispose() {
    _amountCtrl.dispose();
    _noteCtrl.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2015),
      lastDate: DateTime(2100),
    );
    if (picked != null) setState(() => _date = picked);
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    final provider = context.read<TransactionProvider>();
    final amount = double.tryParse(_amountCtrl.text) ?? 0;
    final category = _category ?? _categoriesFor(context).first;

    if (widget.existing != null) {
      final t = widget.existing!;
      t.amount = amount;
      t.type = _type;
      t.category = category;
      t.date = _date;
      t.note = _noteCtrl.text.trim();
      await provider.updateTransaction(t);
    } else {
      await provider.addTransaction(
        amount: amount,
        type: _type,
        category: category,
        date: _date,
        note: _noteCtrl.text.trim(),
      );
    }
    if (mounted) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.existing != null;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          isEdit
              ? (context.watch<TransactionProvider>().transactions.any((t) => t.id == widget.existing?.id)
                  ? 'Edit Transaction'
                  : 'Add Transaction')
              : 'Add Transaction',
        ),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Container(
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.circular(14),
                ),
                padding: const EdgeInsets.all(4),
                child: Row(
                  children: [
                    _typeToggle(
                      TxnType.income,
                      AppStrings.t(context, 'income'),
                      AppColors.income,
                    ),
                    _typeToggle(
                      TxnType.expense,
                      AppStrings.t(context, 'expense'),
                      AppColors.expense,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),
              TextFormField(
                controller: _amountCtrl,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                ),
                decoration: InputDecoration(
                  labelText: '${AppStrings.t(context, 'amount')} *',
                  prefixText: '৳ ',
                ),
                validator: (v) {
                  if (v == null || v.trim().isEmpty) return 'Required';
                  if (double.tryParse(v) == null) return 'Invalid amount';
                  return null;
                },
              ),
              const SizedBox(height: 14),
              Builder(
                builder: (context) {
                  final categories = _categoriesFor(context);
                  final value =
                      (_category != null && categories.contains(_category))
                      ? _category
                      : categories.first;
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          initialValue: value,
                          decoration: const InputDecoration(
                            labelText: 'Category',
                          ),
                          items: categories
                              .map(
                                (c) =>
                                    DropdownMenuItem(value: c, child: Text(c)),
                              )
                              .toList(),
                          onChanged: (v) => setState(() => _category = v),
                        ),
                      ),
                      const SizedBox(width: 8),
                      IconButton(
                        tooltip: 'Manage Categories',
                        icon: const Icon(Icons.edit_note_rounded),
                        onPressed: () async {
                          await Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) =>
                                  ManageCategoriesScreen(initialType: _type),
                            ),
                          );
                          setState(() {});
                        },
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 14),
              InkWell(
                onTap: _pickDate,
                child: InputDecorator(
                  decoration: InputDecoration(
                    labelText: AppStrings.t(context, 'payment_date'),
                  ),
                  child: Text(Formatters.date(_date)),
                ),
              ),
              const SizedBox(height: 14),
              TextFormField(
                controller: _noteCtrl,
                maxLines: 2,
                decoration: InputDecoration(
                  labelText: AppStrings.t(context, 'note_optional'),
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _save,
                style: ElevatedButton.styleFrom(
                  backgroundColor: _type == TxnType.income
                      ? AppColors.income
                      : AppColors.expense,
                ),
                child: Text(
                  isEdit ? 'Update' : AppStrings.t(context, 'save_student').replaceAll('শিক্ষার্থী সংরক্ষণ করুন', 'সংরক্ষণ করুন'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _typeToggle(TxnType type, String label, Color color) {
    final selected = _type == type;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() {
          _type = type;
          _category = null;
        }),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: selected ? color : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: TextStyle(
              color: selected ? Colors.white : AppColors.textSecondary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
