import 'package:flutter/material.dart';
import '../../core/constants/app_constants.dart';
import '../../core/theme/app_theme.dart';
import '../../core/utils/formatters.dart';
import '../../data/models/transaction_model.dart';

IconData categoryIcon(String category) {
  switch (category) {
    case 'Tuition':
      return Icons.school_rounded;
    case 'Food':
      return Icons.restaurant_rounded;
    case 'Travel':
      return Icons.directions_car_rounded;
    case 'Books':
      return Icons.menu_book_rounded;
    case 'Bills':
      return Icons.receipt_long_rounded;
    case 'Rent':
      return Icons.home_rounded;
    case 'Shopping':
      return Icons.shopping_bag_rounded;
    case 'Salary':
      return Icons.payments_rounded;
    case 'Bonus':
      return Icons.card_giftcard_rounded;
    default:
      return Icons.category_rounded;
  }
}

class TransactionTile extends StatelessWidget {
  final Transaction txn;
  final VoidCallback? onTap;
  final VoidCallback? onDelete;

  const TransactionTile({
    super.key,
    required this.txn,
    this.onTap,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final isIncome = txn.type == TxnType.income;
    final color = isIncome ? AppColors.income : AppColors.expense;

    return Dismissible(
      key: ValueKey(txn.id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        decoration: BoxDecoration(
          color: AppColors.expense,
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Icon(Icons.delete_rounded, color: Colors.white),
      ),
      onDismissed: (_) => onDelete?.call(),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(categoryIcon(txn.category), color: color),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        txn.category,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '${Formatters.date(txn.date)}${txn.note != null && txn.note!.isNotEmpty ? ' · ${txn.note}' : ''}',
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.textSecondary,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                Text(
                  '${isIncome ? '+' : '-'}${Formatters.currency(txn.amount)}',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: color,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
