import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pay_buy_max/controllers/providers/user_provider.dart';
import 'package:pay_buy_max/models/auth/sign_in_response_entity.dart';
import 'package:pay_buy_max/models/auth/sign_up_response_entity.dart';
import 'package:pay_buy_max/models/history/deposit_history_entity.dart';
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
  DepositHistoryEntity? depositHistoryEntity;
  late SignInResponseEntity args;

  late TextEditingController textController;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      getDepositHistory().then((value) {
        setState(() {
          depositHistoryEntity = value;
        });
      });
    });
  }

  Future<DepositHistoryEntity> getDepositHistory() async {
    try{
      String url = 'https://paybuymax.com/api/buy-coin/internal';

      final response = await http.get(Uri.parse(url), headers: {"Authorization": args.token.toString()});
      print(response.statusCode);
      return DepositHistoryEntity().fromJson(json.decode(response.body));
    }catch(e){
      var history = DepositHistoryEntity();
      history.status = false;
      return history;
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
            Builder(
              builder: (context2) {
                if (depositHistoryEntity == null){
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(25),
                      child: CircularProgressIndicator(
                        color: Color(0xFFC9782F),
                      ),
                    ),
                  );
                }
                if (depositHistoryEntity!.deposits!.isEmpty) {
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
                    var currentPackage = depositHistoryEntity!.deposits!.elementAt(position);
                    var title = "Naira Deposit";
                    if(currentPackage.currency!.toUpperCase() == "BTC" || currentPackage.currency!.toUpperCase() == "ETH" || currentPackage.currency!.toUpperCase() == "USDT"){
                      title = "Crypto Deposit";
                    }
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
                                  child: Text(currentPackage.status.toString(), style: TextStyle(fontSize: 15), textAlign: TextAlign.start),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 30,top: 15,bottom: 15),
                              child: Wrap(
                                alignment: WrapAlignment.end,
                                children: [
                                  Column(
                                    children: [
                                      Text(currentPackage.amount.toString().trim() +' ' + currentPackage.currency.toString().toUpperCase(), style: TextStyle(color: Colors.black, fontSize: 18), textAlign: TextAlign.end),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 10),
                                        child: Text(currentPackage.channel.toString(), style: TextStyle(fontSize: 15), textAlign: TextAlign.end),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  },
                  itemCount: depositHistoryEntity!.deposits!.length,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
