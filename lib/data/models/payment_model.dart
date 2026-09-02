import 'package:hive/hive.dart';

part 'payment_model.g.dart';

enum PaymentMethod { cash, bkash, nagad, rocket, bank }

extension PaymentMethodX on PaymentMethod {
  String get label => switch (this) {
    PaymentMethod.cash => 'Cash',
    PaymentMethod.bkash => 'bKash',
    PaymentMethod.nagad => 'Nagad',
    PaymentMethod.rocket => 'Rocket',
    PaymentMethod.bank => 'Bank',
  };
}

/// A single tuition fee collection record for a student.
@HiveType(typeId: 3)
class Payment extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String studentId;

  @HiveField(2)
  double amount;

  @HiveField(3)
  int methodIndex;

  @HiveField(4)
  DateTime paymentDate;

  /// Month this payment applies to, format "YYYY-MM".
  @HiveField(5)
  String forMonth;

  @HiveField(6)
  String? note;

  @HiveField(7)
  String receiptNo;

  @HiveField(8)
  bool receiptGiven;

  Payment({
    required this.id,
    required this.studentId,
    required this.amount,
    PaymentMethod method = PaymentMethod.cash,
    required this.paymentDate,
    required this.forMonth,
    this.note,
    required this.receiptNo,
    this.receiptGiven = true,
  }) : methodIndex = method.index;

  PaymentMethod get method => PaymentMethod.values[methodIndex];
  set method(PaymentMethod m) => methodIndex = m.index;

  Map<String, dynamic> toJson() => <String, dynamic>{
    'id': id,
    'studentId': studentId,
    'amount': amount,
    'methodIndex': methodIndex,
    'paymentDate': paymentDate.toIso8601String(),
    'forMonth': forMonth,
    'note': note,
    'receiptNo': receiptNo,
    'receiptGiven': receiptGiven,
  };

  factory Payment.fromJson(Map<String, dynamic> json) => Payment(
    id: json['id'] as String,
    studentId: json['studentId'] as String,
    amount: (json['amount'] as num).toDouble(),
    method: PaymentMethod.values[json['methodIndex'] as int? ?? 0],
    paymentDate: DateTime.parse(json['paymentDate'] as String),
    forMonth: json['forMonth'] as String? ?? '',
    note: json['note'] as String?,
    receiptNo: json['receiptNo'] as String? ?? '',
    receiptGiven: json['receiptGiven'] as bool? ?? true,
  );
}
