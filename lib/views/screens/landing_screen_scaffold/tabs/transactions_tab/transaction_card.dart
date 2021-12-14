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
      margin: EdgeInsets.fromLTRB(2, 0, 2, height * 0.2),
      padding: EdgeInsets.symmetric(
          vertical: height * 0.05, horizontal: width * 0.05),
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: kElevationToShadow[2],
          borderRadius: BorderRadius.circular(5)),
      child: Row(
        children: [
          _TransactionTypeIcon(transaction.type),
          SizedBox(width: width * 0.1),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              RichText(
                  text: TextSpan(
                      text: "${transaction.currency} ",
                      style: StyleSheet.black12w300,
                      children: [
                    TextSpan(
                        text: transaction.amount.toStringAsFixed(0),
                        style: StyleSheet.black16w400)
                  ])),
              Text("Reference Number: ${transaction.referenceNumber}",
                  style: StyleSheet.grey13w300),
              Text(transaction.date.toIso8601String(),
                  style: StyleSheet.grey13w300),
            ],
          )),
        ],
      ),
    );
  }
}

class _TransactionTypeIcon extends StatelessWidget {
  final TransactionType type;
  const _TransactionTypeIcon(this.type);

  @override
  Widget build(BuildContext context) {
    final double iconSize = 30;
    switch (type) {
      case TransactionType.buy:
        return Icon(
          Icons.shopping_bag_rounded,
          size: iconSize,
          color: Colors.teal,
        );
      case TransactionType.sell:
        return Icon(
          Icons.screen_lock_landscape_outlined,
          size: iconSize,
          color: Color(0xFF800020),
        );
      case TransactionType.credit:
        return Icon(
          Icons.subdirectory_arrow_left_sharp,
          size: iconSize,
          color: Colors.green,
        );
      case TransactionType.withdrawal:
        return Icon(
          Icons.subdirectory_arrow_right_sharp,
          size: iconSize,
          color: Colors.red,
        );
      default:
        return SizedBox();
    }
  }
}
