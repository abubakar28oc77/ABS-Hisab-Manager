import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';
import '../data/local/database_helper.dart';
import '../data/models/student_model.dart';

class StudentProvider extends ChangeNotifier {
  final DatabaseHelper _db = DatabaseHelper.instance;
  final _uuid = const Uuid();

  List<Student> _students = [];
  List<Student> get students => List.unmodifiable(_students);

  StudentProvider() {
    loadStudents();
  }

  void loadStudents() {
    _students = _db.getStudents()..sort((a, b) => a.name.compareTo(b.name));
    notifyListeners();
  }

  Future<Student> addStudent({
    required String name,
    required String className,
    required String rollNumber,
    required double monthlyFee,
    required String section,
    required DateTime admissionDate,
    String? notes,
    String fatherName = '',
    String fatherPhone = '',
    String address = '',
  }) async {
    final student = Student(
      id: _uuid.v4(),
      name: name,
      className: className,
      rollNumber: rollNumber,
      monthlyFee: monthlyFee,
      section: section,
      admissionDate: admissionDate,
      notes: notes,
      fatherName: fatherName,
      fatherPhone: fatherPhone,
      address: address,
    );
    await _db.saveStudent(student);
    loadStudents();
    return student;
  }

  Future<void> updateStudent(Student student) async {
    await _db.saveStudent(student);
    loadStudents();
  }

  Future<void> deleteStudent(String id) async {
    await _db.deleteStudent(id);
    loadStudents();
  }

  Student? byId(String id) {
    try {
      return _students.firstWhere((s) => s.id == id);
    } catch (_) {
      return null;
    }
  }

  Future<void> incrementAttendance(Student s, int month, int year) async {
    final key = '$year-${month.toString().padLeft(2, '0')}';
    s.attendance[key] = (s.attendance[key] ?? 0) + 1;
    await _db.saveStudent(s);
    loadStudents();
  }

  Future<void> decrementAttendance(Student s, int month, int year) async {
    final key = '$year-${month.toString().padLeft(2, '0')}';
    final current = s.attendance[key] ?? 0;
    if (current > 0) {
      s.attendance[key] = current - 1;
      await _db.saveStudent(s);
      loadStudents();
    }
  }
}
