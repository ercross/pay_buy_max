import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pay_buy_max/views/screens/fund_wallet_screen.dart';

import '../../../../../mock_data.dart';
import '../../../../../style_sheet.dart';
import 'asset_card.dart';

class WalletTab extends StatelessWidget {
  const WalletTab();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (_, constraints) => Column(
              children: [
                SizedBox(
                  height: constraints.maxHeight * 0.52,
                  width: constraints.maxWidth,
                  child: _BalanceWithdrawal(),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text("Other Assets",
                      textAlign: TextAlign.center,
                      style: StyleSheet.black14w500),
                ),
                SizedBox(
                  height: constraints.maxHeight * 0.44,
                  width: constraints.maxWidth * 0.9,
                  child: _Assets(
                    widthPerCard: constraints.maxWidth * 0.9,
                    heightPerCard: constraints.maxHeight * 0.2,
                  ),
                )
              ],
            ));
  }
}

class _Assets extends StatelessWidget {
  final double heightPerCard;
  final double widthPerCard;

  const _Assets({required this.heightPerCard, required this.widthPerCard});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: ListView(
          children: MockData.assets
              .map<AssetCard>((asset) => AssetCard(
                  asset: asset, height: heightPerCard, width: widthPerCard))
              .toList()),
    );
  }
}

class _BalanceWithdrawal extends StatelessWidget {
  const _BalanceWithdrawal();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) => Stack(
        children: [
          _ConcaveContainer(
              child: _Balance(),
              containerHeight: constraints.maxHeight * 0.8,
              containerWidth: constraints.maxWidth),
          Positioned(
              top: constraints.maxHeight * 0.45,
              left: constraints.maxWidth * 0.11,
              right: constraints.maxWidth * 0.11,
              child: _AmountInput(
                height: constraints.maxHeight * 0.45,
                width: constraints.maxWidth * 0.75,
              ))
        ],
      ),
    );
  }
}

class _AmountInput extends StatelessWidget {
  final double height;
  final double width;
  const _AmountInput({required this.height, required this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: StyleSheet.background,
        boxShadow: kElevationToShadow[2],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("How much would you like to withdraw?",
              textAlign: TextAlign.center, style: StyleSheet.black12w300),
          _CustomTextField(
              renderHeight: height * 0.3, renderWidth: width * 0.8),
          Container(
            margin: EdgeInsets.only(top: height * 0.1),
            height: height * 0.25,
            width: width * 0.8,
            padding:
                EdgeInsets.symmetric(vertical: 5, horizontal: width * 0.05),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: StyleSheet.primaryColor,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("  Choose bank account", style: StyleSheet.white13w400),
                Icon(Icons.arrow_drop_down_rounded, color: Colors.white)
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _CustomTextField extends StatelessWidget {
  final double renderHeight;
  final double renderWidth;

  const _CustomTextField(
      {required this.renderHeight, required this.renderWidth});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: renderHeight,
        width: renderWidth,
        //padding: EdgeInsets.only(bottom: 5),
        decoration: BoxDecoration(
            color: Colors.transparent,
            border: Border(bottom: BorderSide(width: 2, color: Colors.grey))),
        child: Platform.isIOS
            ? CupertinoTextFormFieldRow(
                showCursor: true,
                textAlign: TextAlign.center,
                cursorColor: StyleSheet.primaryColor,
                keyboardType: TextInputType.number,
                padding: EdgeInsets.only(top: renderHeight * 0.3),
                placeholder: "Enter desired amount (NGN)",
                placeholderStyle: StyleSheet.grey13w300,
                style: StyleSheet.black14w500,
              )
            : TextField(
                style: StyleSheet.black14w500,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Enter desired amount (NGN)",
                  hintStyle: StyleSheet.grey13w300,
                ),
              ));
  }
}

class _Balance extends StatelessWidget {
  const _Balance();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) => Column(
        //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            height: constraints.maxHeight * 0.08,
          ),
          SizedBox(
              width: constraints.maxWidth,
              child: _WithdrawAndFundWalletButtons()),
          SizedBox(
            height: constraints.maxHeight * 0.15,
          ),
          Column(
            children: [
              Text("NGN113,000",
                  textAlign: TextAlign.center,
                  style: StyleSheet.white15w500
                      .copyWith(fontSize: 30, fontWeight: FontWeight.w700)),
              Text("currently withdrawable from your wallet",
                  textAlign: TextAlign.center, style: StyleSheet.white13w400)
            ],
          ),
        ],
      ),
    );
  }
}

class _WithdrawAndFundWalletButtons extends StatelessWidget {
  const _WithdrawAndFundWalletButtons();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: StyleSheet.background,
          ),
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Text(
            "Withdraw",
            textAlign: TextAlign.center,
            style: StyleSheet.goldAccent13w400,
          ),
        ),
        GestureDetector(
          onTap: () => Navigator.of(context).pushNamed(FundWalletPage.route),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: StyleSheet.background,
            ),
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Text(
              "Fund Wallet",
              textAlign: TextAlign.center,
              style: StyleSheet.goldAccent13w400,
            ),
          ),
        ),
      ],
    );
  }
}

class _ConcaveContainer extends StatelessWidget {
  final double containerHeight;
  final double containerWidth;
  final Widget? child;

  const _ConcaveContainer({
    required this.containerHeight,
    required this.containerWidth,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: ClipPath(
        clipper: _ConcaveContainerClipper(),
        child: Container(
            padding: EdgeInsets.only(
              left: 10,
              right: 10,
              bottom: containerHeight * 0.1,
            ),
            alignment: Alignment.topCenter,
            child: child,
            height: containerHeight,
            width: containerWidth,
            color: StyleSheet.primaryColor),
      ),
    );
  }
}

class _ConcaveContainerClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final Path path = Path();

    // draw path to encompass the container interior
    path.moveTo(0, size.height); // move start point to the bottom left
    path.lineTo(0, 0); //draw a path to the top left corner
    path.lineTo(size.width, 0); //continue drawing to the top right corner
    path.lineTo(size.width, size.height);

    // make the first concaved corner
    // controlPoint is the angle to which the bezier curve curved towards
    double xControlPoint = size.width;
    double yControlPoint = size.height * 0.8;
    double toPointX = size.width * 0.8;
    double toPointY = size.height * 0.8;
    path.quadraticBezierTo(xControlPoint, yControlPoint, toPointX, toPointY);

    //draw to the point where the seconded concaved corner will be drawn
    path.lineTo(size.width * 0.2, size.height * 0.8);

    //draw second concaved corner
    xControlPoint = 0;
    yControlPoint = size.height * 0.8;
    toPointX = 0;
    toPointY = size.height;
    path.quadraticBezierTo(xControlPoint, yControlPoint, toPointX, toPointY);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) => false;
}
