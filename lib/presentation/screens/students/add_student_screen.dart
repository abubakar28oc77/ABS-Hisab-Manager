import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/utils/app_strings.dart';
import '../../../data/models/student_model.dart';
import '../../../providers/student_provider.dart';

class AddStudentScreen extends StatefulWidget {
  final Student? existing;
  const AddStudentScreen({super.key, this.existing});

  @override
  State<AddStudentScreen> createState() => _AddStudentScreenState();
}

class _AddStudentScreenState extends State<AddStudentScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _rollCtrl = TextEditingController();
  final _sectionCtrl = TextEditingController();
  final _feeCtrl = TextEditingController();
  final _fatherNameCtrl = TextEditingController();
  final _fatherPhoneCtrl = TextEditingController();
  final _addressCtrl = TextEditingController();
  final _notesCtrl = TextEditingController();
  String _className = AppConstants.classGrades.first;
  DateTime _admissionDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    final s = widget.existing;
    if (s != null) {
      _nameCtrl.text = s.name;
      _rollCtrl.text = s.rollNumber;
      _sectionCtrl.text = s.section;
      _feeCtrl.text = s.monthlyFee.toStringAsFixed(0);
      _fatherNameCtrl.text = s.fatherName;
      _fatherPhoneCtrl.text = s.fatherPhone;
      _addressCtrl.text = s.address;
      _notesCtrl.text = s.notes ?? '';
      _className = s.className;
      _admissionDate = s.admissionDate;
    }
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _rollCtrl.dispose();
    _sectionCtrl.dispose();
    _feeCtrl.dispose();
    _fatherNameCtrl.dispose();
    _fatherPhoneCtrl.dispose();
    _addressCtrl.dispose();
    _notesCtrl.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _admissionDate,
      firstDate: DateTime(2015),
      lastDate: DateTime(2100),
    );
    if (picked != null) setState(() => _admissionDate = picked);
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    final provider = context.read<StudentProvider>();
    final fee = double.tryParse(_feeCtrl.text) ?? 0;

    if (widget.existing != null) {
      final s = widget.existing!;
      s.name = _nameCtrl.text.trim();
      s.className = _className;
      s.rollNumber = _rollCtrl.text.trim();
      s.section = _sectionCtrl.text.trim();
      s.monthlyFee = fee;
      s.fatherName = _fatherNameCtrl.text.trim();
      s.fatherPhone = _fatherPhoneCtrl.text.trim();
      s.address = _addressCtrl.text.trim();
      s.admissionDate = _admissionDate;
      s.notes = _notesCtrl.text.trim();
      await provider.updateStudent(s);
    } else {
      await provider.addStudent(
        name: _nameCtrl.text.trim(),
        className: _className,
        rollNumber: _rollCtrl.text.trim(),
        monthlyFee: fee,
        section: _sectionCtrl.text.trim(),
        admissionDate: _admissionDate,
        notes: _notesCtrl.text.trim(),
        fatherName: _fatherNameCtrl.text.trim(),
        fatherPhone: _fatherPhoneCtrl.text.trim(),
        address: _addressCtrl.text.trim(),
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
              ? AppStrings.t(context, 'edit_student')
              : AppStrings.t(context, 'add_student'),
        ),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              // 1. Student Name
              TextFormField(
                controller: _nameCtrl,
                decoration: InputDecoration(
                  labelText: '${AppStrings.t(context, 'students')} *',
                ),
                validator: (v) =>
                    (v == null || v.trim().isEmpty) ? 'Required' : null,
              ),
              const SizedBox(height: 14),
              // 2. Class
              DropdownButtonFormField<String>(
                initialValue: _className,
                decoration: InputDecoration(
                  labelText: AppStrings.t(context, 'class_label'),
                ),
                items: AppConstants.classGrades
                    .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                    .toList(),
                onChanged: (v) => setState(() => _className = v!),
              ),
              const SizedBox(height: 14),
              // 3. Roll Number
              TextFormField(
                controller: _rollCtrl,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: '${AppStrings.t(context, 'roll')} *',
                ),
                validator: (v) =>
                    (v == null || v.trim().isEmpty) ? 'Required' : null,
              ),
              const SizedBox(height: 14),
              // 4. Section
              TextFormField(
                controller: _sectionCtrl,
                decoration: InputDecoration(
                  labelText: AppStrings.t(context, 'section'),
                ),
              ),
              const SizedBox(height: 14),
              // 5. Monthly Fee
              TextFormField(
                controller: _feeCtrl,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: InputDecoration(
                  labelText: '${AppStrings.t(context, 'monthly_fee')} *',
                ),
                validator: (v) {
                  if (v == null || v.trim().isEmpty) return 'Required';
                  if (double.tryParse(v) == null) return 'Invalid amount';
                  return null;
                },
              ),
              const SizedBox(height: 14),
              // 6. Father's Name
              TextFormField(
                controller: _fatherNameCtrl,
                decoration: InputDecoration(
                  labelText: AppStrings.t(context, 'fathers_name'),
                ),
              ),
              const SizedBox(height: 14),
              // 7. Father's Contact Number
              TextFormField(
                controller: _fatherPhoneCtrl,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: AppStrings.t(context, 'fathers_mobile'),
                ),
              ),
              const SizedBox(height: 14),
              // 8. Address
              TextFormField(
                controller: _addressCtrl,
                maxLines: 2,
                decoration: InputDecoration(
                  labelText: AppStrings.t(context, 'address'),
                ),
              ),
              const SizedBox(height: 14),
              // 9. Admission Date
              InkWell(
                onTap: _pickDate,
                child: InputDecorator(
                  decoration: InputDecoration(
                    labelText: AppStrings.t(context, 'admission_date'),
                  ),
                  child: Text(
                    '${_admissionDate.year}-${_admissionDate.month.toString().padLeft(2, '0')}-${_admissionDate.day.toString().padLeft(2, '0')}',
                  ),
                ),
              ),
              const SizedBox(height: 14),
              // 10. Notes (optional)
              TextFormField(
                controller: _notesCtrl,
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: AppStrings.t(context, 'notes_optional'),
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _save,
                child: Text(
                  isEdit
                      ? AppStrings.t(context, 'update_student')
                      : AppStrings.t(context, 'save_student'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
