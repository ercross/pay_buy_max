import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:pay_buy_max/models/coin.dart';
import 'package:pay_buy_max/style_sheet.dart';
import 'package:pay_buy_max/views/screens/chat_support_screen.dart';
import 'package:pay_buy_max/views/widgets/authentication_text_field.dart';
import 'package:pay_buy_max/views/widgets/horizontal_bar.dart';
import 'package:pay_buy_max/views/widgets/horizontal_tab_header.dart';

class HowToSell extends StatelessWidget {
  const HowToSell();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (_, constraints) {
      final double height = constraints.maxHeight;
      final double width = constraints.maxWidth;
      final state = Get.put<_ContentController>(_ContentController());

      return Container(
        padding: EdgeInsets.only(top: height * 0.12),
        alignment: Alignment.center,
        height: height,
        width: width,
        color: Colors.white,
        child: Column(
          children: [
            HorizontalTabsHeader(
                width: width,
                tabs: ["External wallet", "Internal wallet", "Gift card"],
                onTabChanged: (text, index) => state.changeActiveIndex(index),
                height: height * 0.08),
            Expanded(
                child: Container(
                    padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white,
                    ),
                    child: _CurrentTab()))
          ],
        ),
      );
    });
  }
}

class _ExternalWallet extends StatelessWidget {
  const _ExternalWallet();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (_, constraints) {
      final double height = constraints.maxHeight;
      final double width = constraints.maxWidth;
      return Container(
        padding: EdgeInsets.symmetric(
            vertical: height * 0.05, horizontal: width * 0.02),
        alignment: Alignment.center,
        margin: EdgeInsets.only(bottom: height * 0.1),
        height: height * 0.6,
        width: width * 0.9,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,
            boxShadow: kElevationToShadow[2]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text("Sell From Your External Wallet",
                textAlign: TextAlign.center, style: StyleSheet.gold15w600),
            Text(
                "This option allows you to exchange any PayBuyMax tradeable coins (transfered from your external wallet) for cash withdrawable into your local bank account. Proceeding means one of our friendly but professional customer support operator will take your order, execute and finalize the transaction with you.\nSimply state the coin type, the amount you want to sell and the external wallet address your transfer is coming from.",
                textAlign: TextAlign.center,
                style: StyleSheet.black12w300.copyWith(height: 1.4)),
            HorizontalBar.button(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "sell from external wallet",
                      style: StyleSheet.white15w400,
                    ),
                    SizedBox(
                      width: width * 0.08,
                    ),
                    Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                    )
                  ],
                ),
                height: height * 0.1,
                width: width * 0.8,
                onPressed: () =>
                    Navigator.of(context).pushNamed(ChatSupport.route))
          ],
        ),
      );
    });
  }
}

class _CurrentTab extends StatelessWidget {
  const _CurrentTab();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<_ContentController>(
      builder: (state) {
        switch (state._currentPageIndex.value) {
          case 0:
            return _ExternalWallet();

          case 1:
            return _InternalWallet();

          case 2:
            return _GiftCards();

          default:
            return SizedBox();
        }
      },
    );
  }
}

class _InternalWallet extends StatefulWidget {
  const _InternalWallet();

  @override
  State<_InternalWallet> createState() => _InternalWalletState();
}

enum _SellBy { usd, ngn, crypto }

class _InternalWalletState extends State<_InternalWallet> {
  late Coin _chosen;
  _SellBy _sellBy = _SellBy.ngn;

