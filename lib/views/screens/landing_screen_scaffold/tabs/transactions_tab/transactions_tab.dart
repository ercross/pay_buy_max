import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pay_buy_max/views/screens/landing_screen_scaffold/tabs/transactions_tab/transaction_card.dart';

import '../../../../../mock_data.dart';
import '../../../../../style_sheet.dart';

class TransactionsTab extends StatelessWidget {
  const TransactionsTab();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.black12, statusBarBrightness: Brightness.dark));
    return LayoutBuilder(builder: (_, constraints) {
      final height = constraints.maxHeight;
      final width = constraints.maxWidth;
      return Padding(
        padding: EdgeInsets.fromLTRB(width * 0.05,
            MediaQuery.of(context).padding.top + 10, width * 0.05, 10),
        child: Column(
          children: [
            _TopBar(height: height * 0.06, width: width),
            Expanded(child: _PastTransactions())
          ],
        ),
      );
    });
  }
}

class _PastTransactions extends StatelessWidget {
  const _PastTransactions();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) {
        final height = constraints.maxHeight;
        final width = constraints.maxWidth;
        return SizedBox(
          height: height,
          width: width,
          child: ListView(
            children: MockData.transactions
                .map<TransactionCard>((data) => TransactionCard(
                    transaction: data, height: height * 0.15, width: width))
                .toList(),
          ),
        );
      },
    );
  }
}

class _TopBar extends StatelessWidget {
  final double height;
  final double width;
  const _TopBar({required this.height, required this.width});

  @override
  Widget build(BuildContext context) {
    const double radius = 25;

    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          boxShadow: kElevationToShadow[2],
          color: StyleSheet.primaryColor),
      child: Row(
        children: [
          Container(
            alignment: Alignment.center,
            height: height,
            width: width * 0.55,
            margin: EdgeInsets.symmetric(vertical: 1, horizontal: 1),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radius),
              color: Colors.white,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.category, color: StyleSheet.primaryColor),
                SizedBox(width: width * 0.02),
                Text("All", style: StyleSheet.black14w400)
              ],
            ),
          ),
          Expanded(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.soap_rounded,
                color: Colors.white54,
              ),
              SizedBox(width: width * 0.03),
              Text("sort by",
                  textAlign: TextAlign.center, style: StyleSheet.white14w500),
              Icon(Icons.arrow_drop_down_rounded, color: Colors.white54)
            ],
          ))
        ],
      ),
    );
  }
}
