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
  CourseListEntity? courses;

  @override
  void initState() {
    super.initState();
    _textFieldController = TextEditingController();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _getCoursesList();
    });
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

  Future<CodeResponseEntity> sendOTPCode(String type, String userID, double amount) async{
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

  void _getCoursesList() {
    getCoursesList().then((value) {
      setState(() {
        if (value.status == true) {
          courses = value;
        } else {
          courses = null;
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

  Future<CourseListEntity> getCoursesList() async{
    try {
      String url = 'https://paybuymax.com/api/courses';

      final response = await http.get(Uri.parse(url),headers: {"Authorization":args.token.toString()});
      print(response.body);
      return CourseListEntity().fromJson(json.decode(response.body));
    } catch(e){
      var error = CourseListEntity();
      error.status = false;
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
        child: Builder(
          builder: (context) {
            if (courses == null) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(25),
                  child: CircularProgressIndicator(
                    color: Color(0xFFC9782F),
                  ),
                ),
              );
            }
            return ListView.builder(
              itemBuilder: (context, position) {
                var course = courses!.courses!.elementAt(position);
                double? rate = course.discount! / 100;
                double? price = course.price! - (rate * course.price!);
                String rateText = "NGN " + price.toString();
                return Padding(
                    padding: const EdgeInsets.all(12.0),
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
                            child:  Text(course.name!, style: TextStyle(color: Colors.black87, fontSize: 20,fontWeight: FontWeight.bold),textAlign: TextAlign.center),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left:15,right:15,bottom: 10,top: 10),
                            child:  Text(rateText, style: TextStyle(color: Colors.black54, fontSize: 25), textAlign: TextAlign.center),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left:15,right:15,bottom: 10,top: 10),
                            child:  Text(course.courseOutlines!, style: TextStyle(color: Colors.black54, fontSize: 20), textAlign: TextAlign.center),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left:15,right:15,bottom: 10),
                            child: ElevatedButton(onPressed: (){
                              showLoadingDialog(context,"Subscribing. Please wait");
                              sendOTPCode("money", args.user!.id.toString(), price).then((value){
                                Navigator.pop(context);
                                setState(() {
                                  if(value.success == true){
                                    _displayTextInputDialog(context,course.id!);
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
                );
              },
              shrinkWrap: true,
              itemCount: courses!.courses!.length,
            );
          },
        ),
      ),
    );
  }

}