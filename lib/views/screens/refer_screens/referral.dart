import 'dart:convert';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:pay_buy_max/controllers/providers/coin_price_provider.dart';
import 'package:pay_buy_max/generated/assets.dart';
import 'package:pay_buy_max/models/auth/sign_in_response_entity.dart';
import 'package:pay_buy_max/models/referral/referral_entity.dart';
import 'package:provider/provider.dart';

class ReferralScreen extends StatelessWidget {
  const ReferralScreen();

  static const String route = "/ReferralScreen";

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CoinPriceProvider>(
            create: (context) => CoinPriceProvider()),
      ],
      child: const _ReferralScreen(),
    );
  }
}

class _ReferralScreen extends StatefulWidget {
  const _ReferralScreen();

  @override
  State<StatefulWidget> createState() => _ReferralState();
}

class _ReferralState extends State<_ReferralScreen> {
  ReferralEntity? referralsEntity;
  late SignInResponseEntity args;

  late TextEditingController textController;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      getReferrals().then((value) {
        setState(() {
          referralsEntity = value;
        });
      });
    });
  }

  Future<ReferralEntity> getReferrals() async {
    try{
      String url = 'https://paybuymax.com/api/referrals';

      final response = await http.get(Uri.parse(url), headers: {"Authorization": args.token.toString()});
      print(response.statusCode);
      return ReferralEntity().fromJson(json.decode(response.body));
    }catch(e){
      var historyBuy = ReferralEntity();
      historyBuy.status = false;
      return historyBuy;
    }
  }

  @override
  Widget build(BuildContext context) {
    args = ModalRoute.of(context)!.settings.arguments as SignInResponseEntity;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(systemNavigationBarColor: Color(0xFFFAFAFA)));

    AppBar appBar = AppBar(
      systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
          systemNavigationBarColor: Color(0xFFFAFAFA)),
      centerTitle: true,
      backgroundColor: Color(0xFFC9782F),
      elevation: 0,
      title: Text("My Referrals", style: TextStyle(color: Color(0xFFFAFAFA), fontSize: 18), textAlign: TextAlign.start),
      leading: IconButton(icon: new Icon(Icons.arrow_back_rounded), onPressed: () {Navigator.of(context).pop();}, color: Color(0xFFFAFAFA)),
    );

    final double height = MediaQuery.of(context).size.height - (appBar.preferredSize.height + MediaQuery.of(context).padding.top);

    Container container = Container(
      height: height,
      width: MediaQuery.of(context).size.width,
      child: Flex(
        direction: Axis.vertical,
        children: [
          Expanded(
            child: Builder(
              builder: (context2) {
                if (referralsEntity == null){
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(25),
                      child: CircularProgressIndicator(
                        color: Color(0xFFC9782F),
                      ),
                    ),
                  );
                }
                if (referralsEntity!.referrals!.isEmpty) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(25),
                      child: Center(
                          child: Text('You have not referred anyone yet',
                              style: TextStyle(color: Color(0xFFC9782F), fontSize: 18,fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center)),
                    ),
                  );
                }
                return ListView.builder(
                  itemBuilder: (context3, position) {
                    var currentPackage = referralsEntity!.referrals!.elementAt(position);
                    var name = currentPackage.user!.name;
                    var email = currentPackage.user!.email.toString();

                    var title = "You referred ";

                    if(name == null){
                      title = ""+email;
                    }else{
                      title = ""+name.toString();
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
                            child: Icon(Icons.people_sharp, color: Color(0xFFC9782F)),
                          ),
                          Expanded(
                            flex: 1,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 30, bottom: 15,top: 15),
                                  child: Text(title, style: TextStyle(color: Color(0xFFC9782F), fontSize: 18), textAlign: TextAlign.start),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  },
                  itemCount: referralsEntity!.referrals!.length,
                );
              },
            ),
          ),
        ],
      ),
    );

    return LayoutBuilder(
      builder: (_, constraints) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Scaffold(
            appBar: appBar,
            body: container,
          ),
        );
      },
    );
  }

}