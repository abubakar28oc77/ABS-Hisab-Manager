// GENERATED CODE - Hive TypeAdapter for Student
part of 'student_model.dart';

class StudentAdapter extends TypeAdapter<Student> {
  @override
  final int typeId = 0;

  @override
  Student read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Student(
      id: fields[0] as String,
      name: fields[1] as String,
      className: fields[2] as String,
      rollNumber: fields[3] as String? ?? '',
      monthlyFee: (fields[4] as num).toDouble(),
      section: fields[5] as String? ?? '',
      admissionDate: fields[6] as DateTime,
      notes: fields[7] as String?,
      attendance:
          (fields[8] as Map?)?.map((k, v) => MapEntry(k as String, v as int)) ??
          <String, int>{},
      fatherName: fields[9] as String? ?? '',
      fatherPhone: fields[10] as String? ?? '',
      address: fields[11] as String? ?? '',
      studentPhone: fields[12] as String? ?? '',
    );
  }

  @override
  void write(BinaryWriter writer, Student obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.className)
      ..writeByte(3)
      ..write(obj.rollNumber)
      ..writeByte(4)
      ..write(obj.monthlyFee)
      ..writeByte(5)
      ..write(obj.section)
      ..writeByte(6)
      ..write(obj.admissionDate)
      ..writeByte(7)
      ..write(obj.notes)
      ..writeByte(8)
      ..write(obj.attendance)
      ..writeByte(9)
      ..write(obj.fatherName)
      ..writeByte(10)
      ..write(obj.fatherPhone)
      ..writeByte(11)
      ..write(obj.address)
      ..writeByte(12)
      ..write(obj.studentPhone);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StudentAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
