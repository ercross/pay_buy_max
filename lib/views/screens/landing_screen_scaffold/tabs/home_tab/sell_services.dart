import 'package:flutter/material.dart';
import 'package:pay_buy_max/views/screens/chat_support_screen.dart';
import 'package:pay_buy_max/views/widgets/horizontal_bar.dart';

import '../../../../../style_sheet.dart';

class HowToSell extends StatelessWidget {
  const HowToSell();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (_, constraints) {
      final double height = constraints.maxHeight;
      final double width = constraints.maxWidth;
      return Container(
        alignment: Alignment.center,
        height: height,
        width: width,
        margin: EdgeInsets.symmetric(horizontal: width * 0.05),
        color: Color(0xFFF7F4F0),
        child: Container(
          padding: EdgeInsets.symmetric(
              vertical: height * 0.05, horizontal: width * 0.02),
          alignment: Alignment.center,
          height: height * 0.7,
          width: width * 0.75,
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
                        "Proceed",
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
        ),
      );
    });
  }
}
