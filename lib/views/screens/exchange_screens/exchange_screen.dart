import 'dart:ui';
import 'package:coingecko_dart/dataClasses/coins/CoinDataPoint.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pay_buy_max/controllers/providers/coin_price_provider.dart';
import 'package:pay_buy_max/views/screens/wallet_screens/wallet_arguments.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ExchangeScreen extends StatelessWidget {
  const ExchangeScreen();

  static const String route = "/exchangeScreen";

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CoinPriceProvider>(
            create: (context) => CoinPriceProvider()),
      ],
      child: const _ExchangeScreen(),
    );
  }
}

class _ExchangeScreen extends StatefulWidget {
  const _ExchangeScreen();

  @override
  State<StatefulWidget> createState() => _ExchangeState();
}

class _ExchangeState extends State<_ExchangeScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(systemNavigationBarColor: Color(0xFFFAFAFA)));

    AppBar appBar = AppBar(
      systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
          systemNavigationBarColor: Color(0xFFFAFAFA)),
      centerTitle: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Text("Gift Cards",
          style: TextStyle(color: Colors.blueGrey, fontSize: 18),
          textAlign: TextAlign.start),
      leading: IconButton(
          icon: new Icon(Icons.arrow_back_rounded), onPressed: () {}, color: Colors.blueGrey),
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
              child: Padding(
                padding:
                const EdgeInsets.only(left: 50, top: 5, bottom: 60),
                child: Column(),
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