import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/app_strings.dart';
import '../../../providers/transaction_provider.dart';
import '../../widgets/transaction_tile.dart';
import 'add_transaction_screen.dart';

class TransactionsScreen extends StatefulWidget {
  const TransactionsScreen({super.key});

  @override
  State<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  TxnType? _filter; // null = all

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TransactionProvider>();
    final list = provider.transactions
        .where((t) => _filter == null || t.type == _filter)
        .toList();

    return Scaffold(
      appBar: AppBar(title: Text(AppStrings.t(context, 'transactions'))),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  _filterChip(AppStrings.t(context, 'all'), null),
                  const SizedBox(width: 8),
                  _filterChip(AppStrings.t(context, 'income'), TxnType.income),
                  const SizedBox(width: 8),
                  _filterChip(AppStrings.t(context, 'expense'), TxnType.expense),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: list.isEmpty
                  ? Center(
                      child: Text(
                        AppStrings.t(context, 'no_transactions_yet'),
                        style: const TextStyle(color: AppColors.textSecondary),
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 100),
                      itemCount: list.length,
                      itemBuilder: (context, index) {
                        final t = list[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: TransactionTile(
                            txn: t,
                            onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) =>
                                    AddTransactionScreen(existing: t),
                              ),
                            ),
                            onDelete: () => provider.deleteTransaction(t.id),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(
          context,
        ).push(MaterialPageRoute(builder: (_) => const AddTransactionScreen())),
        child: const Icon(Icons.add_rounded),
      ),
    );
  }

  Widget _filterChip(String label, TxnType? type) {
    final selected = _filter == type;
    return ChoiceChip(
      label: Text(label),
      selected: selected,
      onSelected: (_) => setState(() => _filter = type),
    );
  }
}
