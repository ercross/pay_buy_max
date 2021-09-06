import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:money_formatter/money_formatter.dart';
import 'package:pay_buy_max/controllers/providers/buy_coin_provider.dart';
import 'package:pay_buy_max/models/coin.dart';
import 'package:pay_buy_max/views/widgets/horizontal_bar.dart';
import 'package:provider/provider.dart';

import '../../../../../style_sheet.dart';

class BuyTab extends StatelessWidget {
  const BuyTab();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BuyCoinProvider>(
      create: (_) => BuyCoinProvider(),
      builder: (_, __) => _BuyTab(),
    );
  }
}

class _BuyTab extends StatelessWidget {
  const _BuyTab();

  @override
  Widget build(BuildContext context) {
    final BuyCoinProvider state = Provider.of<BuyCoinProvider>(context);
    return LayoutBuilder(builder: (_, constraints) {
      final double renderWidth = constraints.maxWidth * 0.9;

      return Center(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10),
          width: constraints.maxWidth * 0.9,
          height: constraints.maxHeight * 0.9,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,
          ),
          child: Column(
            children: [
              _CoinHeaders(
                renderWidth: constraints.maxWidth,
                renderHeight: constraints.maxHeight * 0.1,
              ),
              SizedBox(
                height: constraints.maxHeight * 0.05,
              ),
              _TextField(
                  height: constraints.maxHeight * 0.10, width: renderWidth),
              SizedBox(
                height: constraints.maxHeight * 0.08,
              ),
              _CoinDetails(
                  coin: state.coins[state.currentCoinIndex],
                  height: constraints.maxHeight * 0.3,
                  width: renderWidth),
              SizedBox(
                height: constraints.maxHeight * 0.08,
              ),
              HorizontalBar.button(
                  child: Text("BUY NOW", style: StyleSheet.white15w400),
                  height: constraints.maxHeight * 0.1,
                  width: renderWidth,
                  onPressed: _proceedToPayment)
            ],
          ),
        ),
      );
    });
  }

  void _proceedToPayment() {}
}

class _TextField extends StatefulWidget {
  final double height;
  final double width;
  const _TextField({required this.height, required this.width});

  @override
  __TextFieldState createState() => __TextFieldState();
}

class __TextFieldState extends State<_TextField> {
  double _nairaEquivalent = 0;
  double _dollarToNaira = 508;
  double _dollarEquivalent = 0;

  @override
  Widget build(BuildContext context) {
    final BuyCoinProvider currentCoinProvider =
        Provider.of<BuyCoinProvider>(context, listen: false);
    final String coinName = currentCoinProvider
        .coins[currentCoinProvider.currentCoinIndex].name
        .toLowerCase();
    final String label = "Enter $coinName amount";
    return Container(
        height: widget.height,
        width: widget.width,
        padding: EdgeInsets.only(bottom: 5),
        decoration: BoxDecoration(
            color: Colors.transparent,
            border: Border(bottom: BorderSide(width: 2, color: Colors.grey))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                    _nairaEquivalent <= 0
                        ? "Naira Equivalent"
                        : MoneyFormatter(
                                amount: _nairaEquivalent,
                                settings: MoneyFormatterSettings(symbol: "NGN"))
                            .output
                            .symbolOnLeft,
                    style: StyleSheet.black13w400),
                Text(
                    _nairaEquivalent <= 0
                        ? "Dollar Equivalent"
                        : MoneyFormatter(
                            amount: _dollarEquivalent,
                          ).output.symbolOnLeft,
                    style: StyleSheet.black13w400),
              ],
            ),
            Expanded(
              child: Platform.isIOS
                  ? CupertinoTextFormFieldRow(
                      showCursor: true,
                      onChanged: _onChanged,
                      cursorColor: StyleSheet.primaryColor,
                      keyboardType: TextInputType.number,
                      padding: EdgeInsets.only(top: widget.height * 0.3),
                      placeholder: label,
                      placeholderStyle: StyleSheet.grey13w300,
                      style: StyleSheet.grey13w300,
                    )
                  : TextField(
                      keyboardType: TextInputType.number,
                      onChanged: _onChanged,
                      cursorColor: StyleSheet.primaryColor,
                      style: StyleSheet.grey14w500,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: label,
                        hintStyle: StyleSheet.grey13w300,
                      ),
                    ),
            ),
          ],
        ));
  }

  void _onChanged(String? input) {
    if (input == null || input.isEmpty) {
      setState(() {
        _nairaEquivalent = 0;
        _dollarEquivalent = 0;
      });
    } else if (double.tryParse(input) != null && input.length < 9) {
      final BuyCoinProvider currentCoinProvider =
          Provider.of<BuyCoinProvider>(context, listen: false);
      final Coin coin =
          currentCoinProvider.coins[currentCoinProvider.currentCoinIndex];
      
      final double value = double.tryParse(input) ?? 0;
      setState(() {
        _nairaEquivalent = value * coin.dollarAmount * _dollarToNaira;
        _dollarEquivalent = coin.dollarAmount * value;
      });
    }
  }
}

class _CoinDetails extends StatelessWidget {
  final Coin coin;
  final double height;
  final double width;
  const _CoinDetails(
      {required this.coin, required this.height, required this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: StyleSheet.background,
          boxShadow: kElevationToShadow[2]),
      height: height,
      width: width,
      padding: EdgeInsets.symmetric(
          horizontal: width * 0.05, vertical: height * 0.08),
      child: Row(
        children: [
          ClipOval(
            child: Container(
              color: Colors.white,
              padding: EdgeInsets.all(8),
              child: Image.asset(
                coin.logoUrl,
                fit: BoxFit.fill,
                height: height * 0.5,
                width: width * 0.2,
              ),
            ),
          ),
          SizedBox(
            width: width * 0.05,
          ),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(coin.name, style: StyleSheet.black14w500),
              Text(
                "Price: " +
                    MoneyFormatter(
                      amount: coin.dollarAmount,
                    ).output.symbolOnLeft,
              ),
              Text(
                "In Naira: " +
                    MoneyFormatter(
                            amount: coin.nairaAmount,
                            settings: MoneyFormatterSettings(symbol: "NGN"))
                        .output
                        .symbolOnLeft,
              ),
            ],
          ))
        ],
      ),
    );
  }
}

class _CoinHeaders extends StatelessWidget {
  final double renderWidth;
  final double renderHeight;
  const _CoinHeaders({required this.renderWidth, required this.renderHeight});

  @override
  Widget build(BuildContext context) {
    final BuyCoinProvider state = Provider.of<BuyCoinProvider>(context);
    final List<_CoinHeader> coinHeaders = [];
    state.coins.asMap().forEach((index, coin) {
      coinHeaders.add(_CoinHeader(coin: coin, index: index));
    });
    return SizedBox(
      height: renderHeight,
      width: renderWidth,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(children: coinHeaders),
      ),
    );
  }
}

class _CoinHeader extends StatelessWidget {
  final int index;
  final Coin coin;
  const _CoinHeader({required this.coin, required this.index});

  @override
  Widget build(BuildContext context) {
    final BuyCoinProvider state = Provider.of<BuyCoinProvider>(context);
    final Color underline =
        state.currentCoinIndex == index ? StyleSheet.accentColor : Colors.white;
    return GestureDetector(
      onTap: () => state.changeCurrent(index),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: underline, width: 2))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Image.asset(
              coin.logoUrl,
              fit: BoxFit.fill,
              height: 20,
              width: 20,
            ),
            SizedBox(width: 5),
            Text(coin.name, style: StyleSheet.black13w400)
          ],
        ),
      ),
    );
  }
}
