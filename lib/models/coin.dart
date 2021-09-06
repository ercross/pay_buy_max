import 'package:equatable/equatable.dart';

class Coin extends Equatable {
  /// [name] must be unique and should be the abbreviation of the coin name
  final String name;
  final String abbreviatedName;
  final double dollarAmount;
  final double nairaAmount;
  final String logoUrl;

  Coin(
      {required this.name,
      required this.abbreviatedName,
      required this.logoUrl,
      required this.nairaAmount,
      required this.dollarAmount});

  @override
  bool get stringify => true;

  @override
  List<Object?> get props =>
      [abbreviatedName, name, logoUrl, dollarAmount, nairaAmount];
}
