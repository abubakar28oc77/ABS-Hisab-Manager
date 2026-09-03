import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/app_strings.dart';
import '../../../core/utils/fee_calculator.dart';
import '../../../core/utils/formatters.dart';
import '../../../providers/payment_provider.dart';
import '../../../providers/student_provider.dart';
import 'add_student_screen.dart';
import 'student_detail_screen.dart';

enum StudentStatusFilter { all, due, paid, advance }

class StudentsScreen extends StatefulWidget {
  const StudentsScreen({super.key});

  @override
  State<StudentsScreen> createState() => _StudentsScreenState();
}

class _StudentsScreenState extends State<StudentsScreen> {
  String _query = '';
  String _classFilter = 'All';
  StudentStatusFilter _statusFilter = StudentStatusFilter.all;

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<StudentProvider>();
    final paymentProvider = context.watch<PaymentProvider>();
    final classOptions = ['All', ...AppConstants.classGrades];

    final students = provider.students.where((s) {
      // 1. Text Query (Name, Roll, Father Name, Phone)
      final q = _query.trim().toLowerCase();
      if (q.isNotEmpty) {
        final matchesName = s.name.toLowerCase().contains(q);
        final matchesRoll = s.rollNumber.toLowerCase().contains(q);
        final matchesFather = s.fatherName.toLowerCase().contains(q);
        final matchesPhone = s.fatherPhone.toLowerCase().contains(q);
        if (!matchesName && !matchesRoll && !matchesFather && !matchesPhone) {
          return false;
        }
      }

      // 2. Class Grade filter
      if (_classFilter != 'All' && s.className != _classFilter) {
        return false;
      }

      // 3. Payment Status filter
      if (_statusFilter != StudentStatusFilter.all) {
        final totalPaid = paymentProvider.totalPaid(s.id);
        final due = FeeCalculator.due(s, totalPaid);
        final advance = FeeCalculator.advance(s, totalPaid);

        if (_statusFilter == StudentStatusFilter.due && due <= 0) return false;
        if (_statusFilter == StudentStatusFilter.paid && (due > 0 || advance > 0)) {
          return false;
        }
        if (_statusFilter == StudentStatusFilter.advance && advance <= 0) {
          return false;
        }
      }

      return true;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.t(context, 'students')),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '${students.length} ${AppStrings.t(context, 'students')}',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                decoration: InputDecoration(
                  hintText: AppStrings.t(context, 'search_students'),
                  prefixIcon: const Icon(Icons.search_rounded),
                  suffixIcon: _query.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear_rounded),
                          onPressed: () => setState(() => _query = ''),
                        )
                      : null,
                ),
                onChanged: (v) => setState(() => _query = v),
              ),
            ),
            const SizedBox(height: 10),
            // Status Filters (All, Due, Paid, Advance)
            SizedBox(
              height: 36,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  _statusChip(
                    StudentStatusFilter.all,
                    AppStrings.t(context, 'filter_all'),
                    AppColors.primary,
                  ),
                  const SizedBox(width: 8),
                  _statusChip(
                    StudentStatusFilter.due,
                    AppStrings.t(context, 'filter_due'),
                    AppColors.expense,
                  ),
                  const SizedBox(width: 8),
                  _statusChip(
                    StudentStatusFilter.paid,
                    AppStrings.t(context, 'filter_paid'),
                    AppColors.income,
                  ),
                  const SizedBox(width: 8),
                  _statusChip(
                    StudentStatusFilter.advance,
                    AppStrings.t(context, 'filter_advance'),
                    AppColors.secondary,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            // Class Grades (All, Six, Seven, Eight, Nine, Ten)
            SizedBox(
              height: 36,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: classOptions.length,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (context, i) {
                  final c = classOptions[i];
                  final selected = _classFilter == c;
                  return ChoiceChip(
                    label: Text(
                      c == 'All' ? AppStrings.t(context, 'all') : c,
                    ),
                    selected: selected,
                    onSelected: (_) => setState(() => _classFilter = c),
                  );
                },
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: students.isEmpty
                  ? _emptyState(context)
                  : ListView.builder(
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 100),
                      itemCount: students.length,
                      itemBuilder: (context, index) {
                        final s = students[index];
                        final totalPaid = paymentProvider.totalPaid(s.id);
                        final due = FeeCalculator.due(s, totalPaid);
                        final advance = FeeCalculator.advance(s, totalPaid);
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Material(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(16),
                              onTap: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) =>
                                      StudentDetailScreen(student: s),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(14),
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 22,
                                      backgroundColor: AppColors.primary
                                          .withValues(alpha: 0.1),
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
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            s.name,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 15,
                                            ),
                                          ),
                                          Text(
                                            '${s.className} · Roll ${s.rollNumber} · Sec ${s.section}',
                                            style: const TextStyle(
                                              color: AppColors.textSecondary,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          Formatters.currency(s.monthlyFee),
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 8,
                                            vertical: 3,
                                          ),
                                          decoration: BoxDecoration(
                                            color: (due > 0
                                                    ? AppColors.overdue
                                                    : AppColors.paid)
                                                .withValues(alpha: 0.12),
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: Text(
                                            due > 0
                                                ? '${AppStrings.t(context, 'due')}: ${Formatters.currency(due)}'
                                                : advance > 0
                                                ? '${AppStrings.t(context, 'advance')}: ${Formatters.currency(advance)}'
                                                : '${AppStrings.t(context, 'due')}: ${Formatters.currency(0)}',
                                            style: TextStyle(
                                              color: due > 0
                                                  ? AppColors.overdue
                                                  : AppColors.paid,
                                              fontSize: 11,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
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
        ).push(MaterialPageRoute(builder: (_) => const AddStudentScreen())),
        child: const Icon(Icons.person_add_rounded),
      ),
    );
  }

  Widget _statusChip(StudentStatusFilter filter, String label, Color color) {
    final selected = _statusFilter == filter;
    return FilterChip(
      label: Text(label),
      selected: selected,
      selectedColor: color.withValues(alpha: 0.15),
      labelStyle: TextStyle(
        color: selected ? color : AppColors.textPrimary,
        fontWeight: selected ? FontWeight.w700 : FontWeight.normal,
      ),
      onSelected: (_) => setState(() => _statusFilter = filter),
    );
  }

  Widget _emptyState(BuildContext context) => Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.people_outline_rounded,
          size: 64,
          color: AppColors.textSecondary.withValues(alpha: 0.4),
        ),
        const SizedBox(height: 12),
        Text(
          AppStrings.t(context, 'no_students_yet'),
          style: const TextStyle(color: AppColors.textSecondary),
        ),
        const SizedBox(height: 4),
        Text(
          AppStrings.t(context, 'tap_add_student'),
          style: const TextStyle(color: AppColors.textSecondary, fontSize: 12),
        ),
      ],
    ),
  );
}
