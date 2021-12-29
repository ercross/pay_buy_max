import 'dart:convert';
import 'package:pay_buy_max/models/auth/sign_up_response_entity.dart';
import 'package:pay_buy_max/views/widgets/overlays.dart';

import '../../../style_sheet.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pay_buy_max/controllers/providers/coin_price_provider.dart';
import 'package:pay_buy_max/controllers/providers/user_provider.dart';
import 'package:pay_buy_max/models/auth/sign_in_response_entity.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:pay_buy_max/models/wallet/wallet_balance_entity.dart';

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

  Future<SignUpResponseEntity> fundCryptoWalletFromInternalWallet() async{
    showLoadingDialog(context);

    String url = 'https://paybuymax.com/api/buy-coin/internal';
    String coinID = "ce2b1390-fabb-11eb-b1f2-03ff05a8e54a";

    var body = {"coinId":coinID,"amount":textController.text,"userId":args.user!.id,"medium":"ngn"};
    if(!(value2 == "Amount In Naira")){
      body = {"coinId":coinID,"amount":textController.text,"userId":args.user!.id,"medium":"usd"};
    }
    final response = await http.post(Uri.parse(url),headers: {"Authorization":args.token.toString()},body: body);
    print(response.statusCode);
    Navigator.pop(context);
    return SignUpResponseEntity().fromJson(json.decode(response.body));
  }

  void showLoadingDialog(BuildContext context){
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

    showDialog(barrierDismissible: false, context:context, builder: (BuildContext context){
      return alertDialog;
    });
  }

  void _getWalletInfo(){
    // final response = await getWalletInfo();
    getWalletInfo().then((value){
      setState(() {
        if(value.status == true){
          walletBalanceEntity = value;
        }else{
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

  Future<WalletBalanceEntity> getWalletInfo() async{
    String url = 'https://paybuymax.com/api/user';
    final response = await http.get(Uri.parse(url),headers: {"Authorization":args.token.toString()});
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

            ],
          ),
        ),
      ),
    );
  }
}