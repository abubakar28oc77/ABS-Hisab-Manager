import 'package:hive/hive.dart';
import '../../core/constants/app_constants.dart';

part 'transaction_model.g.dart';

@HiveType(typeId: 2)
class Transaction extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  double amount;

  @HiveField(2)
  int typeIndex; // TxnType index

  @HiveField(3)
  String category;

  @HiveField(4)
  DateTime date;

  @HiveField(5)
  String? note;

  @HiveField(6)
  String? linkedStudentId; // optional link e.g. tuition income

  Transaction({
    required this.id,
    required this.amount,
    required TxnType type,
    required this.category,
    required this.date,
    this.note,
    this.linkedStudentId,
  }) : typeIndex = type.index;

  TxnType get type => TxnType.values[typeIndex];
  set type(TxnType t) => typeIndex = t.index;

  Map<String, dynamic> toJson() => <String, dynamic>{
    'id': id,
    'amount': amount,
    'typeIndex': typeIndex,
    'category': category,
    'date': date.toIso8601String(),
    'note': note,
    'linkedStudentId': linkedStudentId,
  };

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
    id: json['id'] as String,
    amount: (json['amount'] as num).toDouble(),
    type: TxnType.values[json['typeIndex'] as int? ?? 1],
    category: json['category'] as String,
    date: DateTime.parse(json['date'] as String),
    note: json['note'] as String?,
    linkedStudentId: json['linkedStudentId'] as String?,
  );
}
