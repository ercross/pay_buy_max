import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pay_buy_max/controllers/providers/current_service_provider.dart';
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

class _HomePage extends StatefulWidget {
  const _HomePage();

  @override
  State<StatefulWidget> createState() => _HomeState();

}

class _HomeState extends State<_HomePage>{
  final color = const Color(0xFFC9782F);
  late TextEditingController priceController;
  late TextEditingController priceIncreaseController;
  late TextEditingController percentController;
  late TextEditingController timeController;

  @override
  void initState(){
    super.initState();
    priceController = new TextEditingController(text: "\$3,982.70");
    priceIncreaseController = new TextEditingController(text: "\$982.70");
    percentController = new TextEditingController(text: "(10%)");
    timeController = new TextEditingController(text: "this week.");
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(systemNavigationBarColor: Color(0xFFFAFAFA)));

    AppBar appBar = AppBar(
      systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Colors.transparent, statusBarIconBrightness: Brightness.dark,systemNavigationBarColor: Colors.white),
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
                    opacity: 0.18,
                    image: AssetImage('assets/images/background_image.jpg'),
                    fit: BoxFit.cover
                )
            ),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(controller: priceController,readOnly: true,enableInteractiveSelection: false,keyboardType:  TextInputType.text,textAlign: TextAlign.center,style:TextStyle(color: Color(0xFFC9782F),fontSize: 60),maxLines: 1,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(-5)
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: IntrinsicHeight(
                          child: IntrinsicWidth(
                            child: TextField(controller: priceIncreaseController,readOnly: true,textAlign: TextAlign.center,enableInteractiveSelection: false,maxLines: 1,style:TextStyle(color: Color(0xFFC9782F),fontSize: 16),
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.all(0)
                                )
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: IntrinsicWidth(
                            child: TextField(controller: percentController,readOnly: true,enableInteractiveSelection: false,textAlign: TextAlign.center,maxLines: 1,style:TextStyle(color: Colors.blueGrey,fontSize: 16),
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.all(0)
                                )
                            )
                        ),
                      ),
                      IntrinsicWidth(
                          child: TextField(controller: timeController,readOnly: true,enableInteractiveSelection: false,textAlign: TextAlign.center,maxLines: 1,style:TextStyle(color: Colors.blueGrey,fontSize: 16),
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.all(0)
                              )
                          )
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
          Container(
            height: height/2,
            width: MediaQuery.of(context).size.width,
            color: Color(0xFFFAFAFA),
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