import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:get/get.dart';
import 'package:pay_buy_max/main.dart';

import '../../style_sheet.dart';

class PaymentPage extends StatelessWidget {
  const PaymentPage();

  static const String route = "/payment-page";

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double pageHeight = size.height;
    final double pageWidth = size.width;
    return BlankPage(
      child: Container(
        padding: EdgeInsets.only(
            right: pageWidth * 0.05,
            left: pageWidth * 0.05,
            top: pageHeight * 0.02),
        child: Column(
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: Get.back,
                  child: Icon(Icons.arrow_back_ios_new_rounded,
                      color: StyleSheet.primaryColor, size: 23),
                ),
                Expanded(
                    child: Text("Fund Naira Wallet",
                        textAlign: TextAlign.center,
                        style: StyleSheet.gold14w400)),
              ],
            ),
            SizedBox(height: pageHeight * 0.05),
            _CreditCardForm(
              cardHeight: pageHeight * 0.25,
              cardWidth: pageWidth,
            )
          ],
        ),
      ),
    );
  }
}

class _CreditCard extends StatelessWidget {
  final String cardNumber;
  final String expiryDate;

  final String cardHolderName;
  final String cvvCode;
  final double cardHeight;
  final double cardWidth;
  const _CreditCard({
    required this.cardHeight,
    required this.cardWidth,
    required this.cardHolderName,
    required this.cvvCode,
    required this.cardNumber,
    required this.expiryDate,
  });

  @override
  Widget build(BuildContext context) {
    return CreditCardWidget(
      cardNumber: cardNumber,
      expiryDate: expiryDate,

      cardHolderName: cardHolderName,
      cvvCode: cvvCode,
      onCreditCardWidgetChange: (brand) {},
      showBackView: false,
      animationDuration: Duration(milliseconds: 750),
      //glassmorphismConfig: Glassmorphism.defaultConfig(),
      //backgroundImage: 'assets/images/background.png',
      obscureCardNumber: false,
      obscureCardCvv: true,
      isHolderNameVisible: false,
      height: cardHeight,
      textStyle: StyleSheet.white14w500,
      width: cardWidth,
      isChipVisible: true,
      isSwipeGestureEnabled: true,
    );
  }
}

class _CreditCardForm extends StatefulWidget {
  final double cardHeight;
  final double cardWidth;
  _CreditCardForm({required this.cardHeight, required this.cardWidth});

  @override
  __CreditCardFormState createState() => __CreditCardFormState();
}

class __CreditCardFormState extends State<_CreditCardForm> {
  late String _cardNumber = "";
  late String _expiryDate = "";
  late String _cardHolder = "";
  late String _cvv = "";

  late GlobalKey<FormState> _formKey;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
  }

  @override
  Widget build(BuildContext context) {
    final CreditCardForm creditCardForm = CreditCardForm(
      cardHolderName: _cardHolder,
      cardNumber: _cardNumber,
      cvvCode: _cvv,
      expiryDate: _expiryDate,
      formKey: _formKey, // Required
      onCreditCardModelChange: _onCreditCardModelChange, // Required
      themeColor: Colors.red,
      obscureCvv: true,
      obscureNumber: false,
      cardNumberDecoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Number',
        hintText: 'XXXX XXXX XXXX XXXX',
      ),
      expiryDateDecoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Expiry Date',
        hintText: 'XX/XX',
      ),
      cvvCodeDecoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'CVV',
        hintText: 'XXX',
      ),
      cardHolderDecoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Card Holder',
      ),
    );

    return SingleChildScrollView(
      child: Column(
        children: [
          _CreditCard(
              cardHeight: widget.cardHeight,
              cardWidth: widget.cardWidth,
              cardHolderName: _cardHolder,
              cvvCode: _cvv,
              cardNumber: _cardNumber,
              expiryDate: _expiryDate),
          creditCardForm,
          SizedBox(height: 20),
          _buildConfirmButton(
              formKey: _formKey,
              height: widget.cardHeight * 0.25,
              width: widget.cardWidth * 0.85)
        ],
      ),
    );
  }

  Widget _buildConfirmButton(
      {required GlobalKey<FormState> formKey,
      required double height,
      required double width}) {
    return GestureDetector(
      onTap: () {
        formKey.currentState!.save();
      },
      child: Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          height: height,
          width: width,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: StyleSheet.primaryColor),
          child: Text("Done",
              textAlign: TextAlign.center, style: StyleSheet.white14w500)),
    );
  }

  void _onCreditCardModelChange(CreditCardModel creditCardModel) {
    setState(() {
      _cardNumber = creditCardModel.cardNumber;
      _expiryDate = creditCardModel.expiryDate;
      _cardHolder = creditCardModel.cardHolderName;
      _cvv = creditCardModel.cvvCode;
    });
  }
}
