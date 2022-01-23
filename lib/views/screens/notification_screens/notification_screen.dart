import 'dart:convert';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:pay_buy_max/controllers/providers/coin_price_provider.dart';
import 'package:pay_buy_max/generated/assets.dart';
import 'package:pay_buy_max/models/auth/sign_in_response_entity.dart';
import 'package:pay_buy_max/models/history/notifications_entity.dart';
import 'package:provider/provider.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen();

  static const String route = "/notificationScreen";

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CoinPriceProvider>(
            create: (context) => CoinPriceProvider()),
      ],
      child: const _NotificationScreen(),
    );
  }
}

class _NotificationScreen extends StatefulWidget {
  const _NotificationScreen();

  @override
  State<StatefulWidget> createState() => _NotificationState();
}

class _NotificationState extends State<_NotificationScreen> {
  NotificationsEntity? notificationsEntity;
  late SignInResponseEntity args;

  late TextEditingController textController;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      getNotifications().then((value) {
        setState(() {
          notificationsEntity = value;
        });
      });
    });
  }

  Future<NotificationsEntity> getNotifications() async {
    try{
      String url = 'https://paybuymax.com/api/notification';

      final response = await http.get(Uri.parse(url), headers: {"Authorization": args.token.toString()});
      print(response.statusCode);
      return NotificationsEntity().fromJson(json.decode(response.body));
    }catch(e){
      var historyBuy = NotificationsEntity();
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
      title: Text("Notifications", style: TextStyle(color: Color(0xFFFAFAFA), fontSize: 18), textAlign: TextAlign.start),
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
                if (notificationsEntity == null){
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(25),
                      child: CircularProgressIndicator(
                        color: Color(0xFFC9782F),
                      ),
                    ),
                  );
                }
                if (notificationsEntity!.notifications!.isEmpty) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(25),
                      child: Center(
                          child: Text('No Notifications Here',
                              style: TextStyle(color: Color(0xFFC9782F), fontSize: 18,fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center)),
                    ),
                  );
                }
                return ListView.builder(
                  itemBuilder: (context3, position) {
                    var currentPackage = notificationsEntity!.notifications!.elementAt(position);
                    var title = currentPackage.message.toString();

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
                            child: Icon(Icons.notifications_rounded, color: Color(0xFFC9782F)),
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
                  itemCount: notificationsEntity!.notifications!.length,
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