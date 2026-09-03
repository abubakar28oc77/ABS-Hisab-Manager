import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/app_strings.dart';
import '../../../data/models/class_model.dart';
import '../../../providers/class_provider.dart';
import '../../../providers/student_provider.dart';

class ClassesScreen extends StatelessWidget {
  const ClassesScreen({super.key});

  void _showAddEditClassDialog(BuildContext context, {ClassItem? existing}) {
    final nameCtrl = TextEditingController(text: existing?.name ?? '');
    final sections = List<String>.from(existing?.sections ?? ['A', 'B']);
    final subjects = List<String>.from(
      existing?.subjects ??
          ['Bangla', 'English', 'Mathematics', 'General Science'],
    );
    final secInputCtrl = TextEditingController();
    final subInputCtrl = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) {
        return StatefulBuilder(
          builder: (modalCtx, setModalState) {
            return Padding(
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
                top: 20,
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 24,
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        width: 40,
                        height: 4,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      existing != null
                          ? AppStrings.t(context, 'edit_class')
                          : AppStrings.t(context, 'add_class'),
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: nameCtrl,
                      decoration: InputDecoration(
                        labelText: '${AppStrings.t(context, 'class_name')} *',
                        hintText: 'e.g. Class 9, Class 10, HSC Batch',
                        prefixIcon: const Icon(Icons.school_rounded),
                      ),
                    ),
                    const SizedBox(height: 18),
                    // Sections
                    Text(
                      AppStrings.t(context, 'sections'),
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        ...sections.map(
                          (sec) => Chip(
                            label: Text(sec),
                            deleteIcon: const Icon(Icons.close, size: 16),
                            onDeleted: () {
                              setModalState(() => sections.remove(sec));
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: secInputCtrl,
                            decoration: const InputDecoration(
                              hintText: 'Add section (e.g. A, B, Morning, Science)',
                              isDense: true,
                            ),
                            onSubmitted: (v) {
                              if (v.trim().isNotEmpty &&
                                  !sections.contains(v.trim())) {
                                setModalState(() {
                                  sections.add(v.trim());
                                  secInputCtrl.clear();
                                });
                              }
                            },
                          ),
                        ),
                        const SizedBox(width: 8),
                        IconButton.filled(
                          onPressed: () {
                            if (secInputCtrl.text.trim().isNotEmpty &&
                                !sections.contains(secInputCtrl.text.trim())) {
                              setModalState(() {
                                sections.add(secInputCtrl.text.trim());
                                secInputCtrl.clear();
                              });
                            }
                          },
                          icon: const Icon(Icons.add_rounded),
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),
                    // Subjects
                    Text(
                      AppStrings.t(context, 'subjects'),
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        ...subjects.map(
                          (sub) => Chip(
                            label: Text(sub),
                            backgroundColor:
                                AppColors.primary.withValues(alpha: 0.1),
                            labelStyle: const TextStyle(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w600,
                            ),
                            deleteIcon: const Icon(Icons.close, size: 16),
                            onDeleted: () {
                              setModalState(() => subjects.remove(sub));
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: subInputCtrl,
                            decoration: const InputDecoration(
                              hintText: 'Add subject (e.g. Physics, Math, ICT)',
                              isDense: true,
                            ),
                            onSubmitted: (v) {
                              if (v.trim().isNotEmpty &&
                                  !subjects.contains(v.trim())) {
                                setModalState(() {
                                  subjects.add(v.trim());
                                  subInputCtrl.clear();
                                });
                              }
                            },
                          ),
                        ),
                        const SizedBox(width: 8),
                        IconButton.filled(
                          onPressed: () {
                            if (subInputCtrl.text.trim().isNotEmpty &&
                                !subjects.contains(subInputCtrl.text.trim())) {
                              setModalState(() {
                                subjects.add(subInputCtrl.text.trim());
                                subInputCtrl.clear();
                              });
                            }
                          },
                          icon: const Icon(Icons.add_rounded),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (nameCtrl.text.trim().isEmpty) return;
                          final provider = context.read<ClassProvider>();
                          if (existing != null) {
                            existing.name = nameCtrl.text.trim();
                            existing.sections = sections;
                            existing.subjects = subjects;
                            await provider.updateClass(existing);
                          } else {
                            await provider.addClass(
                              name: nameCtrl.text.trim(),
                              sections: sections,
                              subjects: subjects,
                            );
                          }
                          if (modalCtx.mounted) Navigator.pop(modalCtx);
                        },
                        child: Text(
                          existing != null
                              ? AppStrings.t(context, 'update_student').replaceAll('শিক্ষার্থী', 'শ্রেণি').replaceAll('তথ্য', 'শ্রেণি')
                              : AppStrings.t(context, 'add_class'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _confirmDeleteClass(BuildContext context, ClassItem item) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(AppStrings.t(context, 'delete')),
        content: Text('Are you sure you want to remove "${item.name}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(AppStrings.t(context, 'cancel')),
          ),
          TextButton(
            onPressed: () {
              context.read<ClassProvider>().deleteClass(item.id);
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

  @override
  Widget build(BuildContext context) {
    final classProvider = context.watch<ClassProvider>();
    final studentProvider = context.watch<StudentProvider>();
    final classes = classProvider.classes;

    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.t(context, 'manage_classes')),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_rounded),
            tooltip: AppStrings.t(context, 'add_class'),
            onPressed: () => _showAddEditClassDialog(context),
          ),
        ],
      ),
      body: SafeArea(
        child: classes.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.school_outlined,
                      size: 64,
                      color: AppColors.textSecondary.withValues(alpha: 0.4),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'No classes added yet',
                      style: TextStyle(color: AppColors.textSecondary),
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton.icon(
                      onPressed: () => _showAddEditClassDialog(context),
                      icon: const Icon(Icons.add_rounded),
                      label: Text(AppStrings.t(context, 'add_class')),
                    ),
                  ],
                ),
              )
            : ListView.separated(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 100),
                itemCount: classes.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final c = classes[index];
                  final studentCount = studentProvider.students
                      .where(
                        (s) =>
                            s.className.toLowerCase() ==
                            c.name.toLowerCase(),
                      )
                      .length;

                  return Container(
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
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 20,
                              backgroundColor:
                                  AppColors.primary.withValues(alpha: 0.1),
                              child: const Icon(
                                Icons.school_rounded,
                                color: AppColors.primary,
                                size: 20,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    c.name,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16,
                                    ),
                                  ),
                                  Text(
                                    '$studentCount ${AppStrings.t(context, 'students')}',
                                    style: const TextStyle(
                                      color: AppColors.textSecondary,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.edit_rounded, size: 20),
                              color: AppColors.primary,
                              onPressed: () =>
                                  _showAddEditClassDialog(context, existing: c),
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.delete_outline_rounded,
                                size: 20,
                              ),
                              color: AppColors.expense,
                              onPressed: () => _confirmDeleteClass(context, c),
                            ),
                          ],
                        ),
                        const Divider(height: 20),
                        // Sections
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${AppStrings.t(context, 'sections')}: ',
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 13,
                                color: AppColors.textSecondary,
                              ),
                            ),
                            Expanded(
                              child: Wrap(
                                spacing: 6,
                                runSpacing: 4,
                                children: c.sections
                                    .map(
                                      (s) => Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 2,
                                        ),
                                        decoration: BoxDecoration(
                                          color: AppColors.background,
                                          borderRadius:
                                              BorderRadius.circular(6),
                                          border: Border.all(
                                            color: Colors.grey.shade300,
                                          ),
                                        ),
                                        child: Text(
                                          s,
                                          style: const TextStyle(
                                            fontSize: 11,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    )
                                    .toList(),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        // Subjects
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${AppStrings.t(context, 'subjects')}: ',
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 13,
                                color: AppColors.textSecondary,
                              ),
                            ),
                            Expanded(
                              child: Wrap(
                                spacing: 6,
                                runSpacing: 4,
                                children: c.subjects
                                    .map(
                                      (sub) => Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 2,
                                        ),
                                        decoration: BoxDecoration(
                                          color: AppColors.primary
                                              .withValues(alpha: 0.08),
                                          borderRadius:
                                              BorderRadius.circular(6),
                                        ),
                                        child: Text(
                                          sub,
                                          style: const TextStyle(
                                            fontSize: 11,
                                            fontWeight: FontWeight.w600,
                                            color: AppColors.primary,
                                          ),
                                        ),
                                      ),
                                    )
                                    .toList(),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddEditClassDialog(context),
        child: const Icon(Icons.add_rounded),
      ),
    );
  }
}
