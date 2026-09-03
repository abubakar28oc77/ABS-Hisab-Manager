import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/app_strings.dart';
import '../../../core/utils/fee_calculator.dart';
import '../../../core/utils/formatters.dart';
import '../../../data/models/payment_model.dart';
import '../../../data/models/student_model.dart';
import '../../../providers/locale_provider.dart';
import '../../../providers/payment_provider.dart';
import '../../../providers/student_provider.dart';
import 'add_student_screen.dart';
import 'collect_payment_screen.dart';

class StudentDetailScreen extends StatefulWidget {
  final Student student;
  const StudentDetailScreen({super.key, required this.student});

  @override
  State<StudentDetailScreen> createState() => _StudentDetailScreenState();
}

class _StudentDetailScreenState extends State<StudentDetailScreen> {
  late int _attMonth;
  late int _attYear;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _attMonth = now.month;
    _attYear = now.year;
  }

  Future<void> _callNumber(BuildContext context, String phone) async {
    if (phone.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppStrings.t(context, 'no_phone_msg'))),
      );
      return;
    }
    final uri = Uri(scheme: 'tel', path: phone);
    if (!await launchUrl(uri)) {
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Unable to place call')));
      }
    }
  }

  Future<void> _messageNumber(BuildContext context, String phone) async {
    if (phone.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppStrings.t(context, 'no_phone_msg'))),
      );
      return;
    }
    final uri = Uri(scheme: 'sms', path: phone);
    if (!await launchUrl(uri)) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Unable to open messages')),
        );
      }
    }
  }

  Future<void> _sendDueReminderSms(
    BuildContext context,
    Student student,
    double due,
  ) async {
    if (student.fatherPhone.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppStrings.t(context, 'no_phone_msg'))),
      );
      return;
    }
    if (due <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppStrings.t(context, 'no_due_msg'))),
      );
      return;
    }

    final isBn = context.read<LocaleProvider>().isBangla;
    final body = isBn
        ? 'সম্মানিত অভিভাবক, আপনার সন্তান ${student.name} (শ্রেণি: ${student.className}, রোল: ${student.rollNumber})-এর টিউশন ফি বাবদ ৳${due.toStringAsFixed(0)} বকেয়া রয়েছে। অনুগ্রহ করে দ্রুত পরিশোধ করুন। ধন্যবাদ - ABS Hisab Manager'
        : 'Dear Parent, Tuition fee of Tk ${due.toStringAsFixed(0)} is due for your child ${student.name} (Class: ${student.className}, Roll: ${student.rollNumber}). Kindly arrange the payment. Thank you - ABS Hisab Manager';

    final uri = Uri(
      scheme: 'sms',
      path: student.fatherPhone.trim(),
      queryParameters: {'body': body},
    );

    if (!await launchUrl(uri)) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not launch SMS app')),
        );
      }
    }
  }

  Future<void> _printReceipt(Student s, Payment payment) async {
    final doc = pw.Document();
    doc.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a5,
        build: (ctx) => pw.Padding(
          padding: const pw.EdgeInsets.all(24),
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Center(
                child: pw.Text(
                  'ABS Hisab Manager',
                  style: pw.TextStyle(
                    fontSize: 18,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ),
              pw.Center(child: pw.Text('Money Receipt')),
              pw.SizedBox(height: 16),
              pw.Divider(),
              _pdfRow('Receipt No', payment.receiptNo),
              _pdfRow('Date', Formatters.date(payment.paymentDate)),
              _pdfRow('Student', s.name),
              _pdfRow(
                'Class / Roll',
                '${s.className} - ${s.rollNumber} (${s.section})',
              ),
              _pdfRow('For Month', payment.forMonth),
              _pdfRow('Method', payment.method.label),
              if (payment.note != null && payment.note!.isNotEmpty)
                _pdfRow('Note', payment.note!),
              pw.Divider(),
              pw.SizedBox(height: 8),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text(
                    'Amount Paid',
                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                  ),
                  pw.Text(
                    Formatters.currencyPdf(payment.amount),
                    style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              pw.SizedBox(height: 30),
              pw.Text('Thank you!'),
            ],
          ),
        ),
      ),
    );
    await Printing.sharePdf(
      bytes: await doc.save(),
      filename: 'receipt_${payment.receiptNo}.pdf',
    );
  }

  Future<void> _generateStatementPdf(
    Student s,
    List<Payment> history,
    double expected,
    double paid,
    double due,
    double advance,
  ) async {
    final doc = pw.Document();
    final totalAttendance = s.attendance.values.fold(0, (a, b) => a + b);

    doc.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (ctx) => [
          pw.Center(
            child: pw.Text(
              'ABS Hisab Manager',
              style: pw.TextStyle(fontSize: 22, fontWeight: pw.FontWeight.bold),
            ),
          ),
          pw.Center(
            child: pw.Text(
              'Student Financial Statement & Ledger',
              style: const pw.TextStyle(fontSize: 14, color: PdfColors.grey700),
            ),
          ),
          pw.SizedBox(height: 16),
          pw.Divider(),
          pw.SizedBox(height: 8),
          pw.Row(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text(
                    'Student: ${s.name}',
                    style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  pw.SizedBox(height: 4),
                  pw.Text('Class: ${s.className}  |  Roll: ${s.rollNumber}  |  Sec: ${s.section}'),
                  pw.SizedBox(height: 4),
                  pw.Text('Admission Date: ${Formatters.date(s.admissionDate)}'),
                  if (s.address.isNotEmpty) ...[
                    pw.SizedBox(height: 4),
                    pw.Text('Address: ${s.address}'),
                  ],
                ],
              ),
              pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.end,
                children: [
                  pw.Text('Monthly Fee: ${Formatters.currencyPdf(s.monthlyFee)}'),
                  pw.SizedBox(height: 4),
                  pw.Text("Father: ${s.fatherName.isEmpty ? '—' : s.fatherName}"),
                  pw.SizedBox(height: 4),
                  pw.Text("Mobile: ${s.fatherPhone.isEmpty ? '—' : s.fatherPhone}"),
                  pw.SizedBox(height: 4),
                  pw.Text('Total Classes Attended: $totalAttendance'),
                ],
              ),
            ],
          ),
          pw.SizedBox(height: 16),
          pw.Container(
            padding: const pw.EdgeInsets.all(12),
            decoration: pw.BoxDecoration(
              color: PdfColors.grey100,
              borderRadius: const pw.BorderRadius.all(pw.Radius.circular(8)),
            ),
            child: pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
              children: [
                _pdfSummaryItem('Total Expected', Formatters.currencyPdf(expected)),
                _pdfSummaryItem('Total Paid', Formatters.currencyPdf(paid)),
                _pdfSummaryItem('Current Due', Formatters.currencyPdf(due)),
                _pdfSummaryItem('Advance', Formatters.currencyPdf(advance)),
              ],
            ),
          ),
          pw.SizedBox(height: 20),
          pw.Text(
            'Payment History (${history.length})',
            style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 14),
          ),
          pw.SizedBox(height: 8),
          if (history.isEmpty)
            pw.Text('No payment records found.', style: const pw.TextStyle(color: PdfColors.grey600))
          else
            pw.TableHelper.fromTextArray(
              headers: ['Receipt No', 'Date', 'For Month', 'Method', 'Note', 'Amount'],
              data: history
                  .map(
                    (p) => [
                      p.receiptNo,
                      Formatters.date(p.paymentDate),
                      p.forMonth,
                      p.method.label,
                      p.note ?? '—',
                      Formatters.currencyPdf(p.amount),
                    ],
                  )
                  .toList(),
              headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold, color: PdfColors.white),
              headerDecoration: const pw.BoxDecoration(color: PdfColors.indigo700),
              cellAlignment: pw.Alignment.centerLeft,
            ),
          pw.SizedBox(height: 40),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Text(
                'Generated on: ${Formatters.date(DateTime.now())}',
                style: const pw.TextStyle(fontSize: 10, color: PdfColors.grey600),
              ),
              pw.Column(
                children: [
                  pw.Container(width: 140, height: 1, color: PdfColors.grey800),
                  pw.SizedBox(height: 4),
                  pw.Text('Tutor / Authority Signature', style: const pw.TextStyle(fontSize: 10)),
                ],
              ),
            ],
          ),
        ],
      ),
    );

    await Printing.sharePdf(
      bytes: await doc.save(),
      filename: 'statement_${s.name.replaceAll(' ', '_')}.pdf',
    );
  }

  pw.Widget _pdfSummaryItem(String label, String value) {
    return pw.Column(
      children: [
        pw.Text(label, style: const pw.TextStyle(fontSize: 10, color: PdfColors.grey700)),
        pw.SizedBox(height: 2),
        pw.Text(value, style: pw.TextStyle(fontSize: 13, fontWeight: pw.FontWeight.bold)),
      ],
    );
  }

  pw.Widget _pdfRow(String label, String value) => pw.Padding(
    padding: const pw.EdgeInsets.symmetric(vertical: 3),
    child: pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: [pw.Text(label), pw.Text(value)],
    ),
  );

  @override
  Widget build(BuildContext context) {
    final studentProvider = context.watch<StudentProvider>();
    final paymentProvider = context.watch<PaymentProvider>();
    final student = studentProvider.byId(widget.student.id) ?? widget.student;
    final history = paymentProvider.forStudent(student.id);
    final totalPaid = paymentProvider.totalPaid(student.id);
    final totalExpected = FeeCalculator.totalExpected(student);
    final due = FeeCalculator.due(student, totalPaid);
    final advance = FeeCalculator.advance(student, totalPaid);

    return Scaffold(
      appBar: AppBar(
        title: Text(student.name),
        actions: [
          IconButton(
            icon: const Icon(Icons.picture_as_pdf_rounded),
            tooltip: AppStrings.t(context, 'statement_pdf'),
            onPressed: () => _generateStatementPdf(
              student,
              history,
              totalExpected,
              totalPaid,
              due,
              advance,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.edit_rounded),
            tooltip: AppStrings.t(context, 'edit_student'),
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => AddStudentScreen(existing: student),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline_rounded),
            tooltip: AppStrings.t(context, 'delete'),
            onPressed: () => _confirmDelete(context, student.id),
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 26,
                        backgroundColor: AppColors.primary.withValues(
                          alpha: 0.1,
                        ),
                        child: Text(
                          student.name.isNotEmpty
                              ? student.name[0].toUpperCase()
                              : '?',
                          style: const TextStyle(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w700,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              student.name,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              '${student.className} · Roll ${student.rollNumber} · Sec ${student.section}',
                              style: const TextStyle(
                                color: AppColors.textSecondary,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Divider(height: 28),
                  _infoRow(
                    Icons.attach_money_rounded,
                    AppStrings.t(context, 'monthly_fee'),
                    Formatters.currency(student.monthlyFee),
                  ),
                  _infoRow(
                    Icons.home_outlined,
                    AppStrings.t(context, 'address'),
                    student.address.isEmpty ? '—' : student.address,
                  ),
                  _infoRow(
                    Icons.calendar_today_rounded,
                    AppStrings.t(context, 'admission_date'),
                    Formatters.date(student.admissionDate),
                  ),
                  if (student.fatherName.isNotEmpty)
                    _infoRow(
                      Icons.man_rounded,
                      AppStrings.t(context, 'fathers_name'),
                      student.fatherName,
                    ),
                  if (student.fatherPhone.isNotEmpty)
                    _infoRow(
                      Icons.contact_phone_rounded,
                      AppStrings.t(context, 'fathers_mobile'),
                      student.fatherPhone,
                    ),
                  if (student.notes != null && student.notes!.isNotEmpty)
                    _infoRow(
                      Icons.notes_rounded,
                      AppStrings.t(context, 'notes_optional'),
                      student.notes!,
                    ),
                  if (student.fatherPhone.isNotEmpty) ...[
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () =>
                                _callNumber(context, student.fatherPhone),
                            icon: const Icon(Icons.call_rounded, size: 18),
                            label: Text(AppStrings.t(context, 'call_father')),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () =>
                                _messageNumber(context, student.fatherPhone),
                            icon: const Icon(Icons.sms_rounded, size: 18),
                            label: Text(AppStrings.t(context, 'message')),
                          ),
                        ),
                      ],
                    ),
                    if (due > 0) ...[
                      const SizedBox(height: 8),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: () =>
                              _sendDueReminderSms(context, student, due),
                          icon: const Icon(Icons.send_rounded, size: 18),
                          label: Text(
                            '${AppStrings.t(context, 'send_due_sms')} (৳${due.toStringAsFixed(0)})',
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.expense,
                          ),
                        ),
                      ),
                    ],
                  ],
                ],
              ),
            ),
            const SizedBox(height: 20),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 1.9,
              children: [
                _statBox(
                  AppStrings.t(context, 'total_expected'),
                  totalExpected,
                  AppColors.primary,
                ),
                _statBox(
                  AppStrings.t(context, 'total_paid'),
                  totalPaid,
                  AppColors.income,
                ),
                _statBox(AppStrings.t(context, 'due'), due, AppColors.expense),
                _statBox(
                  AppStrings.t(context, 'advance'),
                  advance,
                  AppColors.secondary,
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              AppStrings.t(context, 'payment_history'),
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 10),
            if (history.isEmpty)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                ),
                alignment: Alignment.center,
                child: Text(
                  AppStrings.t(context, 'no_payments_yet'),
                  style: const TextStyle(color: AppColors.textSecondary),
                ),
              )
            else
              ...history.map(
                (p) => Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 18,
                        backgroundColor: AppColors.income.withValues(
                          alpha: 0.12,
                        ),
                        child: const Icon(
                          Icons.check_rounded,
                          color: AppColors.income,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              Formatters.currency(p.amount),
                              style: const TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              p.receiptNo,
                              style: const TextStyle(
                                fontSize: 12,
                                color: AppColors.textSecondary,
                              ),
                            ),
                            Text(
                              '${Formatters.date(p.paymentDate)} · ${p.method.label} · ${p.forMonth}',
                              style: const TextStyle(
                                fontSize: 12,
                                color: AppColors.textSecondary,
                              ),
                            ),
                            Text(
                              p.receiptGiven
                                  ? AppStrings.t(context, 'receipt_given')
                                  : AppStrings.t(context, 'no_receipt'),
                              style: TextStyle(
                                fontSize: 11,
                                color: p.receiptGiven
                                    ? AppColors.income
                                    : AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.print_rounded,
                          color: AppColors.primary,
                        ),
                        onPressed: () => _printReceipt(student, p),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.delete_outline_rounded,
                          color: AppColors.expense,
                        ),
                        onPressed: () => _confirmDeletePayment(context, p.id),
                      ),
                    ],
                  ),
                ),
              ),
            const SizedBox(height: 20),
            Text(
              AppStrings.t(context, 'class_attendance'),
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        Formatters.monthYear(_attMonth, _attYear),
                        style: const TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        '${student.attendanceFor('$_attYear-${_attMonth.toString().padLeft(2, '0')}')} ${AppStrings.t(context, 'classes')}',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      IconButton.filled(
                        onPressed: () => studentProvider.decrementAttendance(
                          student,
                          _attMonth,
                          _attYear,
                        ),
                        icon: const Icon(Icons.remove_rounded),
                        style: IconButton.styleFrom(
                          backgroundColor: AppColors.background,
                          foregroundColor: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(width: 10),
                      IconButton.filled(
                        onPressed: () => studentProvider.incrementAttendance(
                          student,
                          _attMonth,
                          _attYear,
                        ),
                        icon: const Icon(Icons.add_rounded),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 80),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => CollectPaymentScreen(student: student),
          ),
        ),
        icon: const Icon(Icons.payments_rounded),
        label: Text(AppStrings.t(context, 'collect_payment')),
      ),
    );
  }

  Widget _statBox(String label, double value, Color color) => Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
        ),
        const SizedBox(height: 4),
        Text(
          Formatters.currency(value),
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w800,
            color: color,
          ),
        ),
      ],
    ),
  );

  Widget _infoRow(IconData icon, String label, String value) => Padding(
    padding: dynamicPad,
    child: Row(
      children: [
        Icon(icon, size: 18, color: AppColors.textSecondary),
        const SizedBox(width: 10),
        Text(
          '$label: ',
          style: const TextStyle(color: AppColors.textSecondary),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.w600),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    ),
  );

  static const EdgeInsets dynamicPad = EdgeInsets.symmetric(vertical: 6);

  void _confirmDeletePayment(BuildContext context, String paymentId) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(AppStrings.t(context, 'delete_payment')),
        content: Text(AppStrings.t(context, 'delete_payment_confirm')),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(AppStrings.t(context, 'cancel')),
          ),
          TextButton(
            onPressed: () {
              context.read<PaymentProvider>().deletePayment(paymentId);
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

  void _confirmDelete(BuildContext context, String id) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete Student'),
        content: const Text(
          'This will remove the student and all related records. Continue?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(AppStrings.t(context, 'cancel')),
          ),
          TextButton(
            onPressed: () {
              context.read<StudentProvider>().deleteStudent(id);
              Navigator.pop(ctx);
              Navigator.pop(context);
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
}
