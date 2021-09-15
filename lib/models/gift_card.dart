import 'package:equatable/equatable.dart';

class GiftCard extends Equatable {
  final String name;
  final num priceInDollar;

  GiftCard({required this.name, required this.priceInDollar});

  @override
  List<Object?> get props => [name, priceInDollar];
}
