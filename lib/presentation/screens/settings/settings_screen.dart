import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/app_strings.dart';
import '../../../data/local/database_helper.dart';
import '../../../providers/auth_provider.dart';
import '../../../providers/locale_provider.dart';
import '../../../providers/student_provider.dart';
import '../../../providers/transaction_provider.dart';
import 'manage_categories_screen.dart';
import 'report_screen.dart';
import 'set_pin_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  Future<void> _exportBackup(BuildContext context) async {
    final json = DatabaseHelper.instance.exportAllToJsonString();
    final bytes = utf8.encode(json);
    await SharePlus.instance.share(
      ShareParams(
        files: [
          XFile.fromData(
            bytes,
            name:
                'abs_hisab_manager_backup_${DateTime.now().millisecondsSinceEpoch}.json',
            mimeType: 'application/json',
          ),
        ],
        text: 'ABS Hisab Manager backup',
      ),
    );
  }

  Future<void> _importBackup(BuildContext context) async {
    final result = await FilePicker.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['json'],
      withData: true,
    );
    if (result == null || result.files.isEmpty) return;
    final bytes = result.files.first.bytes;
    if (bytes == null) return;

    final jsonStr = utf8.decode(bytes);
    await DatabaseHelper.instance.importFromJsonString(jsonStr);
    if (context.mounted) {
      context.read<StudentProvider>().loadStudents();
      context.read<TransactionProvider>().loadTransactions();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Backup restored successfully')),
      );
    }
  }

  void _confirmClearData(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Clear All Data'),
        content: const Text(
          'This will permanently delete all students, payments and transactions. This cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(AppStrings.t(context, 'cancel')),
          ),
          TextButton(
            onPressed: () async {
              await DatabaseHelper.instance.clearAllData();
              if (ctx.mounted) {
                context.read<StudentProvider>().loadStudents();
                context.read<TransactionProvider>().loadTransactions();
                Navigator.pop(ctx);
              }
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
    final auth = context.watch<AuthProvider>();
    final locale = context.watch<LocaleProvider>();

    return Scaffold(
      appBar: AppBar(title: Text(AppStrings.t(context, 'settings'))),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _sectionTitle(AppStrings.t(context, 'language')),
            Card(
              margin: const EdgeInsets.only(bottom: 10),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                child: Row(
                  children: [
                    const Icon(Icons.language_rounded, color: AppColors.primary),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        AppStrings.t(context, 'language'),
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                    ToggleButtons(
                      isSelected: [
                        !locale.isBangla,
                        locale.isBangla,
                      ],
                      onPressed: (index) {
                        locale.setLanguage(
                          index == 0
                              ? AppLanguage.english
                              : AppLanguage.bangla,
                        );
                      },
                      borderRadius: BorderRadius.circular(8),
                      selectedColor: Colors.white,
                      fillColor: AppColors.primary,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 14),
                          child: Text(AppStrings.t(context, 'english')),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 14),
                          child: Text(AppStrings.t(context, 'bangla')),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            _sectionTitle(AppStrings.t(context, 'security')),
            _tile(
              icon: Icons.lock_outline_rounded,
              title: auth.hasPin ? 'Change PIN' : 'Set PIN',
              subtitle: 'Protect app with a 4-digit PIN',
              onTap: () => Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (_) => const SetPinScreen())),
            ),
            if (auth.hasPin)
              SwitchListTile(
                value: auth.biometricEnabled,
                onChanged: (v) => auth.setBiometricEnabled(v),
                title: const Text('Biometric Unlock'),
                subtitle: const Text('Use fingerprint/face unlock'),
                activeThumbColor: AppColors.primary,
              ),
            if (auth.hasPin)
              _tile(
                icon: Icons.lock_reset_rounded,
                title: 'Remove PIN',
                subtitle: 'Disable app lock',
                onTap: () async {
                  await auth.removePin();
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('PIN removed')),
                    );
                  }
                },
              ),
            const SizedBox(height: 20),
            _sectionTitle(AppStrings.t(context, 'finance')),
            _tile(
              icon: Icons.category_rounded,
              title: 'Manage Categories',
              subtitle: 'Add, rename or delete income/expense categories',
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const ManageCategoriesScreen(),
                ),
              ),
            ),
            _tile(
              icon: Icons.bar_chart_rounded,
              title: AppStrings.t(context, 'report'),
              subtitle:
                  'Income, Expense & Net Profit/Loss — Daily/Weekly/Monthly/Yearly',
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const ReportScreen()),
              ),
            ),
            const SizedBox(height: 20),
            _sectionTitle(AppStrings.t(context, 'data_backup')),
            _tile(
              icon: Icons.upload_file_rounded,
              title: 'Export Backup (JSON)',
              subtitle: 'Save all data as a JSON file',
              onTap: () => _exportBackup(context),
            ),
            _tile(
              icon: Icons.download_rounded,
              title: 'Import Backup (JSON)',
              subtitle: 'Restore data from a JSON file',
              onTap: () => _importBackup(context),
            ),
            _tile(
              icon: Icons.delete_forever_rounded,
              title: 'Clear All Data',
              subtitle: 'Permanently delete all local data',
              color: AppColors.expense,
              onTap: () => _confirmClearData(context),
            ),
            const SizedBox(height: 20),
            _sectionTitle(AppStrings.t(context, 'about')),
            ListTile(
              leading: const Icon(Icons.info_outline_rounded),
              title: Text(AppStrings.t(context, 'app_name')),
              subtitle: const Text('Version 1.0.0 · Local-first storage'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) => Padding(
    padding: const EdgeInsets.only(bottom: 8, left: 4),
    child: Text(
      title,
      style: const TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w700,
        color: AppColors.textSecondary,
      ),
    ),
  );

  Widget _tile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    Color? color,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        leading: Icon(icon, color: color ?? AppColors.primary),
        title: Text(title, style: TextStyle(color: color)),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.chevron_right_rounded),
        onTap: onTap,
      ),
    );
  }
}
