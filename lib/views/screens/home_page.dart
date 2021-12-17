import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pay_buy_max/controllers/providers/current_service_provider.dart';
import 'package:pay_buy_max/generated/assets.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage();
  static const String route = "/landing";

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CurrentServiceProvider>(
      create: (_) => CurrentServiceProvider(),
      builder: (_, __) => _HomePage(),
    );
  }
}

class _HomePage extends StatelessWidget {
  const _HomePage();
  final color = const Color(0xFFC9782F);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(systemNavigationBarColor: Color(0xFFFFFFF)));
    AppBar appBar = AppBar(
      systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Colors.transparent, statusBarIconBrightness: Brightness.dark,),
      centerTitle: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
      title:Center(child: Text('PayBuyMax', style:TextStyle(color: Colors.blueGrey,fontSize: 18),textAlign: TextAlign.center)),
      leading: IconButton(icon: new Icon(Icons.menu), onPressed: () {},color: Colors.blueGrey),
      actions: [IconButton(icon: new Icon(Icons.notifications_rounded), onPressed: () {},color: Colors.blueGrey)],
    );

    final double height = MediaQuery.of(context).size.height - (appBar.preferredSize.height+MediaQuery.of(context).padding.top);

    Container container = Container(
      height: height,
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            height: height/2,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              image: DecorationImage(
                opacity: 0.1,
                image: AssetImage('assets/images/background_image.jpg'),
                fit: BoxFit.cover
              )
            ),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("\$3,982.70",textAlign: TextAlign.center,style:TextStyle(color: Color(0xFFC9782F),fontSize: 60),maxLines: 1),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Text("\$982.70",textAlign: TextAlign.center,maxLines: 1,style:TextStyle(color: Color(0xFFC9782F),fontSize: 16)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Text("(10%)",textAlign: TextAlign.center,maxLines: 1,style:TextStyle(color: Colors.blueGrey,fontSize: 16)),
                      ),
                      Text("this week",textAlign: TextAlign.center,maxLines: 1,style:TextStyle(color: Colors.blueGrey,fontSize: 16))
                    ],
                  )
                ],
              ),
            ),
          ),
          Container(
            height: height/2,
            width: MediaQuery.of(context).size.width,
          )
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