
import 'dart:convert';
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
  String value2 = "Amount In Dollar";

  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _getWalletInfo();
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
              Builder(
                builder: (context) {
                  if(walletBalanceEntity == null){
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(25),
                        child: CircularProgressIndicator(
                          color: Color(0xFFC9782F),
                        ),
                      ),
                    );
                  } else{
                    if(walletBalanceEntity!.user!.userCoins == null){
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.all(25),
                          child: CircularProgressIndicator(
                            color: Color(0xFFC9782F),
                          ),
                        ),
                      );
                    }else if(walletBalanceEntity!.user!.userCoins!.isEmpty){
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
                      String rateText = "USD "+rate!.toString();
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
                                        imageUrl: coin.coinTypes!.image.toString(),
                                        placeholder: (context, url) => new CircularProgressIndicator(),
                                        errorWidget: (context, url, error) => new Icon(Icons.error),
                                      )),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    Text(coin.coinTypes!.name.toString(), style: TextStyle(
                                        color: Colors.black, fontSize: 18),
                                        textAlign: TextAlign.start),
                                    Text(coin.coinTypes!.symbol.toString().toUpperCase(), style: TextStyle(
                                        color: Colors.black54, fontSize: 18),
                                        textAlign: TextAlign.start),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 10, 10),
                                child: Expanded(
                                  flex: 1,
                                  child: Wrap(
                                    alignment: WrapAlignment.end,
                                    children: [
                                      Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Text(coin.coinTypes!.symbol.toString().toUpperCase() +" "+ coin.balance!.toString(), style: TextStyle(
                                              color: Colors.black, fontSize: 18),
                                              textAlign: TextAlign.start),
                                          Text(rateText, style: TextStyle(
                                              color: Color(0xFFC9782F), fontSize: 18),
                                              textAlign: TextAlign.start),
                                        ],
                                      ),
                                    ],
                                  ),
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
                height:400,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    elevation: 6,
                    color: Color(0xFFFAFAFA),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left:15,right:15,bottom: 15,top: 10),
                          child:  Text('Sell From Wallet', style: TextStyle(color: Colors.black54, fontSize: 20,fontWeight: FontWeight.bold), textAlign: TextAlign.start),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left:15,right:15,bottom: 2,top: 10),
                          child:  Text('Choose Coin Type', style: TextStyle(color: Colors.black54, fontSize: 14), textAlign: TextAlign.start),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left:15,right:15),
                            child: DropdownButton(
                                value: value,
                                isExpanded: true, items: ["Bitcoin","Ethereum"].map((String value) {
                              return DropdownMenuItem(value: value,child: Text(value));
                            }).toList(), onChanged: (_value){
                              setState(() {
                                value = _value as String;
                              });
                            }),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left:15,right:15,bottom: 2,top: 10),
                          child:  Text('Medium', style: TextStyle(color: Colors.black54, fontSize: 14), textAlign: TextAlign.start),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left:15,right:15),
                            child: DropdownButton(
                                value: value2,
                                isExpanded: true, items: ["Amount In Dollar","Amount In Naira","Amount In Quantity"].map((String value) {
                              return DropdownMenuItem(value: value,child: Text(value));
                            }).toList(), onChanged: (_value){
                              setState(() {
                                value2 = _value as String;
                              });
                            }),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left:15,right:15,bottom: 2,top: 10),
                          child:  Text('Amount', style: TextStyle(color: Colors.black54, fontSize: 14), textAlign: TextAlign.start),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15,right: 15,bottom: 15),
                            child: TextFormField(
                              controller: textController,
                              obscureText: false,
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0x00000000),
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0x00000000),
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                filled: true,
                                contentPadding:
                                EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left:15,right:15,bottom: 10),
                          child: ElevatedButton(onPressed: (){}, child: Text("SELL COIN"),style: ElevatedButton.styleFrom(primary:Colors.black)),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
