import 'dart:convert';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pay_buy_max/controllers/providers/coin_price_provider.dart';
import 'package:pay_buy_max/models/auth/sign_in_response_entity.dart';
import 'package:pay_buy_max/models/invest/investment_list_entity.dart';
import 'package:pay_buy_max/models/wallet/code_response_entity.dart';
import 'package:pay_buy_max/models/wallet/subscribe_response_entity.dart';
import 'package:pay_buy_max/views/widgets/chart_container.dart';
import 'package:pay_buy_max/views/widgets/overlays.dart';
import '../../../style_sheet.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class InvestmentScreen extends StatelessWidget {
  const InvestmentScreen();

  static const String route = "/investmentScreen";

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CoinPriceProvider>(
            create: (context) => CoinPriceProvider()),
      ],
      child: const _InvestmentScreen(),
    );
  }
}

class _InvestmentScreen extends StatefulWidget {
  const _InvestmentScreen();

  @override
  State<StatefulWidget> createState() => _InvestmentState();
}

class _InvestmentState extends State<_InvestmentScreen> {
  late List<InvestmentListPackages> investItems;
  late SignInResponseEntity args;
  late TextEditingController _textFieldController;

  @override
  void initState() {
    super.initState();
    _textFieldController = TextEditingController();
    investItems = new List<InvestmentListPackages>.from(List.empty());
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _getInvestmentListList();
    });
  }

  Future<void> _displayTextInputDialog(BuildContext context1,String planID,String amount,String userID) async {
    return showDialog(
        context: context1,
        builder: (context) {
          return AlertDialog(
            title: Text('Enter OTP Code'),
            content: TextField(
              controller: _textFieldController,
              keyboardType: TextInputType.number,
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
                  Navigator.pop(context1);
                  showLoadingDialog(context1, " Confirming Investment. Please Wait... ");
                  confirmSubscription(planID, _textFieldController.text,amount,userID).then((value){
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
                    _textFieldController.text = "";
                  });
                },
              ),
            ],
          );
        });
  }

  Future<void> _displayPriceInputDialog(BuildContext context1,String planID,String userID,InvestmentListPackages investItem) async {
    return showDialog(
        context: context1,
        builder: (context) {
          return AlertDialog(
            title: Text('Enter Amount'),
            content: TextField(
              controller: _textFieldController,
              keyboardType: TextInputType.numberWithOptions(signed: false,decimal: false),
              decoration: InputDecoration(hintText: "Enter Amount You Want To Invest",border: OutlineInputBorder()),
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
                  try {
                    Navigator.of(context1).pop();
                    var fromPrice = investItem.fromPrice!;
                    var toPrice = investItem.toPrice!;

                    var amt = double.parse(_textFieldController.text);

                    if(amt < fromPrice){
                      AppOverlay.snackbar(message: "Amount Less Than Minimum");
                    }else if(amt > toPrice){
                      AppOverlay.snackbar(message: "Amount Greater Than Maximum");
                    }else{
                      Navigator.pop(context1);
                      showLoadingDialog(context1, "Investment in progress. Please Wait... ");
                      sendOTPCode("money", args.user!.id.toString(),_textFieldController.text).then((value){
                        if(value.success == true){
                          _displayTextInputDialog(context1,planID,_textFieldController.text,userID);
                        }else{
                          if(value.msg == null){
                            AppOverlay.snackbar(message: "An Error Occurred");
                          }else{
                            AppOverlay.snackbar(message: value.msg.toString());
                          }
                        }
                        _textFieldController.text = "";
                      });
                    }
                  } catch(e){
                    AppOverlay.snackbar(message: "Enter a valid amount");
                  }
                },
              ),
            ],
          );
        });
  }

  Future<CodeResponseEntity> sendOTPCode(String type, String userID, String amount) async{
    try {
      String url = 'https://paybuymax.com/api/withdraw/code';

      var body = {"type":type,"userId":userID,"amount":amount};
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

  Future<SubscribeResponseEntity> confirmSubscription(String packageId, String code,String amount,String userID) async{
    try {
      String url = 'https://paybuymax.com/api/invest-now';

      var body = {"package_id":packageId,"code":code,"amount":amount,"user_id":userID};
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

  void _getInvestmentListList() {
    getInvestmentListList().then((value) {
      setState(() {
        if (value.status == true) {
          investItems = value.packages!;
        } else {
          investItems = List<InvestmentListPackages>.from(List.empty());
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

  Future<InvestmentListEntity> getInvestmentListList() async{
    try {
      String url = 'https://paybuymax.com/api/packages';

      final response = await http.get(Uri.parse(url),headers: {"Authorization":args.token.toString()});
      print(response.body);
      return InvestmentListEntity().fromJson(json.decode(response.body));
    } catch(e){
      var error = InvestmentListEntity();
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

    final double height = MediaQuery.of(context).size.height - (MediaQuery.of(context).padding.top);

    Container container = Container(
      height: height,
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: 250,
            color: StyleSheet.primaryColor.withOpacity(0.09),
            child:  Builder(
              builder: (context2) {
                if (investItems.isEmpty) {
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
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context1, position) {
                    return Container(
                      width: 250,
                      height: 250,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            elevation: 6,
                            color: Color(0xFF4B8800),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                side: BorderSide(color: Color(0xFF4B8800))
                            ),
                            child: Container(
                              width: 250,
                              height: 250,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      opacity: 0.15,
                                      image: AssetImage('assets/images/background_image.jpg'),
                                      fit: BoxFit.cover)),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left: 10,top: 10),
                                        child: Text(investItems.elementAt(position).name!,style: TextStyle(color: Color(0xFFFAFAFA), fontSize: 25),textAlign: TextAlign.start),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 10,top: 5),
                                        child: Text("NGN "+ investItems.elementAt(position).fromPrice.toString()+" - "+"NGN "+investItems.elementAt(position).toPrice.toString(),style: TextStyle(color: Colors.white60, fontSize: 15),textAlign: TextAlign.start),
                                      ),
                                      Spacer(flex: 1),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 10,top: 5),
                                        child: Text(investItems.elementAt(position).commission.toString()+" %",style: TextStyle(color: Colors.white60, fontSize: 15),textAlign: TextAlign.start),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 10,top: 5),
                                        child: Text(investItems.elementAt(position).duration.toString()+" Months",style: TextStyle(color: Colors.white60, fontSize: 15),textAlign: TextAlign.start),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: ElevatedButton(
                                          onPressed: () {
                                            var investItem = investItems.elementAt(position);
                                            _displayPriceInputDialog(context, investItem.id!, args.user!.id!,investItem);
                                          },
                                          child: Text("Invest Now",style: TextStyle(color: Color(0xFF4B8800))),
                                          style: ButtonStyle(
                                              backgroundColor: MaterialStateProperty.all(Color(0xFFFAFAFA)),
                                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0),side: BorderSide(color: Color(0xFFFAFAFA))))),
                                        ),
                                      )
                                    ]
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: investItems.length,
                );
              },
            ),
          ),
          Expanded(child: DefaultTabController(
              length: 2,
              child:Scaffold(
                appBar:  TabBar(
                  indicatorColor: Color(0xFF4B8800),
                  labelColor: Color(0xFF4B8800),
                  unselectedLabelColor: Colors.black45,
                  indicatorWeight: 1,
                  tabs: [
                    Tab(text: "My Investments",),
                    Tab(text: "History"),
                  ],
                ),
                backgroundColor: StyleSheet.primaryColor.withOpacity(0.09),
                body: TabBarView(
                  children: [
                    ListView.builder(
                      itemBuilder: (context, position) {
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
                                child: Transform.rotate(
                                    angle: -1,
                                    child: Icon(Icons.arrow_right_alt_outlined, color: Color(0xFF4B8800))),
                              ),
                              Expanded(
                                flex: 1,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 30, bottom: 5,top: 15),
                                      child: Text('Bronze Plan', style: TextStyle(color: Color(0xFF4B8800), fontSize: 18), textAlign: TextAlign.start),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 30, bottom: 15),
                                      child: Text('50.0k - 500.0k', style: TextStyle(fontSize: 15), textAlign: TextAlign.start),
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
                                      Text('NGN 50000', style: TextStyle(color: Colors.black, fontSize: 18), textAlign: TextAlign.start),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 30,top: 10),
                                        child: Text('27 November 2022', style: TextStyle(fontSize: 15), textAlign: TextAlign.start),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                      },
                      itemCount: 10,
                    ),
                    ListView.builder(
                      itemBuilder: (context, position) {
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
                                child: Transform.rotate(
                                    angle: -1,
                                    child: Icon(Icons.arrow_right_alt_outlined, color: Color(0xFF4B8800))),
                              ),
                              Expanded(
                                flex: 1,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 30, bottom: 5,top: 15),
                                      child: Text('Bronze Plan', style: TextStyle(color: Color(0xFF4B8800), fontSize: 18), textAlign: TextAlign.start),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 30, bottom: 15),
                                      child: Text('50.0k - 500.0k', style: TextStyle(fontSize: 15), textAlign: TextAlign.start),
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
                                      Text('NGN 50000', style: TextStyle(color: Colors.black, fontSize: 18), textAlign: TextAlign.start),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 30,top: 10),
                                        child: Text('27 November 2022', style: TextStyle(fontSize: 15), textAlign: TextAlign.start),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                      },
                      itemCount: 10,
                    ),
                  ],
                ),
              ),
          )
          )
        ],
      ),
    );

    return LayoutBuilder(
      builder: (_, constraints) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Scaffold(
            body: container,
          ),
        );
      },
    );
  }

}