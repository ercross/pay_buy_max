import 'dart:html';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pay_buy_max/controllers/providers/coin_price_provider.dart';
import 'package:provider/provider.dart';

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

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(systemNavigationBarColor: Color(0xFFFAFAFA)));

    AppBar appBar = AppBar(
      systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
          systemNavigationBarColor: Color(0xFFFAFAFA)),
      centerTitle: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Text("Investment", style: TextStyle(color: Colors.blueGrey, fontSize: 18), textAlign: TextAlign.start),
      leading: IconButton(
          icon: new Icon(Icons.arrow_back_rounded), onPressed: () {
            Navigator.of(context).pop();
      }, color: Colors.blueGrey),
    );

    final double height = MediaQuery.of(context).size.height - (appBar.preferredSize.height + MediaQuery.of(context).padding.top);

    Container container = Container(
      height: height,
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      opacity: 0.2,
                      image: AssetImage(
                          'assets/images/background_image.jpg'),
                      fit: BoxFit.cover)),
              child:  ListView.builder(
                itemBuilder: (context, position) {
                  return Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        side: BorderSide(color: Color(0xFF4B8800))
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                     /* children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(InvestmentItems.elementAt(position).title,style: TextStyle(color: Colors.blueGrey, fontSize: 20),textAlign: TextAlign.start),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            height: 120,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(InvestmentItems.elementAt(position).asset),
                                    fit: BoxFit.contain
                                )
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: ElevatedButton(
                            onPressed: () {  },
                            child: Text("Sell"),
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(Color(0xFF4B8800)),
                                shape:
                                MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0),side: BorderSide(color: Color(0xFF4B8800))))),
                          ),
                        )
                      ]*/
                    ),
                  );
                },
                itemCount: 0,
              ),
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