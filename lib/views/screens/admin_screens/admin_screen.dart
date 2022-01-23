import 'dart:convert';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:pay_buy_max/controllers/providers/coin_price_provider.dart';
import 'package:pay_buy_max/generated/assets.dart';
import 'package:pay_buy_max/models/auth/sign_in_response_entity.dart';
import 'package:pay_buy_max/models/messages/admin_messages_entity.dart';
import 'package:pay_buy_max/models/referral/referral_entity.dart';
import 'package:provider/provider.dart';

class AdminScreen extends StatelessWidget {
  const AdminScreen();

  static const String route = "/adminScreen";

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CoinPriceProvider>(
            create: (context) => CoinPriceProvider()),
      ],
      child: const _AdminScreen(),
    );
  }
}

class _AdminScreen extends StatefulWidget {
  const _AdminScreen();

  @override
  State<StatefulWidget> createState() => _AdminState();
}

class _AdminState extends State<_AdminScreen> {
  AdminMessagesEntity? adminMessagesEntity;
  late SignInResponseEntity args;

  late TextEditingController textController;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      getReferrals().then((value) {
        setState(() {
          adminMessagesEntity = value;
        });
      });
    });
  }

  Future<AdminMessagesEntity> getReferrals() async {
    try{
      String url = 'https://paybuymax.com/api/messages';

      final response = await http.get(Uri.parse(url), headers: {"Authorization": args.token.toString()});
      print(response.statusCode);
      return AdminMessagesEntity().fromJson(json.decode(response.body));
    }catch(e){
      var historyBuy = AdminMessagesEntity();
      historyBuy.status = false;
      return historyBuy;
    }
  }

  @override
  Widget build(BuildContext context) {
    args = ModalRoute.of(context)!.settings.arguments as SignInResponseEntity;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(systemNavigationBarColor: Color(0xFFFAFAFA)));

    Container container = Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Flex(
        direction: Axis.vertical,
        children: [
          Expanded(
            child: Builder(
              builder: (context2) {
                if (adminMessagesEntity == null){
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(25),
                      child: CircularProgressIndicator(
                        color: Color(0xFFC9782F),
                      ),
                    ),
                  );
                }
                if (adminMessagesEntity!.messages!.isEmpty) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(25),
                      child: Center(
                          child: Text('No Admin Messages Here Yet.',
                              style: TextStyle(color: Color(0xFFC9782F), fontSize: 18,fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center)),
                    ),
                  );
                }
                return ListView.builder(
                  itemBuilder: (context3, position) {
                    var currentPackage = adminMessagesEntity!.messages!.elementAt(position);
                    var title = currentPackage.title.toString();
                    var message = currentPackage.message.toString();

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
                            child: Icon(Icons.email, color: Color(0xFFC9782F)),
                          ),
                          Expanded(
                            flex: 1,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 30, bottom: 1,top: 15),
                                  child: Text(title, style: TextStyle(color: Color(0xFFC9782F), fontSize: 18), textAlign: TextAlign.start),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 30, bottom: 15),
                                  child: Text(message, style: TextStyle( fontSize: 15), textAlign: TextAlign.start),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  },
                  itemCount: adminMessagesEntity!.messages!.length,
                );
              },
            ),
          ),
        ],
      ),
    );

    return LayoutBuilder(
      builder: (_, constraints) {
        return container;
      },
    );
  }

}