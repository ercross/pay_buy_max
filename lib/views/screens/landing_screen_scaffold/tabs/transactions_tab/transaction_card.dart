import 'package:flutter/material.dart';
import '../../../../../models/transaction.dart';
import '../../../../../style_sheet.dart';

class TransactionCard extends StatelessWidget {
  final Transaction transaction;
  final double height;
  final double width;

  const TransactionCard(
      {required this.transaction, required this.height, required this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: BoxDecoration(
          color: StyleSheet.background,
          boxShadow: kElevationToShadow[2],
          borderRadius: BorderRadius.circular(5)),
      child: Row(
        children: [],
      ),
    );
  }
}
