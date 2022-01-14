import 'dart:convert';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pay_buy_max/models/auth/sign_in_response_entity.dart';
import 'package:pay_buy_max/models/auth/sign_up_response_entity.dart';
import 'package:pay_buy_max/models/learn/course_list_entity.dart';
import 'package:pay_buy_max/models/wallet/code_response_entity.dart';
import 'package:pay_buy_max/models/wallet/subscribe_response_entity.dart';
import 'package:pay_buy_max/views/widgets/overlays.dart';
import '../../../style_sheet.dart';
import 'package:flutter/services.dart';
import 'package:pay_buy_max/controllers/providers/coin_price_provider.dart';
import 'package:pay_buy_max/generated/assets.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class LearnScreen extends StatelessWidget {
  const LearnScreen();

  static const String route = "/learnScreen";

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CoinPriceProvider>(
            create: (context) => CoinPriceProvider()),
      ],
      child: const _LearnScreen(),
    );
  }
}

class _LearnScreen extends StatefulWidget {
  const _LearnScreen();

  @override
  State<StatefulWidget> createState() => _LearnState();
}

class _LearnState extends State<_LearnScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  late TextEditingController _textFieldController;
  late SignInResponseEntity args;
  late List<CourseListCourses>? courses;

  @override
  void initState() {
    super.initState();
    _textFieldController = TextEditingController();
  }

  Future<void> _displayTextInputDialog(BuildContext context1,String planID) async {
    return showDialog(
        context: context1,
        builder: (context) {
          return AlertDialog(
            title: Text('Enter OTP Code'),
            content: TextField(
              controller: _textFieldController,
              decoration: InputDecoration(hintText: "Enter OTP Code To Confirm Subscription",border: OutlineInputBorder()),
            ),
            actions: <Widget>[
              FlatButton(
                color: Colors.black,
                textColor: Colors.white,
                child: Text('CANCEL'),
                onPressed: () {
                  setState(() {
                    Navigator.pop(context);
                  });
                },
              ),
              FlatButton(
                color: Color(0xFFC9782F),
                textColor: Colors.white,
                child: Text('OK'),
                onPressed: () {
                  setState(() {
                    Navigator.pop(context1);
                    showLoadingDialog(context1, " Confirming Subscription. Please Wait... ");
                    confirmSubscription(planID, _textFieldController.text).then((value){
                      Navigator.of(context1).pop();
                      if(value.success == true){
                        AppOverlay.snackbar(message: value.message.toString());
                      }else{
                        if(value.message == null){
                          AppOverlay.snackbar(message: "An Error Occurred");
                        }else{
                          AppOverlay.snackbar(message: value.message.toString());
                        }
                      }
                    });
                  });
                },
              ),
            ],
          );
        });
  }

  Future<CodeResponseEntity> sendOTPCode(String type, String userID, int amount) async{
    try {
      String url = 'https://paybuymax.com/api/withdraw/code';

      var body = {"type":type,"userId":userID,"amount":amount.toString()};
      final response = await http.post(Uri.parse(url),headers: {"Authorization":args.token.toString()},body: body);
      print(response.body);
      return CodeResponseEntity().fromJson(json.decode(response.body));
    } catch(e){
      var error = CodeResponseEntity();
      error.msg = "An Error Occurred";
      error.success = false;
      return error;
    }
  }

  Future<SubscribeResponseEntity> confirmSubscription(String planID, String code) async{
    try {
      String url = 'https://paybuymax.com/api/subscribe/plan';

      var body = {"planId":planID,"code":code};
      final response = await http.post(Uri.parse(url),headers: {"Authorization":args.token.toString()},body: body);
      print(response.body);
      return SubscribeResponseEntity().fromJson(json.decode(response.body));
    } catch(e){
      var error = SubscribeResponseEntity();
      error.message = "An Error Occurred";
      error.success = false;
      return error;
    }
  }

  Future<SubscribeResponseEntity> getCoursesList(String planID, String code) async{
    try {
      String url = 'https://paybuymax.com/api/courses';

      final response = await http.get(Uri.parse(url),headers: {"Authorization":args.token.toString()});
      print(response.body);
      return SubscribeResponseEntity().fromJson(json.decode(response.body));
    } catch(e){
      var error = SubscribeResponseEntity();
      error.message = "An Error Occurred";
      error.success = false;
      return error;
    }
  }

  void showLoadingDialog(BuildContext context,String text){
    AlertDialog alertDialog = AlertDialog(
      content: Row(
        children: [
          CircularProgressIndicator(),
          Container(
            margin: EdgeInsets.only(left: 10),
            child: Text(text),
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
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            Container(
              height:300,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
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
                        child:  Text('Basic Plan', style: TextStyle(color: Colors.black87, fontSize: 20,fontWeight: FontWeight.bold),textAlign: TextAlign.center),
                      ),
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(left:15,right:15,bottom: 2,top: 10),
                        child:  Text('NGN0.00', style: TextStyle(color: Colors.black54, fontSize: 25), textAlign: TextAlign.center),
                      ),
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(left:15,right:15,bottom: 10,top: 10),
                        child:  Text('Offers = "Introduction to the Cryptocurrency market, Introduction to Blockchain technology, How to execute p2p trade, "', style: TextStyle(color: Colors.black54, fontSize: 20), textAlign: TextAlign.center),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left:15,right:15,bottom: 10),
                        child: ElevatedButton(onPressed: (){
                          showLoadingDialog(context,"Subscribing. Please wait");
                          sendOTPCode("money", args.user!.id.toString(), 0).then((value){
                            Navigator.pop(context);
                            setState(() {
                              if(value.success == true){
                                _displayTextInputDialog(context,"14a06d90-5749-11ec-84ce-cd1b93b8e99d");
                              }else{
                                if(value.msg == null){
                                  AppOverlay.snackbar(message: "An Error Occurred");
                                }else{
                                  AppOverlay.snackbar(message: value.msg.toString());
                                }
                              }
                            });
                          });
                        }, child: Text("Subscribe"),style: ElevatedButton.styleFrom(primary:Colors.black)),
                      )
                    ],
                  ),
                )
              ),
            ),
            Container(
              height:400,
              child: Padding(
                  padding: const EdgeInsets.all(12.0),
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
                          child:  Text('Standard Plan', style: TextStyle(color: Colors.black87, fontSize: 20,fontWeight: FontWeight.bold),textAlign: TextAlign.center),
                        ),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(left:15,right:15,bottom: 2,top: 10),
                          child:  Text('NGN180,000.00', style: TextStyle(color: Colors.black54, fontSize: 25), textAlign: TextAlign.center),
                        ),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(left:15,right:15,bottom: 10,top: 10),
                          child:  Text('Offers = "Basic+, Fundamental Analysis, Technical Analysis, Sentimental Analysis, Risk Management, Candlesticks, Use of indicators, Trading Psychology, Practical trading Session"', style: TextStyle(color: Colors.black54, fontSize: 20), textAlign: TextAlign.center),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left:15,right:15,bottom: 10),
                          child: ElevatedButton(onPressed: (){
                            showLoadingDialog(context,"Subscribing. Please wait");
                            sendOTPCode("money", args.user!.id.toString(), 180000).then((value){
                              Navigator.pop(context);
                              setState(() {
                                if(value.success == true){
                                  _displayTextInputDialog(context,"b45e70c0-5749-11ec-84ce-cd1b93b8e99d");
                                }else{
                                  if(value.msg == null){
                                    AppOverlay.snackbar(message: "An Error Occurred");
                                  }else{
                                    AppOverlay.snackbar(message: value.msg.toString());
                                  }
                                }
                              });
                            });
                          }, child: Text("Subscribe"),style: ElevatedButton.styleFrom(primary:Colors.black)),
                        )
                      ],
                    ),
                  )
              ),
            ),
            Container(
              height:500,
              child: Padding(
                  padding: const EdgeInsets.all(12.0),
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
                          child:  Text('Premium Plan', style: TextStyle(color: Colors.black87, fontSize: 20,fontWeight: FontWeight.bold),textAlign: TextAlign.center),
                        ),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(left:15,right:15,bottom: 2,top: 10),
                          child:  Text('NGN184,500.00', style: TextStyle(color: Colors.black54, fontSize: 25), textAlign: TextAlign.center),
                        ),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(left:15,right:15,bottom: 10,top: 10),
                          child:  Text('Offers = "Standard+, Staking and farming, Margin and Futures Trading, Dollar-cost Averaging {DCA}, Decentralized finance {DEFI}, non-fungible token {NFT}, Initial dex offerings {IDO}, 1month Free access to our VIP signal room, Offline training opportunity, Free Certification, 100% cash refund to the best student + employment opportunity @ PAYBUYMAX"', style: TextStyle(color: Colors.black54, fontSize: 20), textAlign: TextAlign.center),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left:15,right:15,bottom: 10),
                          child: ElevatedButton(onPressed: (){
                            showLoadingDialog(context,"Subscribing. Please wait");
                            sendOTPCode("money", args.user!.id.toString(), 205000).then((value){
                              Navigator.pop(context);
                              setState(() {
                                if(value.success == true){
                                  _displayTextInputDialog(context,"771983c0-574a-11ec-84ce-cd1b93b8e99d");
                                }else{
                                  if(value.msg == null){
                                    AppOverlay.snackbar(message: "An Error Occurred");
                                  }else{
                                    AppOverlay.snackbar(message: value.msg.toString());
                                  }
                                }
                              });
                            });
                          }, child: Text("Subscribe"),style: ElevatedButton.styleFrom(primary:Colors.black)),
                        )
                      ],
                    ),
                  )
              ),
            ),
          ],
        ),
      ),
    );
  }

}