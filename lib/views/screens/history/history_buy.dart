import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pay_buy_max/controllers/providers/user_provider.dart';
import 'package:pay_buy_max/models/auth/sign_in_response_entity.dart';
import 'package:pay_buy_max/models/auth/sign_up_response_entity.dart';
import 'package:pay_buy_max/models/history/coin_buy_transactions_entity.dart';
import 'package:pay_buy_max/models/history/coin_sell_transactions_entity.dart';
import 'package:pay_buy_max/models/wallet/wallet_balance_entity.dart';
import 'package:provider/provider.dart';
import '../../../style_sheet.dart';

class HistoryBuy extends StatelessWidget {
  const HistoryBuy();

  static const String route = "/historyBuy";

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UserProvider>(
            create: (context) => UserProvider()),
      ],
      child: const HistoryBuyWidget(),
    );
  }
}

class HistoryBuyWidget extends StatefulWidget {
  const HistoryBuyWidget();

  @override
  _HistoryBuyWidgetState createState() => _HistoryBuyWidgetState();
}

class _HistoryBuyWidgetState extends State<HistoryBuyWidget> {
  CoinSellTransactionsEntity? coinSellTransactionsEntity;
  late SignInResponseEntity args;

  late TextEditingController textController;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      getDepositHistoryBuy().then((value) {
        setState(() {
          coinSellTransactionsEntity = value;
        });
      });
    });
  }

  Future<CoinSellTransactionsEntity> getDepositHistoryBuy() async {
    try{
      String url = 'https://paybuymax.com/api/view-my-internal-buy';

      final response = await http.get(Uri.parse(url), headers: {"Authorization": args.token.toString()});
      print(response.statusCode);
      return CoinSellTransactionsEntity().fromJson(json.decode(response.body));
    }catch(e){
      var historyBuy = CoinSellTransactionsEntity();
      historyBuy.status = false;
      return historyBuy;
    }
  }

  void showLoadingDialog(BuildContext context) {
    AlertDialog alertDialog = AlertDialog(
      content: Row(
        children: [
          CircularProgressIndicator(),
          Container(
            margin: EdgeInsets.only(left: 10),
            child: Text("Getting"),
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
              child: Builder(
                builder: (context2) {
                  if (coinSellTransactionsEntity == null){
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(25),
                        child: CircularProgressIndicator(
                          color: Color(0xFFC9782F),
                        ),
                      ),
                    );
                  }
                  if (coinSellTransactionsEntity!.transactions!.isEmpty) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(25),
                        child: Center(
                            child: Text('No Transactions Here',
                                style: TextStyle(color: Color(0xFFC9782F), fontSize: 18,fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center)),
                      ),
                    );
                  }
                  return ListView.builder(
                    itemBuilder: (context3, position) {
                      var currentPackage = coinSellTransactionsEntity!.transactions!.elementAt(position);
                      var title = "Sold "+currentPackage.qty.toString().trim()+" "+currentPackage.coin!.name.toString();

                      return Container(
                        decoration: BoxDecoration(
                            border: Border(
                                top: BorderSide(color: Colors.black12,width: 1.0)
                            )
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 15),
                              child: Icon(Icons.history, color: Color(0xFFC9782F)),
                            ),
                            Expanded(
                              flex: 1,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 30, bottom: 5,top: 15),
                                    child: Text(title, style: TextStyle(color: Color(0xFFC9782F), fontSize: 18), textAlign: TextAlign.start),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 30, bottom: 15),
                                    child: Text(currentPackage.nairaAmount.toString() + " NGN", style: TextStyle(fontSize: 15), textAlign: TextAlign.start),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    itemCount: coinSellTransactionsEntity!.transactions!.length,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

}