  final List<Coin> _coins = [
    Coin(
        name: "Bitcoin",
        abbreviatedName: "BTC",
        logoUrl: "assets/images/bitcoin.png",
        nairaAmount: 62000000,
        dollarAmount: 62000),
    Coin(
        name: "Ethereum",
        abbreviatedName: "ETH",
        logoUrl: "assets/images/eth.png",
        nairaAmount: 2450000,
        dollarAmount: 4500),
    Coin(
        name: "Tether",
        abbreviatedName: "USDT",
        logoUrl: "assets/images/tether.png",
        nairaAmount: 570,
        dollarAmount: 1.01),
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (_, constraints) {
      final double height = constraints.maxHeight;
      final double width = constraints.maxWidth;
      return Column(
        children: [
          SizedBox(
            height: height * 0.08,
            child: DropdownSearch<Coin>(
              maxHeight: height * 0.3,
              popupBackgroundColor: Colors.white,
              popupBarrierColor: Colors.black45,
              mode: Mode.MENU,
              itemAsString: (coin) {
                return coin!.abbreviatedName;
              },
              items: _coins,
              dropdownSearchDecoration: InputDecoration(
                labelText: "Choose coin",
              ),
              onChanged: (type) {},
            ),
          ),
          SizedBox(height: height * 0.06),
          SizedBox(
            height: height * 0.08,
            child: DropdownSearch<String>(
              maxHeight: height * 0.3,
              popupBackgroundColor: Colors.white,
              popupBarrierColor: Colors.black45,
              mode: Mode.MENU,
              itemAsString: (value) {
                return value ?? "Empty";
              },
              items: ["NGN", "USD", "Crypto"],
              dropdownSearchDecoration: InputDecoration(
                labelText: "Choose unit",
              ),
              onChanged: (type) {},
            ),
          ),
          SizedBox(height: height * 0.09),
          SizedBox(
            height: height * 0.12,
            child: Row(
              children: [
                Flexible(
                  flex: 2,
                  fit: FlexFit.tight,
                  child: Container(
                    alignment: Alignment.center,
                    height: height * 0.12,
                    decoration:
                        BoxDecoration(border: Border.all(color: Colors.grey)),
                    child: Text(
                      "equivalent in USD",
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Flexible(
                  flex: 2,
                  fit: FlexFit.tight,
                  child: Container(
                    alignment: Alignment.center,
                    height: height * 0.12,
                    decoration:
                        BoxDecoration(border: Border.all(color: Colors.grey)),
                    child: Text(
                      "equivalent in naira",
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: height * 0.06),
          AuthenticationTextField(
              fieldName: "input amount",
              leading: Icons.account_tree_outlined,
              onSaved: (_) {},
              renderHeight: height * 0.17,
              renderWidth: width),
          SizedBox(height: height * 0.09),
          HorizontalBar.button(
              child: Text("Sell",
                  textAlign: TextAlign.center, style: StyleSheet.white14w500),
              height: height * 0.12,
              width: width,
              onPressed: () {})
        ],
      );
    });
  }
}

class _GiftCards extends StatelessWidget {
  const _GiftCards();

  static const List<String> giftCards = [
    "assets/images/gift_cards/starbucks.png",
    "assets/images/gift_cards/sephora.png",
    "assets/images/gift_cards/walmart.png",
    "assets/images/gift_cards/victoria_secret.png",
    "assets/images/gift_cards/target.png",
    "assets/images/gift_cards/iTunes.png",
    "assets/images/gift_cards/fandango.png",
    "assets/images/gift_cards/best_buy.png",
    "assets/images/gift_cards/chipotle.png",
    "assets/images/gift_cards/amazon.png",
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) => ListView(
        padding: EdgeInsets.zero,
        children: giftCards
            .map<_Giftcard>((image) => _Giftcard(
                onPressed: () => Get.toNamed(ChatSupport.route),
                height: constraints.maxHeight * 0.18,
                width: constraints.maxWidth,
                imageUrl: image))
            .toList(),
      ),
    );
    ;
  }
}

class _Giftcard extends StatelessWidget {
  final double height;
  final double width;
  final String imageUrl;
  final Function onPressed;
  const _Giftcard(
      {required this.height,
      required this.onPressed,
      required this.width,
      required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: EdgeInsets.symmetric(horizontal: width * 0.05),
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey, width: 1.2))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(imageUrl, height: height, width: width * 0.2),
          HorizontalBar.button(
              borderRadius: 5,
              child: Text(
                "sell",
                style: StyleSheet.white14w500,
              ),
              color: Colors.teal,
              height: height * 0.5,
              width: width * 0.2,
              onPressed: onPressed)
        ],
      ),
    );
  }
}

class _ContentController extends GetxController {
  RxInt _currentPageIndex = 0.obs;

  void changeActiveIndex(int newIndex) {
    _currentPageIndex = newIndex.obs;
    update();
  }
}

/*
HorizontalBar.button(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "sell from external wallet",
                      style: StyleSheet.white15w400,
                    ),
                    SizedBox(
                      width: width * 0.08,
                    ),
                    Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                    )
                  ],
                ),
                height: height * 0.1,
                width: width * 0.8,
                onPressed: () =>
                    Navigator.of(context).pushNamed(ChatSupport.route)),

Text("Sell From Your External Wallet",
                  textAlign: TextAlign.center, style: StyleSheet.gold15w600),
              Text(
                  "This option allows you to exchange any PayBuyMax tradeable coins (transfered from your external wallet) for cash withdrawable into your local bank account. Proceeding means one of our friendly but professional customer support operator will take your order, execute and finalize the transaction with you.\nSimply state the coin type, the amount you want to sell and the external wallet address your transfer is coming from.",
                  textAlign: TextAlign.center,
                  style: StyleSheet.black12w300.copyWith(height: 1.4)),
                  */
