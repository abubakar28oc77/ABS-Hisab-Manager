// GENERATED CODE - Hive TypeAdapter for Payment
part of 'payment_model.dart';

class PaymentAdapter extends TypeAdapter<Payment> {
  @override
  final int typeId = 3;

  @override
  Payment read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Payment(
      id: fields[0] as String,
      studentId: fields[1] as String,
      amount: (fields[2] as num).toDouble(),
      method: PaymentMethod.values[fields[3] as int? ?? 0],
      paymentDate: fields[4] as DateTime,
      forMonth: fields[5] as String? ?? '',
      note: fields[6] as String?,
      receiptNo: fields[7] as String? ?? '',
      receiptGiven: fields[8] as bool? ?? true,
    );
  }

  @override
  void write(BinaryWriter writer, Payment obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.studentId)
      ..writeByte(2)
      ..write(obj.amount)
      ..writeByte(3)
      ..write(obj.methodIndex)
      ..writeByte(4)
      ..write(obj.paymentDate)
      ..writeByte(5)
      ..write(obj.forMonth)
      ..writeByte(6)
      ..write(obj.note)
      ..writeByte(7)
      ..write(obj.receiptNo)
      ..writeByte(8)
      ..write(obj.receiptGiven);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PaymentAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
