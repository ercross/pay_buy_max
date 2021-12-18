
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pay_buy_max/controllers/providers/coin_price_provider.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen();

  static const String route = "/walletScreen";

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CoinPriceProvider>(
            create: (context) => CoinPriceProvider()),
      ],
      child: const _WalletScreen(),
    );
  }
}

class _WalletScreen extends StatefulWidget {
  const _WalletScreen();

  @override
  State<StatefulWidget> createState() => _WalletState();
}

class _WalletState extends State<_WalletScreen> {
  late TextEditingController priceController;
  late TextEditingController priceIncreaseController;
  late TextEditingController walletController;

  @override
  void initState() {
    super.initState();

    priceController = new TextEditingController(text: "NGN 3,982.70");
    priceIncreaseController = new TextEditingController(text: "0.00125");
    walletController = new TextEditingController(text: "BTC");
  }

  void buy(){}

  void sell(){}

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(systemNavigationBarColor: Color(0xFFFAFAFA)));

    RefreshController _refreshController = RefreshController(initialRefresh: false);
    void _onListRefresh() {

    }

    AppBar appBar = AppBar(
      systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
          systemNavigationBarColor: Color(0xFFFAFAFA)),
      centerTitle: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Text('Bitcoin',
          style: TextStyle(color: Colors.blueGrey, fontSize: 18),
          textAlign: TextAlign.start),
      leading: IconButton(
          icon: new Icon(Icons.arrow_back_rounded), onPressed: () {}, color: Colors.blueGrey),
      actions: [
        Padding(
          padding: const EdgeInsets.only(top: 12,bottom: 12,right: 12),
          child: CircleAvatar(
              backgroundColor: Colors.transparent,
              child: Image(
                  image: AssetImage(
                      'assets/images/bitcoin_logo.png'))),
        )
      ],
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
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: IntrinsicHeight(
                              child: IntrinsicWidth(
                                child: TextField(controller: priceIncreaseController,readOnly: true,textAlign: TextAlign.center,enableInteractiveSelection: false,maxLines: 1,style:TextStyle(color: Color(0xFFC9782F),fontSize: 18),
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
                                child: TextField(controller: walletController,readOnly: true,enableInteractiveSelection: false,textAlign: TextAlign.center,maxLines: 1,style:TextStyle(color: Colors.blueGrey,fontSize: 18),
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        contentPadding: EdgeInsets.all(0)
                                    )
                                )
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: TextField(
                        controller: priceController,
                        readOnly: true,
                        enableInteractiveSelection: false,
                        keyboardType:  TextInputType.text,
                        textAlign: TextAlign.start,
                        style:TextStyle(color: Color(0xFFC9782F), fontSize: 40),
                        maxLines: 1,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.all(-5)
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: IntrinsicHeight(
                              child: ElevatedButton.icon(
                                onPressed: buy,
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(Color(0xFF4B8800)),
                                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0),side: BorderSide(color: Color(0xFF4B8800))))),
                                label: Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: Text('Buy',style: TextStyle(color:Color(0xFFFAFAFA),fontSize: 20),),
                                ),
                                icon: Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Transform.rotate(
                                      angle: 2,
                                      child: Icon(Icons.arrow_right_alt_outlined, color: Color(0xFFFAFAFA))),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: IntrinsicHeight(
                              child: ElevatedButton.icon(
                                onPressed: sell,
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(Color(0xFFFAFAFA)),
                                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0),side: BorderSide(color: Color(0xFF4B8800))))),
                                label: Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: Text('Sell',style: TextStyle(color:Color(0xFF4B8800),fontSize: 20),),
                                ),
                                icon: Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Transform.rotate(
                                      angle: -1,
                                      child: Icon(Icons.arrow_right_alt_outlined, color: Color(0xFF4B8800))),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
              flex: 1,
              child: Padding(
                padding:
                const EdgeInsets.only(left: 20, top: 5, bottom: 5),
                child: Column(),
              )),
          Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(),
              ))
        ],
      ),
    );

    return LayoutBuilder(
      builder: (_, constraints) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Scaffold(
            appBar: appBar,
            body: SmartRefresher(
                enablePullDown: true,
                enablePullUp: false,
                header: MaterialClassicHeader(
                  color: Color(0xFFFAFAFA),
                  backgroundColor: Color(0xFF4B8800),
                ),
                controller: _refreshController,
                onRefresh: _onListRefresh,
                onLoading: null,
                child: container),
          ),
        );
      },
    );
  }
}