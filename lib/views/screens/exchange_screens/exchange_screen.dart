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
    exchangeItems.add(new ExchangeItems("i Tunes", Assets.giftCardsGiftcards1));
    exchangeItems.add(new ExchangeItems("Starbucks", Assets.giftCardsGiftcards2));
    exchangeItems.add(new ExchangeItems("Walmart", Assets.giftCardsGiftcards3));
    exchangeItems.add(new ExchangeItems("Victoria’s secret", Assets.giftCardsGiftcards4));
    exchangeItems.add(new ExchangeItems("Target", Assets.giftCardsGiftcards5));
    exchangeItems.add(new ExchangeItems("Amazon", Assets.giftCardsGiftcards6));
    exchangeItems.add(new ExchangeItems("Best Buy", Assets.giftCardsGiftcards7));
    exchangeItems.add(new ExchangeItems("Chipotle", Assets.giftCardsGiftcards8));
    exchangeItems.add(new ExchangeItems("Fandango", Assets.giftCardsGiftcards9));
    exchangeItems.add(new ExchangeItems("Sephora", Assets.giftCardsGiftcards10));
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(systemNavigationBarColor: Color(0xFFFAFAFA)));
    final double height = MediaQuery.of(context).size.height - (MediaQuery.of(context).padding.top);

    Container container = Container(
      height: height,
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      opacity: 0.2,
                      image: AssetImage(
                          'assets/images/background_image.jpg'),
                      fit: BoxFit.cover)),
              child:   GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 4.0,
                    mainAxisSpacing: 4.0
                ),
                itemBuilder: (context, position) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      elevation: 6,
                      color: Color(0xFFFAFAFA),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          side: BorderSide(color: Color(0xFF4B8800))
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(10))
                              ),
                              child: Container(
                                color:Colors.white30,
                                child: Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Container(
                                    height: 100,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(exchangeItems.elementAt(position).asset),
                                        fit: BoxFit.contain
                                      )
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Text(exchangeItems.elementAt(position).title,style: TextStyle(fontSize: 20),textAlign: TextAlign.start)
                        ],
                      ),
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
            body: container,
          ),
        );
      },
    );
  }

}