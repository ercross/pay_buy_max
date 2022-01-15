
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
  late TextEditingController codeController;
  late TextEditingController payStackController;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  WalletBalanceEntity? walletBalanceEntity;
  late SignInResponseEntity args;
  double height = 720;
  String value = "Bitcoin Wallet";
  String value2 = "Amount In Naira";
  String value3 = "Fund With Transaction code";

  var publicKey = 'pk_live_f33e851ff1413ae66d2ea22a3e717b35d8513267';
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
    codeController = TextEditingController();
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
      showLoadingDialog(context);
      fundNairaWallet().then((value){
        Navigator.pop(context);
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
    charge.amount =   int.parse(textController.text+"00");
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

  Future<SignUpResponseEntity> fundCryptoWalletFromInternalWallet() async{
    showLoadingDialog(context);

    String url = 'https://paybuymax.com/api/buy-coin/internal';
    String coinID = "ce2b1390-fabb-11eb-b1f2-03ff05a8e54a";
    if(value == "Ethereum Wallet"){
      coinID = "eb29cac0-fb67-11eb-9951-3380c6ecc4c1";
    }

    var body = {"coinId":coinID,"amount":textController.text,"userId":args.user!.id,"medium":"ngn"};
    if(!(value2 == "Amount In Naira")){
      body = {"coinId":coinID,"amount":textController.text,"userId":args.user!.id,"medium":"usd"};
    }
    final response = await http.post(Uri.parse(url),headers: {"Authorization":args.token.toString()},body: body);
    print(response.body);
    Navigator.pop(context);
    return SignUpResponseEntity().fromJson(json.decode(response.body));
  }

  Future<SignUpResponseEntity> fundCryptoWalletWithTransactionCode() async{
    showLoadingDialog(context);

    String url = 'https://paybuymax.com/buy/transaction/code';
    String coinID = "ce2b1390-fabb-11eb-b1f2-03ff05a8e54a";
    if(value == "Ethereum Wallet"){
      coinID = "eb29cac0-fb67-11eb-9951-3380c6ecc4c1";
    }

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
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        elevation: 6,
                        color: Color(0xFFFAFAFA),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left:15,right:15,bottom: 15,top: 10),
                              child:  Text('Fund Your Wallet', style: TextStyle(color: Colors.black54, fontSize: 20,fontWeight: FontWeight.bold), textAlign: TextAlign.start),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left:15,right:15,bottom: 2,top: 5),
                              child:  Text('Wallet Type', style: TextStyle(color: Colors.black54, fontSize: 14), textAlign: TextAlign.start),
                            ),
                           Wrap(
                             children: [
                               Container(
                                 height: 90,
                                 child: Flex(
                                   direction: Axis.vertical,
                                   children: [
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
                                             if(value == "Naira Wallet"){
                                               height = 500;
                                             }else{
                                               if(value3 == "Fund With Transaction code"){
                                                 height = 720;
                                               }else{
                                                 height = 550;
                                               }
                                             }
                                             setState(() {
                                               value = _value as String;
                                             });
                                           }),
                                         ),
                                       ),
                                     ),
                                   ],
                                 ),
                               ),
                               Padding(
                                 padding: const EdgeInsets.only(left:15,right:15,bottom: 2,top: 10),
                                 child:  Text('Medium', style: TextStyle(color: Colors.black54, fontSize: 14), textAlign: TextAlign.start),
                               ),
                               Container(
                                 height: 90,
                                 child: Flex(
                                   direction: Axis.vertical,
                                   children: [
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
                                   ],
                                 ),
                               ),
                               Padding(
                                 padding: const EdgeInsets.only(left:15,right:15,bottom: 2,top: 10),
                                 child:  Text('Amount', style: TextStyle(color: Colors.black54, fontSize: 14), textAlign: TextAlign.start),
                               ),
                               Padding(
                                 padding: const EdgeInsets.only(left: 15,right: 15,bottom:20),
                                 child: TextFormField(
                                   controller: textController,
                                   obscureText: false,
                                   keyboardType: TextInputType.number,
                                   decoration: const InputDecoration(border: OutlineInputBorder()),
                                 ),
                               ),
                               Builder(
                                 builder: (context) {
                                   if(value == "Naira Wallet"){
                                     return Column(
                                       mainAxisSize: MainAxisSize.min,
                                       crossAxisAlignment: CrossAxisAlignment.start,
                                       children: [
                                         Padding(
                                           padding: const EdgeInsets.only(left:15,right:15,bottom: 2,top: 10),
                                           child:  Text('Reference', style: TextStyle(color: Colors.black54, fontSize: 14), textAlign: TextAlign.start),
                                         ),
                                         Padding(
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
                                       ],
                                     );
                                   }else{
                                     return Column(
                                       mainAxisSize: MainAxisSize.min,
                                       crossAxisAlignment: CrossAxisAlignment.stretch,
                                       children: [
                                         Padding(
                                           padding: const EdgeInsets.only(right:15,bottom: 2,top: 10,left:15),
                                           child:  Text('Transaction Type', style: TextStyle(color: Colors.black54, fontSize: 14), textAlign: TextAlign.start),
                                         ),
                                         Container(
                                           height:90,
                                           child: Padding(
                                             padding: const EdgeInsets.only(left:15,right:15,bottom: 20),
                                             child: InputDecorator(
                                               decoration: const InputDecoration(border: OutlineInputBorder()),
                                               child: DropdownButton(
                                                   value: value3,
                                                   underline: SizedBox.shrink(),
                                                   isExpanded: true, items: ["Fund With Transaction code","Fund With Naira Wallet"].map((String value) {
                                                 return DropdownMenuItem(value: value,child: Text(value));
                                               }).toList(), onChanged: (_value){
                                                 setState(() {
                                                   if(value == "Naira Wallet"){
                                                     height = 450;
                                                   }else{
                                                     if(value3 == "Fund With Transaction code"){
                                                       height = 720;
                                                     }else{
                                                       height = 550;
                                                     }
                                                   }
                                                   value3 = _value as String;
                                                 });
                                               }),
                                             ),
                                           ),
                                         ),
                                         Builder(
                                           builder: (context) {
                                             if(value3 == "Fund With Transaction code"){
                                               return  Padding(
                                                 padding: const EdgeInsets.only(left: 15,right: 15),
                                                 child: Column(
                                                   mainAxisSize: MainAxisSize.max,
                                                   crossAxisAlignment: CrossAxisAlignment.stretch,
                                                   children: [
                                                     Padding(
                                                       padding: const EdgeInsets.only(right:15,bottom: 2,top: 20),
                                                       child:  Text('Transaction Code', style: TextStyle(color: Colors.black54, fontSize: 14), textAlign: TextAlign.start),
                                                     ),
                                                     TextFormField(
                                                       controller: codeController,
                                                       obscureText: false,
                                                       keyboardType: TextInputType.number,
                                                       decoration: const InputDecoration(border: OutlineInputBorder()),
                                                     ),
                                                   ],
                                                 ),
                                               );
                                             }
                                             return Column();
                                           },
                                         )
                                       ],
                                     );
                                   }
                                 },
                               ),
                               Column(
                                 mainAxisSize: MainAxisSize.min,
                                 crossAxisAlignment: CrossAxisAlignment.stretch,
                                 children: [
                                   Padding(
                                     padding: const EdgeInsets.only(left:15,right:15,bottom: 10,top:20),
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
                                       }else{
                                         if(value3 == "Fund With Transaction code"){
                                           if(codeController.text.trim().isEmpty || textController.text.trim().isEmpty){
                                             AppOverlay.snackbar(message: "Fields Must Not Be Empty");
                                           }else{
                                             fundCryptoWalletWithTransactionCode();
                                           }
                                         }else{
                                           if(textController.text.trim().isEmpty){
                                             AppOverlay.snackbar(message: "Fields Must Not Be Empty");
                                           }else{
                                             fundCryptoWalletFromInternalWallet();
                                           }
                                         }
                                       }
                                     }, child: Text("FUND WALLET"),style: ElevatedButton.styleFrom(primary:Colors.black)),
                                   ),
                                 ],
                               )
                             ],
                           )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
