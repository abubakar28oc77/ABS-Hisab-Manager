import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/app_strings.dart';
import '../../../core/utils/formatters.dart';
import '../../../data/models/transaction_model.dart';
import '../../../providers/transaction_provider.dart';

enum ReportPeriod { daily, weekly, monthly, yearly }

/// Flexible financial report: Income / Expense / Net Profit-Loss,
/// switchable between Daily, Weekly, Monthly and Yearly periods.
class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  ReportPeriod _period = ReportPeriod.monthly;
  DateTime _anchor = DateTime.now();

  DateTimeRange _range() {
    switch (_period) {
      case ReportPeriod.daily:
        final start = DateTime(_anchor.year, _anchor.month, _anchor.day);
        return DateTimeRange(start: start, end: start.add(const Duration(days: 1)));
      case ReportPeriod.weekly:
        final weekday = _anchor.weekday; // 1 = Monday
        final start = DateTime(
          _anchor.year,
          _anchor.month,
          _anchor.day,
        ).subtract(Duration(days: weekday - 1));
        return DateTimeRange(start: start, end: start.add(const Duration(days: 7)));
      case ReportPeriod.monthly:
        final start = DateTime(_anchor.year, _anchor.month, 1);
        final end = DateTime(_anchor.year, _anchor.month + 1, 1);
        return DateTimeRange(start: start, end: end);
      case ReportPeriod.yearly:
        final start = DateTime(_anchor.year, 1, 1);
        final end = DateTime(_anchor.year + 1, 1, 1);
        return DateTimeRange(start: start, end: end);
    }
  }

  String _rangeLabel() {
    final r = _range();
    switch (_period) {
      case ReportPeriod.daily:
        return Formatters.date(r.start);
      case ReportPeriod.weekly:
        return '${Formatters.date(r.start)} - ${Formatters.date(r.end.subtract(const Duration(days: 1)))}';
      case ReportPeriod.monthly:
        return Formatters.monthYear(r.start.month, r.start.year);
      case ReportPeriod.yearly:
        return '${r.start.year}';
    }
  }

  void _shift(int direction) {
    setState(() {
      switch (_period) {
        case ReportPeriod.daily:
          _anchor = _anchor.add(Duration(days: direction));
          break;
        case ReportPeriod.weekly:
          _anchor = _anchor.add(Duration(days: 7 * direction));
          break;
        case ReportPeriod.monthly:
          _anchor = DateTime(_anchor.year, _anchor.month + direction, 1);
          break;
        case ReportPeriod.yearly:
          _anchor = DateTime(_anchor.year + direction, _anchor.month, 1);
          break;
      }
    });
  }

  Map<String, double> _breakdown(List<Transaction> txns, TxnType type) {
    final map = <String, double>{};
    for (final t in txns.where((t) => t.type == type)) {
      map[t.category] = (map[t.category] ?? 0) + t.amount;
    }
    return map;
  }

  Future<void> _exportPdf(
    List<Transaction> txns,
    double income,
    double expense,
  ) async {
    final doc = pw.Document();
    final incomeBreak = _breakdown(txns, TxnType.income);
    final expenseBreak = _breakdown(txns, TxnType.expense);
    final net = income - expense;

    doc.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (ctx) => [
          pw.Text(
            'Financial Report - ${_rangeLabel()}',
            style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold),
          ),
          pw.SizedBox(height: 12),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Text('Total Income: ${Formatters.currencyPdf(income)}'),
              pw.Text('Total Expense: ${Formatters.currencyPdf(expense)}'),
              pw.Text(
                'Net Profit/Loss: ${Formatters.currencyPdf(net)}',
              ),
            ],
          ),
          pw.SizedBox(height: 20),
          pw.Text(
            'Income by Category',
            style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 14),
          ),
          pw.SizedBox(height: 6),
          pw.TableHelper.fromTextArray(
            headers: ['Category', 'Amount'],
            data: incomeBreak.entries
                .map((e) => [e.key, Formatters.currencyPdf(e.value)])
                .toList(),
            headerDecoration: const pw.BoxDecoration(color: PdfColors.grey300),
          ),
          pw.SizedBox(height: 20),
          pw.Text(
            'Expense by Category',
            style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 14),
          ),
          pw.SizedBox(height: 6),
          pw.TableHelper.fromTextArray(
            headers: ['Category', 'Amount'],
            data: expenseBreak.entries
                .map((e) => [e.key, Formatters.currencyPdf(e.value)])
                .toList(),
            headerDecoration: const pw.BoxDecoration(color: PdfColors.grey300),
          ),
          pw.SizedBox(height: 20),
          pw.Text(
            'All Transactions',
            style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 14),
          ),
          pw.SizedBox(height: 6),
          pw.TableHelper.fromTextArray(
            headers: ['Date', 'Type', 'Category', 'Amount', 'Note'],
            data: txns
                .map(
                  (t) => [
                    Formatters.date(t.date),
                    t.type.label,
                    t.category,
                    Formatters.currencyPdf(t.amount),
                    t.note ?? '',
                  ],
                )
                .toList(),
            headerDecoration: const pw.BoxDecoration(color: PdfColors.grey300),
          ),
        ],
      ),
    );

    await Printing.sharePdf(
      bytes: await doc.save(),
      filename: 'report_${_period.name}_${_anchor.year}${_anchor.month}${_anchor.day}.pdf',
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TransactionProvider>();
    final r = _range();
    final txns = provider.transactions
        .where((t) => !t.date.isBefore(r.start) && t.date.isBefore(r.end))
        .toList();
    final income = txns
        .where((t) => t.type == TxnType.income)
        .fold(0.0, (s, t) => s + t.amount);
    final expense = txns
        .where((t) => t.type == TxnType.expense)
        .fold(0.0, (s, t) => s + t.amount);
    final net = income - expense;
    final expenseBreak = _breakdown(txns, TxnType.expense);
    final incomeBreak = _breakdown(txns, TxnType.income);

    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.t(context, 'report')),
        actions: [
          IconButton(
            icon: const Icon(Icons.print_rounded),
            tooltip: AppStrings.t(context, 'print_share'),
            onPressed: txns.isEmpty
                ? null
                : () => _exportPdf(txns, income, expense),
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            SizedBox(
              height: 38,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: ReportPeriod.values
                    .map(
                      (p) => Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: ChoiceChip(
                          label: Text(AppStrings.t(context, p.name)),
                          selected: _period == p,
                          onSelected: (_) => setState(() => _period = p),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
            const SizedBox(height: 14),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.chevron_left_rounded),
                    onPressed: () => _shift(-1),
                  ),
                  Expanded(
                    child: Text(
                      _rangeLabel(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontWeight: FontWeight.w700),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.chevron_right_rounded),
                    onPressed: () => _shift(1),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _statCard(
                    AppStrings.t(context, 'income'),
                    income,
                    AppColors.income,
                    Icons.trending_up_rounded,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _statCard(
                    AppStrings.t(context, 'expense'),
                    expense,
                    AppColors.expense,
                    Icons.trending_down_rounded,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            _statCard(
              AppStrings.t(context, 'net_profit_loss'),
              net,
              net >= 0 ? AppColors.income : AppColors.expense,
              Icons.account_balance_wallet_rounded,
              fullWidth: true,
            ),
            const SizedBox(height: 20),
            const Text(
              'Expense by Category',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 10),
            expenseBreak.isEmpty
                ? _emptyBox('No expenses in this period')
                : _breakdownChart(expenseBreak, AppColors.expense),
            const SizedBox(height: 20),
            const Text(
              'Income by Category',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 10),
            incomeBreak.isEmpty
                ? _emptyBox('No income in this period')
                : _breakdownChart(incomeBreak, AppColors.income),
            const SizedBox(height: 20),
            Text(
              'Transactions (${txns.length})',
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 10),
            if (txns.isEmpty)
              _emptyBox('No transactions in this period')
            else
              ...txns.map(
                (t) => Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              t.category,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              Formatters.date(t.date),
                              style: const TextStyle(
                                fontSize: 12,
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        '${t.type == TxnType.income ? '+' : '-'}${Formatters.currency(t.amount)}',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: t.type == TxnType.income
                              ? AppColors.income
                              : AppColors.expense,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.delete_outline_rounded,
                          color: AppColors.expense,
                          size: 20,
                        ),
                        onPressed: () => _confirmDeleteTxn(context, t.id),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _statCard(
    String label,
    double amount,
    Color color,
    IconData icon, {
    bool fullWidth = false,
  }) {
    return Container(
      width: fullWidth ? double.infinity : null,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Icon(icon, color: color),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                  ),
                ),
                Text(
                  Formatters.currency(amount),
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: color,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _breakdownChart(Map<String, double> data, Color baseColor) {
    final total = data.values.fold(0.0, (a, b) => a + b);
    final entries = data.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    final colors = [
      baseColor,
      baseColor.withValues(alpha: 0.75),
      baseColor.withValues(alpha: 0.55),
      baseColor.withValues(alpha: 0.4),
      baseColor.withValues(alpha: 0.28),
      baseColor.withValues(alpha: 0.18),
    ];

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          SizedBox(
            height: 100,
            width: 100,
            child: PieChart(
              PieChartData(
                sectionsSpace: 2,
                centerSpaceRadius: 26,
                sections: List.generate(entries.length, (i) {
                  return PieChartSectionData(
                    value: entries[i].value,
                    color: colors[i % colors.length],
                    title: '',
                    radius: 22,
                  );
                }),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(entries.length, (i) {
                final e = entries[i];
                final pct = total == 0
                    ? '0'
                    : (e.value / total * 100).toStringAsFixed(0);
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  child: Row(
                    children: [
                      Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          color: colors[i % colors.length],
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          e.key,
                          style: const TextStyle(fontSize: 12),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        '$pct%',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  void _confirmDeleteTxn(BuildContext context, String txnId) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(AppStrings.t(context, 'delete')),
        content: const Text(
          'This will permanently delete this transaction. Continue?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(AppStrings.t(context, 'cancel')),
          ),
          TextButton(
            onPressed: () {
              context.read<TransactionProvider>().deleteTransaction(txnId);
              Navigator.pop(ctx);
            },
            child: Text(
              AppStrings.t(context, 'delete'),
              style: const TextStyle(color: AppColors.expense),
            ),
          ),
        ],
      ),
    );
  }

  Widget _emptyBox(String text) => Container(
    width: double.infinity,
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
    ),
    alignment: Alignment.center,
    child: Text(text, style: const TextStyle(color: AppColors.textSecondary)),
  );
}
