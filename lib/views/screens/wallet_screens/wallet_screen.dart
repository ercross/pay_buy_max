import 'dart:ui';
import 'package:coingecko_dart/dataClasses/coins/CoinDataPoint.dart';
import 'package:fl_chart/fl_chart.dart';
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
  late List<CoinDataPoint> btcIt;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _onListRefresh();
    });
    btcIt = new List<CoinDataPoint>.from(List.empty());
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
  void _onListRefresh() {
    var date = DateTime.now();
    Provider.of<CoinPriceProvider>(context, listen: false).getBitCoinMarketChart(date.subtract(Duration(days: days)), date).then((value) {
      _refreshController.refreshCompleted();
      setState(() {
        btcIt = value.data;
      });
    }, onError: (error) {
      print(error);
      _refreshController.refreshFailed();
    });
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
                const EdgeInsets.only(left: 0, top: 0, bottom: 0),
                child: Column(
                  children: [
                    Flexible(child: LineChart(mainData(btcIt))),
                    ButtonBar(
                      alignment: MainAxisAlignment.center,
                      children: [
                        TextButton(onPressed: () {
                          days = 1;
                          _onListRefresh();
                        }, child: Text("1D",style: TextStyle(color: Color(0xFF4B8800)))),
                        TextButton(onPressed: () {
                          days = 7;
                          _onListRefresh();
                        }, child: Text("1W",style: TextStyle(color: Color(0xFF4B8800)))),
                        TextButton(onPressed: () {
                          days = 30;
                          _onListRefresh();
                        }, child: Text("1M",style: TextStyle(color: Color(0xFF4B8800)))),
                        TextButton(onPressed: () {
                          days = 180;
                          _onListRefresh();
                        }, child: Text("6M",style: TextStyle(color: Color(0xFF4B8800)))),
                        TextButton(onPressed: () {
                          days = 360;
                          _onListRefresh();
                        }, child: Text("1Y",style: TextStyle(color: Color(0xFF4B8800)))),
                      ],
                    )
                  ],
                ),
              )),
          Expanded(
              flex: 2,
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