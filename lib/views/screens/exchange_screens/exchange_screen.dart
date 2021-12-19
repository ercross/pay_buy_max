import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pay_buy_max/controllers/providers/coin_price_provider.dart';
import 'package:pay_buy_max/generated/assets.dart';
import 'package:provider/provider.dart';

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
                    elevation: 6,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        side: BorderSide(color: Color(0xFF4B8800))
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(exchangeItems.elementAt(position).title,style: TextStyle(color: Colors.blueGrey, fontSize: 20),textAlign: TextAlign.start),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            height: 120,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(exchangeItems.elementAt(position).asset),
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
                      ],
                    ),
                  );
                },
                itemCount: exchangeItems.length,
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