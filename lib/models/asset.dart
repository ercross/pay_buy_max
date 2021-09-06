import 'package:equatable/equatable.dart';

class Asset extends Equatable {
  final String logoUrl;
  final double balance;
  final String fullname;
  final double nairaAmount;
  final String abbreviatedName;

  Asset(
      {required this.logoUrl,
      required this.abbreviatedName,
      required this.nairaAmount,
      required this.balance,
      required this.fullname});

  @override
  List<Object?> get props =>
      [logoUrl, abbreviatedName, balance, fullname, nairaAmount];
}
