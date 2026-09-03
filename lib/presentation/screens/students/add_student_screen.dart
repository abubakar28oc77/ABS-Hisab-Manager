import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/app_strings.dart';
import '../../../data/models/student_model.dart';
import '../../../providers/class_provider.dart';
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
  final _feeCtrl = TextEditingController();
  final _guardianNameCtrl = TextEditingController();
  final _guardianPhoneCtrl = TextEditingController();
  final _studentPhoneCtrl = TextEditingController();
  final _addressCtrl = TextEditingController();
  final _notesCtrl = TextEditingController();

  String? _selectedClass;
  String? _selectedSection;
  DateTime _admissionDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    final s = widget.existing;
    if (s != null) {
      _nameCtrl.text = s.name;
      _rollCtrl.text = s.rollNumber;
      _selectedSection = s.section.isNotEmpty ? s.section : null;
      _feeCtrl.text = s.monthlyFee > 0 ? s.monthlyFee.toStringAsFixed(0) : '';
      _guardianNameCtrl.text = s.fatherName;
      _guardianPhoneCtrl.text = s.fatherPhone;
      _studentPhoneCtrl.text = s.studentPhone;
      _addressCtrl.text = s.address;
      _notesCtrl.text = s.notes ?? '';
      _selectedClass = s.className;
      _admissionDate = s.admissionDate;
    }
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _rollCtrl.dispose();
    _feeCtrl.dispose();
    _guardianNameCtrl.dispose();
    _guardianPhoneCtrl.dispose();
    _studentPhoneCtrl.dispose();
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
    final classProvider = context.read<ClassProvider>();
    final fee = double.tryParse(_feeCtrl.text) ?? 0;

    final finalClass = _selectedClass ??
        (classProvider.classes.isNotEmpty
            ? classProvider.classes.first.name
            : 'Class 6');
    final finalSection = _selectedSection ?? 'A';

    if (widget.existing != null) {
      final s = widget.existing!;
      s.name = _nameCtrl.text.trim();
      s.className = finalClass;
      s.rollNumber = _rollCtrl.text.trim();
      s.section = finalSection;
      s.monthlyFee = fee;
      s.fatherName = _guardianNameCtrl.text.trim();
      s.fatherPhone = _guardianPhoneCtrl.text.trim();
      s.studentPhone = _studentPhoneCtrl.text.trim();
      s.address = _addressCtrl.text.trim();
      s.admissionDate = _admissionDate;
      s.notes = _notesCtrl.text.trim();
      await provider.updateStudent(s);
    } else {
      await provider.addStudent(
        name: _nameCtrl.text.trim(),
        className: finalClass,
        rollNumber: _rollCtrl.text.trim(),
        monthlyFee: fee,
        section: finalSection,
        admissionDate: _admissionDate,
        notes: _notesCtrl.text.trim(),
        fatherName: _guardianNameCtrl.text.trim(),
        fatherPhone: _guardianPhoneCtrl.text.trim(),
        studentPhone: _studentPhoneCtrl.text.trim(),
        address: _addressCtrl.text.trim(),
      );
    }
    if (mounted) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.existing != null;
    final classProvider = context.watch<ClassProvider>();
    final availableClasses = classProvider.classNames;

    // Ensure selected class is valid
    if (_selectedClass == null || !availableClasses.contains(_selectedClass)) {
      _selectedClass = availableClasses.isNotEmpty ? availableClasses.first : 'Class 6';
    }

    final availableSections = classProvider.getSectionsForClass(_selectedClass!);
    if (_selectedSection == null || !availableSections.contains(_selectedSection)) {
      _selectedSection = availableSections.isNotEmpty ? availableSections.first : 'A';
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FC),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E88E5),
        foregroundColor: Colors.white,
        elevation: 0,
        title: Text(
          isEdit ? 'Edit Student' : 'Add Student',
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
        ),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            children: [
              // 1. Student Name *
              _buildFieldCard(
                icon: Icons.person_rounded,
                child: TextFormField(
                  controller: _nameCtrl,
                  decoration: _inputDeco('Student Name *'),
                  validator: (v) =>
                      (v == null || v.trim().isEmpty) ? 'Student name is required' : null,
                ),
              ),
              const SizedBox(height: 12),

              // 2. Roll Number *
              _buildFieldCard(
                icon: Icons.badge_outlined,
                child: TextFormField(
                  controller: _rollCtrl,
                  keyboardType: TextInputType.text,
                  decoration: _inputDeco('Roll Number *'),
                  validator: (v) =>
                      (v == null || v.trim().isEmpty) ? 'Roll number is required' : null,
                ),
              ),
              const SizedBox(height: 12),

              // 3. Class * (Dropdown)
              _buildFieldCard(
                icon: Icons.school_outlined,
                child: DropdownButtonFormField<String>(
                  value: _selectedClass,
                  decoration: _inputDeco('Class *'),
                  items: availableClasses
                      .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                      .toList(),
                  onChanged: (v) {
                    if (v != null) {
                      setState(() {
                        _selectedClass = v;
                        final newSections = classProvider.getSectionsForClass(v);
                        _selectedSection = newSections.isNotEmpty ? newSections.first : 'A';
                      });
                    }
                  },
                ),
              ),
              const SizedBox(height: 12),

              // 4. Section * (Dropdown)
              _buildFieldCard(
                icon: Icons.grid_view_rounded,
                child: DropdownButtonFormField<String>(
                  value: _selectedSection,
                  decoration: _inputDeco('Section *'),
                  items: availableSections
                      .map((sec) => DropdownMenuItem(value: sec, child: Text(sec)))
                      .toList(),
                  onChanged: (v) => setState(() => _selectedSection = v),
                ),
              ),
              const SizedBox(height: 12),

              // 5. Monthly Fee *
              _buildFieldCard(
                icon: Icons.attach_money_rounded,
                child: TextFormField(
                  controller: _feeCtrl,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  decoration: _inputDeco('Monthly Fee *'),
                  validator: (v) {
                    if (v == null || v.trim().isEmpty) return 'Monthly fee is required';
                    if (double.tryParse(v) == null) return 'Invalid fee amount';
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 12),

              // 6. Admission Date *
              InkWell(
                onTap: _pickDate,
                borderRadius: BorderRadius.circular(14),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Admission Date *',
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.grey.shade600,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(
                            Icons.calendar_month_outlined,
                            size: 20,
                            color: Colors.grey.shade700,
                          ),
                          const SizedBox(width: 12),
                          Text(
                            DateFormat('dd MMM yyyy').format(_admissionDate),
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textPrimary,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),

              // 7. Guardian Name
              _buildFieldCard(
                icon: Icons.people_alt_outlined,
                child: TextFormField(
                  controller: _guardianNameCtrl,
                  decoration: _inputDeco('Guardian Name'),
                ),
              ),
              const SizedBox(height: 12),

              // 8. Guardian Phone Number *
              _buildFieldCard(
                icon: Icons.phone_outlined,
                child: TextFormField(
                  controller: _guardianPhoneCtrl,
                  keyboardType: TextInputType.phone,
                  decoration: _inputDeco('Guardian Phone Number *'),
                  validator: (v) => (v == null || v.trim().isEmpty)
                      ? 'Guardian phone number is required'
                      : null,
                ),
              ),
              const SizedBox(height: 12),

              // 9. Student's Own Phone Number (Optional)
              _buildFieldCard(
                icon: Icons.phone_android_rounded,
                child: TextFormField(
                  controller: _studentPhoneCtrl,
                  keyboardType: TextInputType.phone,
                  decoration: _inputDeco("Student's Own Phone Number (Optional)"),
                ),
              ),
              const SizedBox(height: 12),

              // 10. Address
              _buildFieldCard(
                icon: Icons.location_on_outlined,
                child: TextFormField(
                  controller: _addressCtrl,
                  maxLines: 1,
                  decoration: _inputDeco('Address'),
                ),
              ),
              const SizedBox(height: 12),

              // 11. Notes (Optional)
              _buildFieldCard(
                icon: Icons.notes_rounded,
                child: TextFormField(
                  controller: _notesCtrl,
                  maxLines: 2,
                  decoration: _inputDeco('Notes (Optional)'),
                ),
              ),
              const SizedBox(height: 24),

              // Submit Button
              ElevatedButton(
                onPressed: _save,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1E88E5),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  isEdit ? 'Update Student' : 'Save Student',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFieldCard({
    required IconData icon,
    required Widget child,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade300),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon, size: 22, color: Colors.grey.shade700),
          const SizedBox(width: 12),
          Expanded(child: child),
        ],
      ),
    );
  }

  InputDecoration _inputDeco(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(color: Colors.grey.shade600, fontSize: 14),
      border: InputBorder.none,
      enabledBorder: InputBorder.none,
      focusedBorder: InputBorder.none,
      errorBorder: InputBorder.none,
      focusedErrorBorder: InputBorder.none,
      contentPadding: const EdgeInsets.symmetric(vertical: 12),
    );
  }
}
