import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pay_buy_max/controllers/providers/user_provider.dart';
import 'package:pay_buy_max/models/auth/sign_in_response_entity.dart';
import 'package:pay_buy_max/models/auth/sign_up_response_entity.dart';
import 'package:pay_buy_max/models/wallet/wallet_balance_entity.dart';
import 'package:pay_buy_max/views/widgets/overlays.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../style_sheet.dart';

class SellCoin extends StatelessWidget {
  const SellCoin();

  static const String route = "/sellCoin";

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UserProvider>(
            create: (context) => UserProvider()),
      ],
      child: const SellCoinWidget(),
    );
  }
}

class SellCoinWidget extends StatefulWidget {
  const SellCoinWidget();

  @override
  _SellCoinWidgetState createState() => _SellCoinWidgetState();
}

class _SellCoinWidgetState extends State<SellCoinWidget> {
  WalletBalanceEntity? walletBalanceEntity;
  late SignInResponseEntity args;

  late TextEditingController textController;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  String value = "Bitcoin";
  String value2 = "Amount In Naira";

  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _getWalletInfo();
    });
  }

  Future<SignUpResponseEntity> fundCryptoWalletFromInternalWallet() async {
    showLoadingDialog(context);

    var coinIds = {
      "Bitcoin": "ce2b1390-fabb-11eb-b1f2-03ff05a8e54a",
      "Tether": "29920ca0-fb68-11eb-9951-3380c6ecc4c1",
      "Ethereum": "eb29cac0-fb67-11eb-9951-3380c6ecc4c1",
    };

    String url = 'https://paybuymax.com/api/buy-coin/internal';
    String coinID = "ce2b1390-fabb-11eb-b1f2-03ff05a8e54a";
    if(value == "Ethereum"){
      coinID = "eb29cac0-fb67-11eb-9951-3380c6ecc4c1";
    }else if (value == "Tether"){
      coinID = "29920ca0-fb68-11eb-9951-3380c6ecc4c1";
    }

    var body = {
      "coinId": coinID,
      "amount": textController.text,
      "userId": args.user!.id,
      "medium": "ngn"
    };
    if (!(value2 == "Amount In Naira")) {
      body = {
        "coinId": coinID,
        "amount": textController.text,
        "userId": args.user!.id,
        "medium": "usd"
      };
    }
    final response = await http.post(Uri.parse(url), headers: {"Authorization": args.token.toString()}, body: body);
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
    final response = await http.get(Uri.parse(url), headers: {"Authorization": args.token.toString()});
    return WalletBalanceEntity().fromJson(json.decode(response.body));
  }

  @override
  Widget build(BuildContext context) {
    args = ModalRoute.of(context)!.settings.arguments as SignInResponseEntity;

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: StyleSheet.primaryColor.withOpacity(0.09),
      body: SafeArea(
        child: Flex(
          direction: Axis.vertical,
          children: [
            Expanded(
              child: ListView(
                scrollDirection: Axis.vertical,
                children: [
                  Builder(
                    builder: (context) {
                      if (walletBalanceEntity == null) {
                        return Center(
                          child: Padding(
                            padding: const EdgeInsets.all(25),
                            child: CircularProgressIndicator(
                              color: Color(0xFFC9782F),
                            ),
                          ),
                        );
                      } else {
                        if (walletBalanceEntity!.user!.userCoins == null) {
                          return Center(
                            child: Padding(
                              padding: const EdgeInsets.all(25),
                              child: CircularProgressIndicator(
                                color: Color(0xFFC9782F),
                              ),
                            ),
                          );
                        } else if (walletBalanceEntity!.user!.userCoins!.isEmpty) {
                          return Center(
                            child: Padding(
                              padding: const EdgeInsets.all(25),
                              child: CircularProgressIndicator(
                                color: Color(0xFFC9782F),
                              ),
                            ),
                          );
                        }
                      }
                      return ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, position) {
                          var coin = walletBalanceEntity!.user!.userCoins!.elementAt(position);
                          int? rate = coin.coinTypes!.dollarRate;
                          String rateText = "USD " + rate!.toString();
                          return Padding(
                            padding: const EdgeInsets.all(8),
                            child: Card(
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              color: Color(0xFFF5F5F5),
                              elevation: 6,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Container(
                                      width: 100,
                                      height: 100,
                                      child: CircleAvatar(
                                          backgroundColor: Colors.transparent,
                                          child: CachedNetworkImage(
                                            imageUrl:
                                            coin.coinTypes!.image.toString(),
                                            placeholder: (context, url) =>
                                            new CircularProgressIndicator(),
                                            errorWidget: (context, url, error) =>
                                            new Icon(Icons.error),
                                          )),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                      children: [
                                        Text(coin.coinTypes!.name.toString(),
                                            style: TextStyle(
                                                color: Colors.black, fontSize: 18),
                                            textAlign: TextAlign.start),
                                        Text(
                                            coin.coinTypes!.symbol
                                                .toString()
                                                .toUpperCase(),
                                            style: TextStyle(
                                                color: Colors.black54,
                                                fontSize: 18),
                                            textAlign: TextAlign.start),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(
                                        0, 10, 10, 10),
                                    child: Wrap(
                                      alignment: WrapAlignment.end,
                                      children: [
                                        Column(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                                coin.coinTypes!.symbol
                                                    .toString()
                                                    .toUpperCase() +
                                                    " " +
                                                    coin.balance!.toString(),
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 18),
                                                textAlign: TextAlign.start),
                                            Text(rateText,
                                                style: TextStyle(
                                                    color: Color(0xFFC9782F),
                                                    fontSize: 18),
                                                textAlign: TextAlign.start),
                                          ],
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                        shrinkWrap: true,
                        itemCount: 3,
                      );
                    },
                  ),
                  Container(
                    height: 450,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        elevation: 6,
                        color: Color(0xFFFAFAFA),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10))),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 15, right: 15, bottom: 15, top: 10),
                              child: Text('Sell From Internal Wallet',
                                  style: TextStyle(
                                      color: Colors.black54,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.start),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 15, right: 15, bottom: 2, top: 10),
                              child: Text('Choose Coin Type',
                                  style: TextStyle(
                                      color: Colors.black54, fontSize: 14),
                                  textAlign: TextAlign.start),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 15, right: 15, bottom: 15),
                                child: InputDecorator(
                                  decoration: const InputDecoration(
                                      border: OutlineInputBorder()),
                                  child: DropdownButton(
                                      value: value,
                                      underline: SizedBox.shrink(),
                                      isExpanded: true,
                                      items: ["Bitcoin", "Ethereum","Tether"]
                                          .map((String value) {
                                        return DropdownMenuItem(
                                            value: value, child: Text(value));
                                      }).toList(),
                                      onChanged: (_value) {
                                        setState(() {
                                          value = _value as String;
                                        });
                                      }),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 15, right: 15, bottom: 2, top: 10),
                              child: Text('Medium',
                                  style: TextStyle(
                                      color: Colors.black54, fontSize: 14),
                                  textAlign: TextAlign.start),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 15, right: 15, bottom: 15),
                                child: InputDecorator(
                                  decoration: const InputDecoration(
                                      border: OutlineInputBorder()),
                                  child: DropdownButton(
                                      value: value2,
                                      underline: SizedBox.shrink(),
                                      isExpanded: true,
                                      items: [
                                        "Amount In Dollar",
                                        "Amount In Naira",
                                        "Amount In Quantity"
                                      ].map((String value) {
                                        return DropdownMenuItem(
                                            value: value, child: Text(value));
                                      }).toList(),
                                      onChanged: (_value) {
                                        setState(() {
                                          value2 = _value as String;
                                        });
                                      }),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 15, right: 15, bottom: 2, top: 10),
                              child: Text('Amount',
                                  style: TextStyle(
                                      color: Colors.black54, fontSize: 14),
                                  textAlign: TextAlign.start),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 15, right: 15, bottom: 15),
                                child: TextFormField(
                                  controller: textController,
                                  obscureText: false,
                                  keyboardType: TextInputType.numberWithOptions(
                                      signed: false, decimal: true),
                                  decoration: const InputDecoration(
                                      border: OutlineInputBorder()),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 15, right: 15, bottom: 10),
                              child: ElevatedButton(
                                  onPressed: () {
                                    if (textController.text.trim().isEmpty) {
                                      AppOverlay.snackbar(
                                          message: "Amount Must Not Be Empty");
                                    } else {
                                      fundCryptoWalletFromInternalWallet();
                                    }
                                  },
                                  child: Text("SELL COIN"),
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.black)),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 150,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        elevation: 6,
                        color: Color(0xFFFAFAFA),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10))),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 15, right: 15, bottom: 15, top: 10),
                              child: Text('Sell From External Wallet',
                                  style: TextStyle(
                                      color: Colors.black54,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.start),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 15, right: 15, bottom: 10),
                              child: ElevatedButton(
                                  onPressed: () {
                                    var link = "https://wa.me/+2348128195573";
                                    launch(link);
                                  },
                                  child: Text("SELL COIN"),
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.black)),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
