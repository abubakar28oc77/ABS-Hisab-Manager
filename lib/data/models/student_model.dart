import 'package:hive/hive.dart';

part 'student_model.g.dart';

@HiveType(typeId: 0)
class Student extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String name;

  @HiveField(2)
  String className; // e.g. Six, Seven, Eight, Nine, Ten

  @HiveField(3)
  String rollNumber;

  @HiveField(4)
  double monthlyFee;

  @HiveField(5)
  String section;

  @HiveField(6)
  DateTime admissionDate;

  @HiveField(7)
  String? notes;

  /// Map key: "YYYY-MM" -> classes taken that month.
  @HiveField(8)
  Map<String, int> attendance;

  @HiveField(9)
  String fatherName;

  /// Father's mobile number, used for direct call / SMS actions.
  @HiveField(10)
  String fatherPhone;

  @HiveField(11)
  String address;

  Student({
    required this.id,
    required this.name,
    required this.className,
    required this.rollNumber,
    required this.monthlyFee,
    required this.section,
    required this.admissionDate,
    this.notes,
    Map<String, int>? attendance,
    this.fatherName = '',
    this.fatherPhone = '',
    this.address = '',
  }) : attendance = attendance ?? <String, int>{};

  int attendanceFor(String monthKey) => attendance[monthKey] ?? 0;

  Map<String, dynamic> toJson() => <String, dynamic>{
    'id': id,
    'name': name,
    'className': className,
    'rollNumber': rollNumber,
    'monthlyFee': monthlyFee,
    'section': section,
    'admissionDate': admissionDate.toIso8601String(),
    'notes': notes,
    'attendance': attendance,
    'fatherName': fatherName,
    'fatherPhone': fatherPhone,
    'address': address,
  };

  factory Student.fromJson(Map<String, dynamic> json) => Student(
    id: json['id'] as String,
    name: json['name'] as String,
    className: json['className'] as String,
    rollNumber: json['rollNumber'] as String? ?? '',
    monthlyFee: (json['monthlyFee'] as num).toDouble(),
    section: json['section'] as String? ?? '',
    admissionDate: DateTime.parse(
      (json['admissionDate'] ?? json['startDate']) as String,
    ),
    notes: json['notes'] as String?,
    attendance:
        (json['attendance'] as Map?)?.map(
          (k, v) => MapEntry(k.toString(), (v as num).toInt()),
        ) ??
        <String, int>{},
    fatherName: json['fatherName'] as String? ?? '',
    fatherPhone: json['fatherPhone'] as String? ?? '',
    address: json['address'] as String? ?? '',
  );
}
