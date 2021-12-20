import 'dart:ui';
import 'package:coingecko_dart/dataClasses/coins/CoinDataPoint.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pay_buy_max/controllers/providers/coin_price_provider.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class LocalWalletScreen extends StatelessWidget {
  const LocalWalletScreen();

  static const String route = "/localWalletScreen";

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CoinPriceProvider>(
            create: (context) => CoinPriceProvider()),
      ],
      child: const _LocalWalletScreen(),
    );
  }
}

class _LocalWalletScreen extends StatefulWidget {
  const _LocalWalletScreen();

  @override
  State<StatefulWidget> createState() => _LocalWalletState();
}

class _LocalWalletState extends State<_LocalWalletScreen> {
  late TextEditingController priceController;
  late TextEditingController priceIncreaseController;
  late TextEditingController localWalletController;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      onListRefresh();
    });

    priceController = new TextEditingController(text: "NGN 3,982.70");
    priceIncreaseController = new TextEditingController(text: "0.00125");
    localWalletController = new TextEditingController(text: "NGN");
  }

  void buy(){}

  void sell(){}

  RefreshController _refreshController = RefreshController(initialRefresh: false);
  void onListRefresh(){
    var date = DateTime.now();
    Provider.of<CoinPriceProvider>(context, listen: false).getBitCoinMarketChart(date.subtract(Duration(days: 7)), date).then((value) {
      _refreshController.refreshCompleted();
    }, onError: (error) {
      print(error);
      _refreshController.refreshFailed();
    });
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
      title: Text("Wallet", style: TextStyle(color: Colors.blueGrey, fontSize: 18), textAlign: TextAlign.start),
      leading: IconButton(icon: new Icon(Icons.arrow_back_rounded), onPressed: () {Navigator.of(context).pop();},
          color: Colors.blueGrey),
      actions: [
        Padding(
          padding: const EdgeInsets.only(top: 12,bottom: 12,right: 12),
          child: CircleAvatar(
              backgroundColor: Colors.transparent,
              child: Image(image: AssetImage("assets/images/naira.png"))),
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
                                child: TextField(controller: localWalletController,readOnly: true,enableInteractiveSelection: false,textAlign: TextAlign.center,maxLines: 1,style:TextStyle(color: Colors.blueGrey,fontSize: 18),
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
                                  child: Text('Fund',style: TextStyle(color:Color(0xFFFAFAFA),fontSize: 20),),
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
                                  child: Text('Withdraw',style: TextStyle(color:Color(0xFF4B8800),fontSize: 20),),
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
              flex: 2,
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text('Transactions', style: TextStyle(color: Colors.blueGrey, fontSize: 18), textAlign: TextAlign.start),
                    ),
                    Expanded(
                      child: ListView.builder(
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
                    )
                  ],
                ),
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
                onRefresh: (){
                  onListRefresh();
                },
                onLoading: null,
                child: container),
          ),
        );
      },
    );
  }
}