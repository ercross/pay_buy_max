import 'dart:ui';
import 'package:coingecko_dart/dataClasses/coins/CoinDataPoint.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pay_buy_max/controllers/providers/coin_price_provider.dart';
import 'package:pay_buy_max/generated/assets.dart';
import 'package:pay_buy_max/models/asset.dart';
import 'package:pay_buy_max/views/screens/wallet_screens/wallet_arguments.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'exchange_items.dart';

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
  late List<ExchangeItems> exchangeItems;

  @override
  void initState() {
    super.initState();
    exchangeItems = new List<ExchangeItems>.from(List.empty());
    exchangeItems.add(new ExchangeItems("i Tunes", Assets.giftCardsGiftCards1));
    exchangeItems.add(new ExchangeItems("Starbucks", Assets.giftCardsGiftCards2));
    exchangeItems.add(new ExchangeItems("Walmart", Assets.giftCardsGiftCards3));
    exchangeItems.add(new ExchangeItems("Victoria’s secret", Assets.giftCardsGiftCards4));
    exchangeItems.add(new ExchangeItems("Target", Assets.giftCardsGiftCards5));
    exchangeItems.add(new ExchangeItems("Amazon", Assets.giftCardsGiftCards6));
    exchangeItems.add(new ExchangeItems("Best Buy", Assets.giftCardsGiftCards7));
    exchangeItems.add(new ExchangeItems("Chipotle", Assets.giftCardsGiftCards8));
    exchangeItems.add(new ExchangeItems("Fandango", Assets.giftCardsGiftCards9));
    exchangeItems.add(new ExchangeItems("Sephora", Assets.giftCardsGiftCards10));
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
              child:  ListView.builder(
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
                          child: Padding(
                            padding: const EdgeInsets.only(left: 30, bottom: 15,top: 15),
                            child: Text('0.0125', style: TextStyle(color: Color(0xFF4B8800), fontSize: 18), textAlign: TextAlign.start),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 30,top: 15,bottom: 15),
                            child: Wrap(
                              alignment: WrapAlignment.end,
                              children: [
                                Text('NGN 1000', style: TextStyle(color: Colors.black, fontSize: 18), textAlign: TextAlign.start)
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