import 'package:equatable/equatable.dart';

enum TransactionType { withdrawal, credit, buy, sell }

class Transaction extends Equatable {
  final double amount;
  final DateTime date;
  final TransactionType transactionType;
  final String currency;

  Transaction(
      {required this.amount,
      required this.date,
      required this.transactionType,
      required this.currency});

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [amount, date, transactionType, currency];
}
