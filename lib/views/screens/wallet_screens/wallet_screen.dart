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
  late List<CoinDataPoint> btcIt;
  late List<CoinDataPoint> btc1;
  late List<CoinDataPoint> btc7;
  late List<CoinDataPoint> btc30;
  late List<CoinDataPoint> btc180;
  late List<CoinDataPoint> btc360;

  late String type = "";

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _onListRefresh(type);
    });
    btcIt = new List<CoinDataPoint>.from(List.empty());
    btc1 = new List<CoinDataPoint>.from(List.empty());
    btc7 = new List<CoinDataPoint>.from(List.empty());
    btc30 = new List<CoinDataPoint>.from(List.empty());
    btc180 = new List<CoinDataPoint>.from(List.empty());
    btc360 = new List<CoinDataPoint>.from(List.empty());

    priceController = new TextEditingController(text: "NGN 3,982.70");
    priceIncreaseController = new TextEditingController(text: "0.00125");
    walletController = new TextEditingController(text: "BTC");
  }

  void buy(){}

  void sell(){}

  List<Color> gradientColors = [Color(0xFF4B8800), Color(0xFF4B8800),];

  List<Color> gradientWhiteColors = [const Color(0xFF4B8800), const Color(0xFFFAFAFA),];

  LineChartData mainData(List<CoinDataPoint> chartList) {
    List<FlSpot> flSpotList = new List<FlSpot>.from(List.empty());
    List<String> priceValues = new List<String>.from(List.empty());
    List<DateTime> dayValues = new List<DateTime>.from(List.empty());

    double millisecond = 6.0;
    double minMillisecond = 0;
    double price = 11.0;
    double minPrice = 0;

    chartList.sort((a, b) {
      return a.date!.compareTo(b.date!);
    });

    if (chartList.isNotEmpty) {
      var date = DateTime.now().subtract(Duration(days: 7));
      for (var chartData in chartList) {
        if (chartData.price!.toDouble() > minPrice) {
          minPrice = chartData.price!;
        }
        if (chartData.date!.millisecondsSinceEpoch > minMillisecond) {
          minMillisecond = chartData.date!.millisecondsSinceEpoch.toDouble();
        }
      }
      for (var chartData in chartList) {
        dayValues.add(date);
        date.add(Duration(days: 1));
        priceValues.add(chartData.price.toString());
        if (chartData.date!.millisecondsSinceEpoch > millisecond) {
          millisecond = chartData.date!.millisecondsSinceEpoch.toDouble();
        }

        if (chartData.price!.toDouble() > price) {
          price = chartData.price!;
        }

        if (chartData.price!.toDouble() < minPrice) {
          minPrice = chartData.price!;
        }

        if (chartData.date!.millisecondsSinceEpoch < minMillisecond) {
          minMillisecond = chartData.date!.millisecondsSinceEpoch.toDouble();
        }

        flSpotList.add(new FlSpot(
            chartData.date!.millisecondsSinceEpoch.toDouble(),
            chartData.price!.toDouble()));
      }
    }

    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: false,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: Colors.black12,
            strokeWidth: 1,
            dashArray: [5, 10, 5]
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: SideTitles(showTitles: false),
        topTitles: SideTitles(showTitles: false),
        bottomTitles: SideTitles(
          showTitles: false,
          reservedSize: 22,
          interval: 1,
          getTextStyles: (context, value) => const TextStyle(
              color: Color(0xFFFAFAFA),
              fontWeight: FontWeight.bold,
              fontSize: 10),
          getTitles: (values) {
            switch (values.toInt()) {
              case 1:
                return 'SUN';
              case 3:
                return 'TUE';
              case 5:
                return 'WED';
              case 7:
                return 'FRI';
              case 9:
                return 'SUN';
            }
            return '';
          },
          margin: 8,
        ),
        leftTitles: SideTitles(
          showTitles: false,
          interval: 1,
          getTextStyles: (context, value) => const TextStyle(
            color: Color(0xff67727d),
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
          getTitles: (value) {
            switch (value.toInt()) {
              case 1:
                return '10k';
              case 3:
                return '30k';
              case 5:
                return '50k';
              case 7:
                return '70k';
            }
            return '';
          },
          reservedSize: 32,
          margin: 12,
        ),
      ),
      borderData: FlBorderData(
          show: true, border: Border.all(color: Colors.transparent, width: 0)),
      minX: minMillisecond,
      maxX: millisecond,
      minY: minPrice,
      maxY: price,
      lineBarsData: [
        LineChartBarData(
          spots: flSpotList,
          isCurved: true,
          colors: gradientColors,
          barWidth: 3,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradientTo: Offset(0, 1),
            colors: gradientWhiteColors
                .map((color) => color.withOpacity(0.2))
                .toList(),
          ),
        ),
      ],
    );

  }

  int days = 7;
  RefreshController _refreshController = RefreshController(initialRefresh: false);
  void _onListRefresh(String type) {
    if(days == 1){
      if(btc1.isNotEmpty){
        setState((){
          btcIt = btc1.toList();
        });
      }else{
        onListRefresh(type);
      }
    }
    else if(days == 7){
      if(btc7.isNotEmpty){
        setState((){
          btcIt = btc7.toList();
        });
      }else{
        onListRefresh(type);
      }
    }
    else if(days == 30){
      if(btc30.isNotEmpty){
        setState((){
          btcIt = btc30.toList();
        });
      }else{
        onListRefresh(type);
      }
    }
    else if(days == 183){
      if(btc180.isNotEmpty){
        setState((){
          btcIt = btc180.toList();
        });
      }else{
        onListRefresh(type);
      }
    }
    else if(days == 366){
      if(btc360.isNotEmpty){
        setState((){
          btcIt = btc360.toList();
        });
      }else{
        onListRefresh(type);
      }
    }
  }

  void onListRefresh(String type){
    var date = DateTime.now();
    if(type == "Bitcoin") {
      Provider.of<CoinPriceProvider>(context, listen: false).getBitCoinMarketChart(date.subtract(Duration(days: days)), date).then((value) {
        _refreshController.refreshCompleted();
        setState(() {
          if(days == 1){
            btc1 = value.data;
          }else if(days == 7){
            btc7 = value.data;
          }else if(days == 30){
            btc30 = value.data;
          }else if(days == 183){
            btc180 = value.data;
          }else if(days == 366){
            btc360 = value.data;
          }
          btcIt = value.data;
        });
      }, onError: (error) {
        print(error);
        _refreshController.refreshFailed();
      });
    }
    if(type == "Tether"){
      Provider.of<CoinPriceProvider>(context, listen: false).getTetherMarketChart(date.subtract(Duration(days: days)), date).then((value) {
        _refreshController.refreshCompleted();
        setState(() {
          if(days == 1){
            btc1 = value.data;
          }else if(days == 7){
            btc7 = value.data;
          }else if(days == 30){
            btc30 = value.data;
          }else if(days == 183){
            btc180 = value.data;
          }else if(days == 366){
            btc360 = value.data;
          }
          btcIt = value.data;
        });
      }, onError: (error) {
        print(error);
        _refreshController.refreshFailed();
      });
    }
    if(type == "Ethereum"){
      Provider.of<CoinPriceProvider>(context, listen: false).getEthereumMarketChart(date.subtract(Duration(days: days)), date).then((value) {
        _refreshController.refreshCompleted();
        setState(() {
          if(days == 1){
            btc1 = value.data;
          }else if(days == 7){
            btc7 = value.data;
          }else if(days == 30){
            btc30 = value.data;
          }else if(days == 183){
            btc180 = value.data;
          }else if(days == 366){
            btc360 = value.data;
          }
          btcIt = value.data;
        });
      }, onError: (error) {
        print(error);
        _refreshController.refreshFailed();
      });
    }
  }

  void onSwipeListRefresh(String type){
    var date = DateTime.now();
    if(type == "Bitcoin") {
      Provider.of<CoinPriceProvider>(context, listen: false).getBitCoinMarketChart(date.subtract(Duration(days: days)), date).then((value) {
        _refreshController.refreshCompleted();
        setState(() {
          if(days == 1){
            btc1 = value.data;
          }else if(days == 7){
            btc7 = value.data;
          }else if(days == 30){
            btc30 = value.data;
          }else if(days == 183){
            btc180 = value.data;
          }else if(days == 366){
            btc360 = value.data;
          }
          btcIt = value.data;
        });
      }, onError: (error) {
        print(error);
        _refreshController.refreshFailed();
      });
    }
    if(type == "Tether"){
      Provider.of<CoinPriceProvider>(context, listen: false).getTetherMarketChart(date.subtract(Duration(days: days)), date).then((value) {
        _refreshController.refreshCompleted();
        setState(() {
          if(days == 1){
            btc1 = value.data;
          }else if(days == 7){
            btc7 = value.data;
          }else if(days == 30){
            btc30 = value.data;
          }else if(days == 183){
            btc180 = value.data;
          }else if(days == 366){
            btc360 = value.data;
          }
          btcIt = value.data;
        });
      }, onError: (error) {
        print(error);
        _refreshController.refreshFailed();
      });
    }
    if(type == "Ethereum"){
      Provider.of<CoinPriceProvider>(context, listen: false).getEthereumMarketChart(date.subtract(Duration(days: days)), date).then((value) {
        _refreshController.refreshCompleted();
        setState(() {
          if(days == 1){
            btc1 = value.data;
          }else if(days == 7){
            btc7 = value.data;
          }else if(days == 30){
            btc30 = value.data;
          }else if(days == 183){
            btc180 = value.data;
          }else if(days == 366){
            btc360 = value.data;
          }
          btcIt = value.data;
        });
      }, onError: (error) {
        print(error);
        _refreshController.refreshFailed();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as WalletArguments;
    type = args.title;
    walletController.text = args.abbrev;

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
      title: Text(args.title,
          style: TextStyle(color: Colors.blueGrey, fontSize: 18),
          textAlign: TextAlign.start),
      leading: IconButton(
          icon: new Icon(Icons.arrow_back_rounded), onPressed: () {
        Navigator.of(context).pop();
      }, color: Colors.blueGrey),
      actions: [
        Padding(
          padding: const EdgeInsets.only(top: 12,bottom: 12,right: 12),
          child: CircleAvatar(
              backgroundColor: Colors.transparent,
              child: Image(
                  image: AssetImage(args.asset))),
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
                const EdgeInsets.only(left: 0, top: 0, bottom: 0),
                child: Column(
                  children: [
                    Flexible(child: LineChart(mainData(btcIt))),
                    ButtonBar(
                      alignment: MainAxisAlignment.center,
                      children: [
                        TextButton(onPressed: () {
                          days = 1;
                          _onListRefresh(args.title);
                        }, child: Text("1D",style: TextStyle(color: Color(0xFF4B8800)))),
                        TextButton(onPressed: () {
                          days = 7;
                          _onListRefresh(args.title);
                        }, child: Text("1W",style: TextStyle(color: Color(0xFF4B8800)))),
                        TextButton(onPressed: () {
                          days = 30;
                          _onListRefresh(args.title);
                        }, child: Text("1M",style: TextStyle(color: Color(0xFF4B8800)))),
                        TextButton(onPressed: () {
                          days = 183;
                          _onListRefresh(args.title);
                        }, child: Text("6M",style: TextStyle(color: Color(0xFF4B8800)))),
                        TextButton(onPressed: () {
                          days = 366;
                          _onListRefresh(args.title);
                        }, child: Text("1Y",style: TextStyle(color: Color(0xFF4B8800)))),
                      ],
                    )
                  ],
                ),
              )),
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
                  onSwipeListRefresh(args.title);
                },
                onLoading: null,
                child: container),
          ),
        );
      },
    );
  }
}