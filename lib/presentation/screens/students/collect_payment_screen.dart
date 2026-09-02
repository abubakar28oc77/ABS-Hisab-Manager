import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:provider/provider.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/app_strings.dart';
import '../../../core/utils/fee_calculator.dart';
import '../../../core/utils/formatters.dart';
import '../../../data/models/payment_model.dart';
import '../../../data/models/student_model.dart';
import '../../../providers/payment_provider.dart';
import '../../../providers/transaction_provider.dart';

class CollectPaymentScreen extends StatefulWidget {
  final Student student;
  const CollectPaymentScreen({super.key, required this.student});

  @override
  State<CollectPaymentScreen> createState() => _CollectPaymentScreenState();
}

class _CollectPaymentScreenState extends State<CollectPaymentScreen> {
  final _formKey = GlobalKey<FormState>();
  final _amountCtrl = TextEditingController();
  final _monthCtrl = TextEditingController();
  final _noteCtrl = TextEditingController();
  PaymentMethod _method = PaymentMethod.cash;
  DateTime _paymentDate = DateTime.now();
  bool _giveReceiptNow = true;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _monthCtrl.text = '${now.year}-${now.month.toString().padLeft(2, '0')}';
    _amountCtrl.text = widget.student.monthlyFee.toStringAsFixed(0);
  }

  @override
  void dispose() {
    _amountCtrl.dispose();
    _monthCtrl.dispose();
    _noteCtrl.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _paymentDate,
      firstDate: DateTime(2015),
      lastDate: DateTime(2100),
    );
    if (picked != null) setState(() => _paymentDate = picked);
  }

  Future<void> _printReceipt(Payment payment) async {
    final s = widget.student;
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

  pw.Widget _pdfRow(String label, String value) => pw.Padding(
    padding: const pw.EdgeInsets.symmetric(vertical: 3),
    child: pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: [pw.Text(label), pw.Text(value)],
    ),
  );

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    final provider = context.read<PaymentProvider>();
    final amount = double.tryParse(_amountCtrl.text) ?? 0;

    final payment = await provider.addPayment(
      studentId: widget.student.id,
      studentName: widget.student.name,
      amount: amount,
      method: _method,
      paymentDate: _paymentDate,
      forMonth: _monthCtrl.text.trim(),
      note: _noteCtrl.text.trim(),
      receiptGiven: _giveReceiptNow,
    );

    if (mounted) {
      context.read<TransactionProvider>().loadTransactions();
    }

    if (_giveReceiptNow) {
      await _printReceipt(payment);
    }
    if (mounted) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final s = widget.student;
    final paymentProvider = context.watch<PaymentProvider>();
    final totalPaid = paymentProvider.totalPaid(s.id);
    final due = FeeCalculator.due(s, totalPaid);

    return Scaffold(
      appBar: AppBar(title: Text(AppStrings.t(context, 'collect_payment'))),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: AppColors.primary.withValues(
                        alpha: 0.1,
                      ),
                      child: const Icon(
                        Icons.person,
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      s.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Text(
                '${AppStrings.t(context, 'current_due')}: ${Formatters.currency(due)}',
                style: const TextStyle(
                  color: AppColors.income,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 14),
              TextFormField(
                controller: _amountCtrl,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: InputDecoration(
                  labelText: '${AppStrings.t(context, 'amount')} *',
                ),
                validator: (v) {
                  if (v == null || v.trim().isEmpty) return 'Required';
                  if (double.tryParse(v) == null) return 'Invalid amount';
                  return null;
                },
              ),
              const SizedBox(height: 14),
              DropdownButtonFormField<PaymentMethod>(
                initialValue: _method,
                decoration: InputDecoration(
                  labelText: AppStrings.t(context, 'payment_method'),
                ),
                items: PaymentMethod.values
                    .map(
                      (m) =>
                          DropdownMenuItem(value: m, child: Text(m.label)),
                    )
                    .toList(),
                onChanged: (v) => setState(() => _method = v!),
              ),
              const SizedBox(height: 14),
              InkWell(
                onTap: _pickDate,
                child: InputDecorator(
                  decoration: InputDecoration(
                    labelText: '${AppStrings.t(context, 'payment_date')} *',
                    suffixIcon: const Icon(Icons.calendar_today_rounded),
                  ),
                  child: Text(Formatters.date(_paymentDate)),
                ),
              ),
              const SizedBox(height: 14),
              TextFormField(
                controller: _monthCtrl,
                decoration: InputDecoration(
                  labelText: AppStrings.t(context, 'month_hint'),
                ),
              ),
              const SizedBox(height: 14),
              TextFormField(
                controller: _noteCtrl,
                decoration: InputDecoration(
                  labelText: AppStrings.t(context, 'note_optional'),
                ),
              ),
              const SizedBox(height: 14),
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                value: _giveReceiptNow,
                onChanged: (v) => setState(() => _giveReceiptNow = v),
                title: Text(AppStrings.t(context, 'give_receipt_now')),
                subtitle: Text(AppStrings.t(context, 'receipt_now_desc')),
                activeThumbColor: AppColors.primary,
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: _save,
                icon: const Icon(Icons.check_rounded),
                label: Text(
                  AppStrings.t(context, 'save_payment_generate_receipt'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
