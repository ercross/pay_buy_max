
import 'dart:convert';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:pay_buy_max/models/auth/sign_in_response_entity.dart';
import 'package:pay_buy_max/models/auth/sign_up_response_entity.dart';
import 'package:pay_buy_max/views/widgets/overlays.dart';
import '../../../style_sheet.dart';
import 'package:flutter/material.dart';
import 'package:pay_buy_max/models/wallet/wallet_balance_entity.dart';
import 'package:pay_buy_max/controllers/providers/coin_price_provider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_paystack/flutter_paystack.dart';

class FundLocalWallet extends StatelessWidget {
  const FundLocalWallet();

  static const String route = "/fundLocalWallet";

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CoinPriceProvider>(
            create: (context) => CoinPriceProvider()),
      ],
      child: const FundLocalWalletWidget(),
    );
  }

}

class FundLocalWalletWidget extends StatefulWidget {
  const FundLocalWalletWidget();

  @override
  _FundLocalWalletWidgetState createState() => _FundLocalWalletWidgetState();
}

class _FundLocalWalletWidgetState extends State<FundLocalWalletWidget> {
  late TextEditingController textController;
  late TextEditingController payStackController;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  WalletBalanceEntity? walletBalanceEntity;
  late SignInResponseEntity args;
  String value = "Bitcoin Wallet";
  String value2 = "Amount In Naira";

  var publicKey = 'pk_test_a7a31c472e05ec2d22b34e64adef474e28c67414';
  final plugin = PaystackPlugin();

  static const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  Random _rnd = Random();

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

  @override
  void initState() {
    super.initState();
    plugin.initialize(publicKey: publicKey);
    textController = TextEditingController();
    payStackController = TextEditingController();
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

  void _fundNairaWallet(){
    if(textController.text.isEmpty){
      AppOverlay.snackbar(message: "Amount Cannot Be Empty");
    }else{
      fundNairaWallet().then((value){
        setState(() {
          if(value.status == true){
            AppOverlay.snackbar(message: "Success");
          }else{
            if(value.message == null){
              AppOverlay.snackbar(message: "An Error Occurred");
            }else{
              AppOverlay.snackbar(message: value.message.toString());
            }
          }
        });
      });
    }
  }

  Future<CheckoutResponse> payWithPayStack(BuildContext context) async {
    Charge charge = Charge();
    charge.amount =   int.parse(textController.text);
    charge.reference = "T-"+getRandomString(10);
    charge.email = args.user!.email.toString();

    CheckoutResponse response = await plugin.checkout(
      context,
      method: CheckoutMethod.card, // Defaults to CheckoutMethod.selectable
      charge: charge,
    );
    return response;
  }

  Future<SignUpResponseEntity> fundNairaWallet() async{
    String url = 'https://paybuymax.com/api/fundwallet';

    var body = {"email":args.user!.email.toString(),"amount":textController.text,"reference":payStackController.text,"channel":"PAYSTACK","currency":"NGN"};
    if(!(value2 == "Amount In Naira")){
      body = {"email":args.user!.email.toString(),"amount":textController.text,"reference":payStackController.text,"channel":"PAYSTACK","currency":"USD"};
    }
    final response = await http.patch(Uri.parse(url),headers: {"Authorization":args.token.toString()},body: body);
    print(response.statusCode);
    return SignUpResponseEntity().fromJson(json.decode(response.body));
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
            /*  Builder(
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
              ),*/
              Container(
                height:550,
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
                          child:  Text('Fund Your Wallet', style: TextStyle(color: Colors.black54, fontSize: 20,fontWeight: FontWeight.bold), textAlign: TextAlign.start),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left:15,right:15,bottom: 20),
                            child: InputDecorator(
                              decoration: const InputDecoration(border: OutlineInputBorder()),
                              child: DropdownButton(
                                value: value,
                                  underline: SizedBox.shrink(),
                                isExpanded: true, items: ["Naira Wallet","Bitcoin Wallet","Ethereum Wallet"].map((String value) {
                                return DropdownMenuItem(value: value,child: Text(value));
                              }).toList(), onChanged: (_value){
                                  setState(() {
                                    value = _value as String;
                                  });
                              }),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left:15,right:15,bottom: 2,top: 10),
                          child:  Text('Medium', style: TextStyle(color: Colors.black54, fontSize: 14), textAlign: TextAlign.start),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left:15,right:15,bottom: 20),
                            child: InputDecorator(
                              decoration: const InputDecoration(border: OutlineInputBorder()),
                              child: DropdownButton(
                                  value: value2,
                                  underline: SizedBox.shrink(),
                                  isExpanded: true, items: ["Amount In Dollar","Amount In Naira"/*,"Amount In Quantity"*/].map((String value) {
                                return DropdownMenuItem(value: value,child: Text(value));
                              }).toList(), onChanged: (_value){
                                setState(() {
                                  value2 = _value as String;
                                });
                              }),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left:15,right:15,bottom: 2,top: 10),
                          child:  Text('Amount', style: TextStyle(color: Colors.black54, fontSize: 14), textAlign: TextAlign.start),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15,right: 15),
                            child: TextFormField(
                              controller: textController,
                              obscureText: false,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(border: OutlineInputBorder()),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left:15,right:15,bottom: 2,top: 10),
                          child:  Text('Reference', style: TextStyle(color: Colors.black54, fontSize: 14), textAlign: TextAlign.start),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15,right: 15),
                            child: TextFormField(
                              controller: payStackController,
                              obscureText: false,
                              readOnly: true,
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
                          child: ElevatedButton(onPressed: (){
                            if(value == "Naira Wallet"){
                              payWithPayStack(context).then((value){
                                if(value.status == true){
                                  payStackController.text = value.reference.toString();
                                  _fundNairaWallet();
                                }else{
                                  AppOverlay.snackbar(message: "Transaction Failed");
                                }
                              });
                            }
                          }, child: Text("FUND WALLET"),style: ElevatedButton.styleFrom(primary:Colors.black)),
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
