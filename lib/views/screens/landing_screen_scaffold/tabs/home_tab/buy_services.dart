import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:money_formatter/money_formatter.dart';
import 'package:pay_buy_max/views/screens/chat_support_screen.dart';
import 'package:pay_buy_max/views/widgets/overlays.dart';
import 'package:provider/provider.dart';

import '../../../../../controllers/providers/buy_coin_provider.dart';
import '../../../../../controllers/providers/gift_cards_provider.dart';
import '../../../../../models/coin.dart';
import '../../../../../models/gift_card.dart';
import '../../../../../style_sheet.dart';
import '../../../../widgets/horizontal_bar.dart';

class BuyTab extends StatelessWidget {
  const BuyTab();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(builder: (_, __) => _BuyTab(), providers: [
      ChangeNotifierProvider<BuyCoinProvider>(
        create: (_) => BuyCoinProvider(),
      ),
      ChangeNotifierProvider<GiftCardsProvider>(
        create: (_) => GiftCardsProvider(),
      ),
    ]);
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
                  onPressed: () => _proceedToPayment(context))
            ],
          ),
        ),
      );
    });
  }

  void _proceedToPayment(BuildContext context) {
    final state = Provider.of<BuyCoinProvider>(context, listen: false);
    if (state.nairaEquivalent < 1) {
      AppOverlay.snackbar(
        message: "please enter a valid amount",
      );
      return;
    }
    state.updateBuySource(null);
    if (Platform.isIOS)
      showCupertinoDialog<void>(
          context: context, builder: (_) => _DialogContent(context));
    else if (Platform.isAndroid)
      showDialog<void>(
          context: context, builder: (_) => _DialogContent(context));
  }
}

enum BuySource { internalWallet, externalWallet }

class _DialogContent extends StatelessWidget {
  final BuildContext ctx;
  const _DialogContent(this.ctx);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double boxHeight = size.height * 0.25;
    final double boxWidth = size.width * 0.7;
    final BuyCoinProvider _state = Provider.of<BuyCoinProvider>(ctx);

    return Center(
      child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 20.0,
            sigmaY: 20.0,
          ),
          child: Container(
              alignment: Alignment.center,
              height: boxHeight,
              width: boxWidth,
              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: StyleSheet.background.withOpacity(0.5)),
              child: _state.buySource == null
                  ? _PaymentSource(ctx)
                  : _InternalBuy(
                      ctx,
                    ))),
    );
  }
}

class _InternalBuy extends StatelessWidget {
  final BuildContext ctx;
  const _InternalBuy(this.ctx);

  @override
  Widget build(BuildContext context) {
    final BuyCoinProvider state =
        Provider.of<BuyCoinProvider>(ctx, listen: false);
    final String amount =
        "${state.amount} ${state.coins[state.currentCoinIndex].abbreviatedName}";
    return LayoutBuilder(
      builder: (_, constraints) {
        final Widget space = SizedBox(height: constraints.maxHeight * 0.1);
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _Detail(on: "Buy", value: amount),
            space,
            _Detail(
                on: "Price in Naira",
                value: "NGN${state.nairaEquivalent.toStringAsFixed(2)}"),
            space,
            _Detail(
                on: "Price in Dollar",
                value: "\$${state.dollarEquivalent.toStringAsFixed(2)}"),
            SizedBox(
              height: constraints.maxHeight * 0.2,
            ),
            _Button(
                child: Text("Pay from wallet",
                    textAlign: TextAlign.center, style: StyleSheet.white13w400),
                onPressed: () {
                  Navigator.of(context).pop();
                  state.updateBuySource(null);
                })
          ],
        );
      },
    );
  }
}

class _Detail extends StatelessWidget {
  final String on;
  final String value;
  const _Detail({required this.on, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          on,
          style: StyleSheet.black13w400,
        ),
        Text(
          value,
          style: StyleSheet.black13w400,
        )
      ],
    );
  }
}

