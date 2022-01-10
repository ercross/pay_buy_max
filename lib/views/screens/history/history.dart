import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pay_buy_max/controllers/providers/user_provider.dart';
import 'package:pay_buy_max/models/auth/sign_in_response_entity.dart';
import 'package:pay_buy_max/models/auth/sign_up_response_entity.dart';
import 'package:pay_buy_max/models/wallet/wallet_balance_entity.dart';
import 'package:provider/provider.dart';

import '../../../style_sheet.dart';

class History extends StatelessWidget {
  const History();

  static const String route = "/history";

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UserProvider>(
            create: (context) => UserProvider()),
      ],
      child: const HistoryWidget(),
    );
  }
}

class HistoryWidget extends StatefulWidget {
  const HistoryWidget();

  @override
  _HistoryWidgetState createState() => _HistoryWidgetState();
}

class _HistoryWidgetState extends State<HistoryWidget> {
  WalletBalanceEntity? walletBalanceEntity;
  late SignInResponseEntity args;

  late TextEditingController textController;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _getWalletInfo();
    });
  }

  Future<SignUpResponseEntity> fundCryptoWalletFromInternalWallet() async {
    showLoadingDialog(context);

    String url = 'https://paybuymax.com/api/buy-coin/internal';
    String coinID = "ce2b1390-fabb-11eb-b1f2-03ff05a8e54a";

    var body = {
      "coinId": coinID,
      "amount": textController.text,
      "userId": args.user!.id,
      "medium": "ngn"
    };
    final response = await http.post(Uri.parse(url),
        headers: {"Authorization": args.token.toString()}, body: body);
    print(response.statusCode);
    Navigator.pop(context);
    return SignUpResponseEntity().fromJson(json.decode(response.body));
  }

  void showLoadingDialog(BuildContext context) {
    AlertDialog alertDialog = AlertDialog(
      content: Row(
        children: [
          CircularProgressIndicator(),
          Container(
            margin: EdgeInsets.only(left: 10),
            child: Text("Performing Transaction. Please wait"),
          )
        ],
      ),
    );

    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return alertDialog;
        });
  }

  void _getWalletInfo() {
    // final response = await getWalletInfo();
    getWalletInfo().then((value) {
      setState(() {
        if (value.status == true) {
          walletBalanceEntity = value;
        } else {
          walletBalanceEntity = null;
          /*if(response.message == null){
        AppOverlay.snackbar(message: "An Error Occurred!. Please Try Again");
      }else{
        if(response.message!.isEmpty){
          AppOverlay.snackbar(message: "An Error Occurred!. Please Try Again");
        }else{
          AppOverlay.snackbar(message: response.message.toString());
        }
      }*/
        }
      });
    });
  }

  Future<WalletBalanceEntity> getWalletInfo() async {
    String url = 'https://paybuymax.com/api/user';
    final response = await http
        .get(Uri.parse(url), headers: {"Authorization": args.token.toString()});
    return WalletBalanceEntity().fromJson(json.decode(response.body));
  }

  @override
  Widget build(BuildContext context) {
    args = ModalRoute.of(context)!.settings.arguments as SignInResponseEntity;

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: StyleSheet.primaryColor.withOpacity(0.09),
      body: SafeArea(
        child: Expanded(
          child: ListView(
            scrollDirection: Axis.vertical,
            children: [
              Container(
                decoration: BoxDecoration(
                    border: Border(
                        top: BorderSide(color: Colors.black12, width: 1.0))),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Transform.rotate(
                          angle: -1,
                          child: Icon(Icons.arrow_right_alt_outlined,
                              color: Color(0xFF4B8800))),
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 30, bottom: 5, top: 15),
                            child: Text('BTC 0.0125',
                                style: TextStyle(
                                    color: Color(0xFF4B8800), fontSize: 18),
                                textAlign: TextAlign.start),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 30, bottom: 15),
                            child: Text('Bitcoin Transfer',
                                style: TextStyle(fontSize: 15),
                                textAlign: TextAlign.start),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            right: 30, top: 15, bottom: 15),
                        child: Wrap(
                          alignment: WrapAlignment.end,
                          children: [
                            Text('NGN 1000',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 18),
                                textAlign: TextAlign.start),
                            Padding(
                              padding: const EdgeInsets.only(left: 30, top: 10),
                              child: Text('27 November',
                                  style: TextStyle(fontSize: 15),
                                  textAlign: TextAlign.start),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border(
                        top: BorderSide(color: Colors.black12, width: 1.0))),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Transform.rotate(
                          angle: -1,
                          child: Icon(Icons.arrow_right_alt_outlined,
                              color: Color(0xFF4B8800))),
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 30, bottom: 5, top: 15),
                            child: Text('ETH 0.00025',
                                style: TextStyle(
                                    color: Color(0xFF4B8800), fontSize: 18),
                                textAlign: TextAlign.start),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 30, bottom: 15),
                            child: Text('Ethereum Transfer',
                                style: TextStyle(fontSize: 15),
                                textAlign: TextAlign.start),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            right: 30, top: 15, bottom: 15),
                        child: Wrap(
                          alignment: WrapAlignment.end,
                          children: [
                            Text('NGN 50,000',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 18),
                                textAlign: TextAlign.start),
                            Padding(
                              padding: const EdgeInsets.only(left: 30, top: 10),
                              child: Text('10 October',
                                  style: TextStyle(fontSize: 15),
                                  textAlign: TextAlign.start),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border(
                        top: BorderSide(color: Colors.black12, width: 1.0))),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Transform.rotate(
                          angle: 0,
                          child: Icon(Icons.arrow_right_alt_outlined,
                              color: Color(0xFF4B8800))),
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 30, bottom: 5, top: 15),
                            child: Text('BTC 0.0000125',
                                style: TextStyle(
                                    color: Color(0xFF4B8800), fontSize: 18),
                                textAlign: TextAlign.start),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 30, bottom: 15),
                            child: Text('Bitcoin Charges',
                                style: TextStyle(fontSize: 15),
                                textAlign: TextAlign.start),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            right: 30, top: 15, bottom: 15),
                        child: Wrap(
                          alignment: WrapAlignment.end,
                          children: [
                            Text('NGN 200',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 18),
                                textAlign: TextAlign.start),
                            Padding(
                              padding: const EdgeInsets.only(left: 30, top: 10),
                              child: Text('27 November',
                                  style: TextStyle(fontSize: 15),
                                  textAlign: TextAlign.start),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border(
                        top: BorderSide(color: Colors.black12, width: 1.0))),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Transform.rotate(
                          angle: 0,
                          child: Icon(Icons.arrow_right_alt_outlined,
                              color: Color(0xFF4B8800))),
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 30, bottom: 5, top: 15),
                            child: Text('BTC 0.0000125',
                                style: TextStyle(
                                    color: Color(0xFF4B8800), fontSize: 18),
                                textAlign: TextAlign.start),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 30, bottom: 15),
                            child: Text('Bitcoin Charges',
                                style: TextStyle(fontSize: 15),
                                textAlign: TextAlign.start),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            right: 30, top: 15, bottom: 15),
                        child: Wrap(
                          alignment: WrapAlignment.end,
                          children: [
                            Text('NGN 200',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 18),
                                textAlign: TextAlign.start),
                            Padding(
                              padding: const EdgeInsets.only(left: 30, top: 10),
                              child: Text('27 November',
                                  style: TextStyle(fontSize: 15),
                                  textAlign: TextAlign.start),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border(
                        top: BorderSide(color: Colors.black12, width: 1.0))),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Transform.rotate(
                          angle: -1,
                          child: Icon(Icons.arrow_right_alt_outlined,
                              color: Color(0xFF4B8800))),
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 30, bottom: 5, top: 15),
                            child: Text('ETH 0.00025',
                                style: TextStyle(
                                    color: Color(0xFF4B8800), fontSize: 18),
                                textAlign: TextAlign.start),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 30, bottom: 15),
                            child: Text('Ethereum Transfer',
                                style: TextStyle(fontSize: 15),
                                textAlign: TextAlign.start),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            right: 30, top: 15, bottom: 15),
                        child: Wrap(
                          alignment: WrapAlignment.end,
                          children: [
                            Text('NGN 50,000',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 18),
                                textAlign: TextAlign.start),
                            Padding(
                              padding: const EdgeInsets.only(left: 30, top: 10),
                              child: Text('10 October',
                                  style: TextStyle(fontSize: 15),
                                  textAlign: TextAlign.start),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border(
                        top: BorderSide(color: Colors.black12, width: 1.0))),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Transform.rotate(
                          angle: -1,
                          child: Icon(Icons.arrow_right_alt_outlined,
                              color: Color(0xFF4B8800))),
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 30, bottom: 5, top: 15),
                            child: Text('BTC 0.0125',
                                style: TextStyle(
                                    color: Color(0xFF4B8800), fontSize: 18),
                                textAlign: TextAlign.start),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 30, bottom: 15),
                            child: Text('Bitcoin Transfer',
                                style: TextStyle(fontSize: 15),
                                textAlign: TextAlign.start),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            right: 30, top: 15, bottom: 15),
                        child: Wrap(
                          alignment: WrapAlignment.end,
                          children: [
                            Text('NGN 1000',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 18),
                                textAlign: TextAlign.start),
                            Padding(
                              padding: const EdgeInsets.only(left: 30, top: 10),
                              child: Text('27 November',
                                  style: TextStyle(fontSize: 15),
                                  textAlign: TextAlign.start),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
