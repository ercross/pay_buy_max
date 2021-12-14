import 'package:equatable/equatable.dart';

enum TransactionType { withdrawal, credit, buy, sell }

class Transaction extends Equatable {
  final int? id;
  final double amount;
  final DateTime date;
  final TransactionType type;
  final String currency;
  final String referenceNumber;

  Transaction(
      {required this.amount,
      required this.date,
      this.id,
      required this.referenceNumber,
      required this.type,
      required this.currency});

  @override
  bool get stringify => true;

  @override
  List<Object?> get props =>
      [amount, date, referenceNumber, id, type, currency];
}