class _PaymentSource extends StatelessWidget {
  final BuildContext ctx;
  const _PaymentSource(this.ctx);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double pageHeight = size.height;
    final BuyCoinProvider _state = Provider.of<BuyCoinProvider>(ctx);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Payment Source",
          textAlign: TextAlign.center,
          style: StyleSheet.gold14w600,
        ),
        SizedBox(
          height: pageHeight * 0.03,
        ),
        _Button(
            child: Text("PayBuyMayx wallet balance",
                textAlign: TextAlign.center, style: StyleSheet.white13w400),
            onPressed: () {
              _state.updateBuySource(BuySource.internalWallet);
            }),
        _Button(
            child: Text("External payment/transfer",
                textAlign: TextAlign.center, style: StyleSheet.white13w400),
            onPressed: () {
              Navigator.of(context).pop();
              _state.updateBuySource(BuySource.externalWallet);
              Navigator.of(ctx).pushNamed(ChatSupport.route);
            })
      ],
    );
  }
}

class _Button extends StatelessWidget {
  final Widget child;
  final Function() onPressed;
  const _Button({required this.child, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
          decoration: BoxDecoration(
              color: StyleSheet.primaryColor,
              borderRadius: BorderRadius.circular(8)),
          margin: EdgeInsets.symmetric(vertical: 5),
          padding: EdgeInsets.all(10),
          child: child),
    );
  }
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
                      onChanged: (input) =>
                          _onChanged(input, currentCoinProvider.dollarToNaira),
                      cursorColor: StyleSheet.primaryColor,
                      keyboardType: TextInputType.number,
                      padding: EdgeInsets.only(top: widget.height * 0.2),
                      placeholder: label,
                      placeholderStyle: StyleSheet.grey13w300,
                      style: StyleSheet.grey13w300,
                    )
                  : TextField(
                      keyboardType: TextInputType.number,
                      onChanged: (input) =>
                          _onChanged(input, currentCoinProvider.dollarToNaira),
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

  void _onChanged(String? input, double dollarToNaira) {
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
        currentCoinProvider.changeAmount(value);
        _nairaEquivalent = value * coin.dollarAmount * dollarToNaira;
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
    return Container(
      alignment: Alignment.center,
      height: renderHeight,
      width: renderWidth,
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        ...coinHeaders,
      ]),
    );
  }
}

class _GiftCards extends StatelessWidget {
  _GiftCards();

  @override
  Widget build(BuildContext context) {
    final String hint = "Gift Cards";
    final GiftCardsProvider state = Provider.of<GiftCardsProvider>(context);

    return Platform.isIOS
        ? GestureDetector(
            onTap: () => _showCupertinoPicker(context, state),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  "assets/images/gift_cards.png",
                  fit: BoxFit.fill,
                  height: 20,
                  width: 20,
                ),
                SizedBox(width: 5),
                Text(
                    state.selectedIndex == -1
                        ? hint
                        : state.giftCards[state.selectedIndex].name,
                    style: StyleSheet.black13w400),
                const Icon(Icons.keyboard_arrow_down_rounded)
              ],
            ))
        : GestureDetector(
            onTap: () {},
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              margin: EdgeInsets.only(bottom: 10),
              height: 20,
              width: 30,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.blueGrey.shade50,
              ),
              child: DropdownButton<GiftCard>(
                  items: state.items,
                  value: state.selectedIndex == -1
                      ? null
                      : state.giftCards[state.selectedIndex],
                  hint: Text(hint, style: StyleSheet.black12w300),
                  icon: const Icon(Icons.keyboard_arrow_down_rounded),
                  iconSize: 24,
                  elevation: 12,
                  dropdownColor: Colors.white,
                  isExpanded: true,
                  underline: SizedBox(),
                  onChanged: (value) => _onChanged(
                      state, (value ?? GiftCard(name: "", priceInDollar: 0))),
                  menuMaxHeight: 30,
                  style: StyleSheet.black12w300),
            ));
  }

  void _showCupertinoPicker(BuildContext context, GiftCardsProvider state) {
    showCupertinoModalPopup(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.3,
            child: CupertinoPicker(
                useMagnifier: true,
                magnification: 1.5,
                backgroundColor: StyleSheet.accentColor,
                itemExtent: 30,
                onSelectedItemChanged: (index) =>
                    _onChanged(state, state.giftCards[index]),
                children: state.giftCards
                    .map<Widget>((card) => Center(
                          child: Text(card.name,
                              textAlign: TextAlign.center,
                              style: StyleSheet.black13w400),
                        ))
                    .toList()),
          );
        });
  }

  void _onChanged(GiftCardsProvider state, GiftCard selected) {
    state.changeIndex(state.giftCards.indexOf(selected));
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
