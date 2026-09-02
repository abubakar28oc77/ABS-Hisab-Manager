import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/app_strings.dart';
import '../../../core/utils/fee_calculator.dart';
import '../../../core/utils/formatters.dart';
import '../../../data/models/student_model.dart';
import '../../../providers/payment_provider.dart';
import '../../../providers/student_provider.dart';
import '../../../providers/transaction_provider.dart';
import '../../widgets/summary_card.dart';
import '../../widgets/transaction_tile.dart';
import '../../navigation/main_nav.dart';
import '../students/add_student_screen.dart';
import '../students/collect_payment_screen.dart';
import '../settings/report_screen.dart';
import '../transactions/add_transaction_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  void _showStudentPickerForPayment(BuildContext context) {
    final studentProvider = context.read<StudentProvider>();
    final paymentProvider = context.read<PaymentProvider>();
    final students = studentProvider.students;

    if (students.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppStrings.t(context, 'no_students_yet'))),
      );
      return;
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) {
        return DraggableScrollableSheet(
          initialChildSize: 0.6,
          minChildSize: 0.4,
          maxChildSize: 0.9,
          expand: false,
          builder: (_, scrollCtrl) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Column(
                children: [
                  Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    AppStrings.t(context, 'select_student'),
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Expanded(
                    child: ListView.separated(
                      controller: scrollCtrl,
                      itemCount: students.length,
                      separatorBuilder: (_, _) => const Divider(height: 1),
                      itemBuilder: (c, i) {
                        final s = students[i];
                        final totalPaid = paymentProvider.totalPaid(s.id);
                        final due = FeeCalculator.due(s, totalPaid);
                        return ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          leading: CircleAvatar(
                            backgroundColor: AppColors.primary.withValues(
                              alpha: 0.1,
                            ),
                            child: Text(
                              s.name.isNotEmpty
                                  ? s.name[0].toUpperCase()
                                  : '?',
                              style: const TextStyle(
                                color: AppColors.primary,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          title: Text(
                            s.name,
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                          subtitle: Text(
                            '${s.className} · Roll ${s.rollNumber}',
                            style: const TextStyle(
                              color: AppColors.textSecondary,
                              fontSize: 12,
                            ),
                          ),
                          trailing: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                Formatters.currency(s.monthlyFee),
                                style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              if (due > 0)
                                Text(
                                  '${AppStrings.t(context, 'due')}: ${Formatters.currency(due)}',
                                  style: const TextStyle(
                                    fontSize: 11,
                                    color: AppColors.expense,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                            ],
                          ),
                          onTap: () {
                            Navigator.pop(ctx);
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) =>
                                    CollectPaymentScreen(student: s),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final txnProvider = context.watch<TransactionProvider>();
    final studentProvider = context.watch<StudentProvider>();
    final paymentProvider = context.watch<PaymentProvider>();

    final pendingFees = studentProvider.students.fold(0.0, (sum, s) {
      final due = FeeCalculator.due(s, paymentProvider.totalPaid(s.id));
      return sum + due;
    });

    final now = DateTime.now();
    final thisMonthIncome = txnProvider.incomeForMonth(now.month, now.year);
    final thisMonthExpense = txnProvider.expenseForMonth(now.month, now.year);
    final thisMonthNet = thisMonthIncome - thisMonthExpense;

    final lastMonthDate = DateTime(now.year, now.month - 1, 1);
    final lastMonthIncome = txnProvider.incomeForMonth(
      lastMonthDate.month,
      lastMonthDate.year,
    );
    final lastMonthExpense = txnProvider.expenseForMonth(
      lastMonthDate.month,
      lastMonthDate.year,
    );
    final lastMonthNet = lastMonthIncome - lastMonthExpense;
    final netDelta = thisMonthNet - lastMonthNet;

    final breakdown = txnProvider.categoryBreakdown();
    final total = breakdown.values.fold(0.0, (a, b) => a + b);

    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            txnProvider.loadTransactions();
            studentProvider.loadStudents();
            paymentProvider.loadPayments();
          },
          child: ListView(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 100),
            children: [
              _buildHeader(context),
              const SizedBox(height: 18),
              _buildBalanceCard(context, thisMonthNet, netDelta),
              const SizedBox(height: 16),
              _buildQuickActions(context),
              const SizedBox(height: 16),
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 1.5,
                children: [
                  SummaryCard(
                    label: AppStrings.t(context, 'total_income_month'),
                    amount: thisMonthIncome,
                    icon: Icons.trending_up_rounded,
                    color: AppColors.income,
                  ),
                  SummaryCard(
                    label: AppStrings.t(context, 'total_expense_month'),
                    amount: thisMonthExpense,
                    icon: Icons.trending_down_rounded,
                    color: AppColors.expense,
                  ),
                  SummaryCard(
                    label: AppStrings.t(context, 'pending_fees'),
                    amount: pendingFees,
                    icon: Icons.hourglass_bottom_rounded,
                    color: AppColors.pending,
                  ),
                  SummaryCard(
                    label: AppStrings.t(context, 'students'),
                    amount: studentProvider.students.length.toDouble(),
                    icon: Icons.people_alt_rounded,
                    color: AppColors.secondary,
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Text(
                AppStrings.t(context, 'expense_breakdown'),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 12),
              if (total == 0)
                _emptyState(AppStrings.t(context, 'no_expenses_recorded'))
              else
                _buildBreakdownChart(breakdown, total),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppStrings.t(context, 'recent_transactions'),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  TextButton(
                    onPressed: () => MainNav.switchTab(context, 2),
                    child: Text(AppStrings.t(context, 'see_all')),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              if (txnProvider.recent.isEmpty)
                _emptyState(AppStrings.t(context, 'no_transactions_yet'))
              else
                ...txnProvider.recent.map(
                  (t) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: TransactionTile(
                      txn: t,
                      onDelete: () => txnProvider.deleteTransaction(t.id),
                    ),
                  ),
                ),
            ],
          ),
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

  Widget _buildQuickActions(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _quickActionBtn(
            context,
            icon: Icons.payments_rounded,
            label: AppStrings.t(context, 'quick_collect_fee'),
            color: AppColors.income,
            onTap: () => _showStudentPickerForPayment(context),
          ),
          _quickActionBtn(
            context,
            icon: Icons.person_add_rounded,
            label: AppStrings.t(context, 'quick_add_student'),
            color: AppColors.primary,
            onTap: () => Navigator.of(
              context,
            ).push(MaterialPageRoute(builder: (_) => const AddStudentScreen())),
          ),
          _quickActionBtn(
            context,
            icon: Icons.add_circle_outline_rounded,
            label: AppStrings.t(context, 'quick_add_expense'),
            color: AppColors.expense,
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => const AddTransactionScreen(),
              ),
            ),
          ),
          _quickActionBtn(
            context,
            icon: Icons.bar_chart_rounded,
            label: AppStrings.t(context, 'quick_reports'),
            color: AppColors.secondary,
            onTap: () => Navigator.of(
              context,
            ).push(MaterialPageRoute(builder: (_) => const ReportScreen())),
          ),
        ],
      ),
    );
  }

  Widget _quickActionBtn(
    BuildContext context, {
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: color.withValues(alpha: 0.12),
              child: Icon(icon, color: color, size: 20),
            ),
            const SizedBox(height: 6),
            Text(
              label,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final now = DateTime.now();
    final greetingKey = now.hour < 12
        ? 'good_morning'
        : now.hour < 17
        ? 'good_afternoon'
        : 'good_evening';
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppStrings.t(context, greetingKey),
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: 13,
              ),
            ),
            Text(
              AppStrings.t(context, 'app_name'),
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
            ),
          ],
        ),
        CircleAvatar(
          radius: 20,
          backgroundColor: AppColors.primary.withValues(alpha: 0.1),
          child: const Icon(Icons.person, color: AppColors.primary),
        ),
      ],
    );
  }

  Widget _buildBalanceCard(
    BuildContext context,
    double thisMonthNet,
    double netDelta,
  ) {
    final isUp = netDelta >= 0;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.primary, AppColors.primaryDark],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.3),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.t(context, 'net_balance'),
            style: const TextStyle(color: Colors.white70, fontSize: 13),
          ),
          const SizedBox(height: 6),
          Text(
            Formatters.currency(thisMonthNet),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Icon(
                isUp ? Icons.arrow_upward_rounded : Icons.arrow_downward_rounded,
                color: isUp ? Colors.greenAccent : Colors.redAccent,
                size: 16,
              ),
              const SizedBox(width: 4),
              Text(
                '${isUp ? '+' : ''}${Formatters.currency(netDelta)} ${AppStrings.t(context, 'vs_last_month')}',
                style: TextStyle(
                  color: isUp ? Colors.greenAccent : Colors.redAccent,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBreakdownChart(Map<String, double> breakdown, double total) {
    final colors = [
      AppColors.primary,
      AppColors.secondary,
      AppColors.pending,
      AppColors.expense,
      Colors.purple,
      Colors.teal,
      Colors.brown,
    ];
    final entries = breakdown.entries.toList();

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          SizedBox(
            height: 120,
            width: 120,
            child: PieChart(
              PieChartData(
                sectionsSpace: 2,
                centerSpaceRadius: 32,
                sections: List.generate(entries.length, (i) {
                  final e = entries[i];
                  return PieChartSectionData(
                    value: e.value,
                    color: colors[i % colors.length],
                    title: '',
                    radius: 24,
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
                final pct = (e.value / total * 100).toStringAsFixed(0);
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

  Widget _emptyState(String text) => Container(
    width: double.infinity,
    padding: const EdgeInsets.all(24),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
    ),
    alignment: Alignment.center,
    child: Text(text, style: const TextStyle(color: AppColors.textSecondary)),
  );
}
