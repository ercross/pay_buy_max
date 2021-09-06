import 'package:flutter/material.dart';
import 'package:money_formatter/money_formatter.dart';
import '../../../../../models/asset.dart';
import '../../../../../style_sheet.dart';

class AssetCard extends StatelessWidget {
  final Asset asset;
  final double height;
  final double width;
  const AssetCard(
      {required this.asset, required this.height, required this.width});

  @override
  Widget build(BuildContext context) {
    final String balance = MoneyFormatter(
            amount: asset.balance,
            settings: MoneyFormatterSettings(
                symbol: asset.fullname,
                compactFormatType: CompactFormatType.short))
        .output
        .compactSymbolOnLeft;

    final String nairaEquivalent = MoneyFormatter(
            amount: asset.nairaAmount,
            settings: MoneyFormatterSettings(
                symbol: "NGN", compactFormatType: CompactFormatType.short))
        .output
        .compactSymbolOnLeft;

    return Container(
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
          boxShadow: kElevationToShadow[2]),
      height: height,
      width: width,
      padding: EdgeInsets.symmetric(
          horizontal: width * 0.05, vertical: height * 0.08),
      child: Row(
        children: [
          Image.asset(
            asset.logoUrl,
            fit: BoxFit.fill,
            height: height * 0.5,
            width: width * 0.2,
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(asset.fullname, style: StyleSheet.black14w500),
              RichText(
                text: TextSpan(
                    text: "Balance: $balance ${asset.abbreviatedName}\n",
                    style: StyleSheet.black13w400,
                    children: [
                      TextSpan(
                          text: "Naira Equivalent: $nairaEquivalent",
                          style: StyleSheet.gold13w400)
                    ]),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _ActionButton(text: "Sell", color: StyleSheet.primaryColor),
                  _ActionButton(text: "Buy More", color: Colors.greenAccent),
                  _ActionButton(text: "Transfer", color: Colors.black),
                ],
              )
            ],
          ))
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final String text;
  final Color color;
  const _ActionButton({required this.text, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: kElevationToShadow[2],
          color: color),
      child: Text(text,
          textAlign: TextAlign.center, style: StyleSheet.white13w400),
    );
  }
}
