import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pay_buy_max/controllers/providers/coin_price_provider.dart';
import 'package:pay_buy_max/generated/assets.dart';
import 'package:provider/provider.dart';

class AllWalletScreen extends StatelessWidget {
  const AllWalletScreen();

  static const String route = "/allWalletScreen";

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CoinPriceProvider>(
            create: (context) => CoinPriceProvider()),
      ],
      child: const _AllWalletScreen(),
    );
  }
}

class _AllWalletScreen extends StatefulWidget {
  const _AllWalletScreen();

  @override
  State<StatefulWidget> createState() => _AllWalletState();
}

class _AllWalletState extends State<_AllWalletScreen> {

  @override
  void initState() {
    super.initState();
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
            flex: 1,
            child: Container(
              decoration: BoxDecoration(image: DecorationImage(
                  opacity: 0.2,
                  image: AssetImage(
                      'assets/images/background_image.jpg'),
                  fit: BoxFit.cover)),
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