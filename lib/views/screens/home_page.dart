import 'package:coingecko_dart/coingecko_dart.dart';
import 'package:coingecko_dart/dataClasses/coins/CoinDataPoint.dart';
import 'package:coingecko_dart/dataClasses/coins/PricedCoin.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fragment_navigate/navigate-control.dart';
import 'package:fragment_navigate/navigate-support.dart';
import 'package:pay_buy_max/controllers/providers/coin_price_provider.dart';
import 'package:pay_buy_max/views/screens/exchange_screens/exchange_screen.dart';
import 'package:pay_buy_max/views/screens/learn_screens/learn_screen.dart';
import 'package:pay_buy_max/views/screens/wallet_screens/all_wallet_balance.dart';
import 'package:pay_buy_max/views/screens/wallet_screens/local_wallet_screen.dart';
import 'package:pay_buy_max/views/screens/wallet_screens/wallet_arguments.dart';
import 'package:pay_buy_max/views/screens/wallet_screens/wallet_screen.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'investment_screens/investment_screen.dart';
import 'notification_screens/notification_screen.dart';

class HomePage extends StatelessWidget {
  const HomePage();

  static const String route = "/home";

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CoinPriceProvider>(
            create: (context) => CoinPriceProvider()),
      ],
      child: const _HomePage(),
    );
  }
}

class _HomePage extends StatefulWidget {
  const _HomePage();

  @override
  State<StatefulWidget> createState() => _HomeState();
}

class _HomeState extends State<_HomePage> {
  final color = const Color(0xFFC9782F);
  late TextEditingController priceController;
  late TextEditingController priceIncreaseController;
  late TextEditingController percentController;
  late TextEditingController timeController;

  late TextEditingController walletController;
  late TextEditingController bitcoinController;
  late TextEditingController usdtController;
  late TextEditingController ethController;



  List<Color> gradientColors = [
    Color(0xFFC9782F),
    Color(0xFFC9782F),
  ];

  List<Color> gradientWhiteColors = [
    const Color(0xFFFAFAFA),
    const Color(0xFFFAFAFA),
  ];

  bool showAvg = false;

  @override
  void initState() {
    super.initState();
    btcIt = new List<CoinDataPoint>.from(List.empty());

    priceController = new TextEditingController(text: "\$3,982.70");
    priceIncreaseController = new TextEditingController(text: "\$982.70");
    percentController = new TextEditingController(text: "(10%)");
    timeController = new TextEditingController(text: "this week.");

    walletController = new TextEditingController(text: "NGN 500");
    bitcoinController = new TextEditingController(text: "0.0125 btc");
    usdtController = new TextEditingController(text: "800.00 usdt");
    ethController = new TextEditingController(text: "12.123 eth");
  }

  void expand() {}

  void exchange() {
    Navigator.of(context).pushNamed(ExchangeScreen.route);
  }

  void learn() {
    Navigator.of(context).pushNamed(LearnScreen.route);
  }

  void investment() {
    Navigator.of(context).pushNamed(InvestmentScreen.route);
  }

  void moreDetails(WalletArguments walletArguments) {
    Navigator.of(context).pushNamed(WalletScreen.route,arguments: walletArguments);
  }

  void moreLocalDetails() {
    Navigator.of(context).pushNamed(LocalWalletScreen.route);
  }

  bool isSameDate(DateTime former, DateTime other) {
    return former.year == other.year &&
        former.month == other.month &&
        former.day == other.day;
  }

  String dayValue(List<double> dayValues) {
    var date = DateTime.now();
    if (dayValues.isNotEmpty) {
      for (var day in dayValues) {
        date = DateTime.fromMillisecondsSinceEpoch(day.toInt());
        switch (date.weekday) {
          case DateTime.sunday:
            return 'SUN';
          case DateTime.tuesday:
            return 'TUE';
          case DateTime.wednesday:
            return 'WED';
          case DateTime.friday:
            return 'FRI';
          case DateTime.sunday:
            return 'SUN';
        }
      }
    }
    return "";
  }

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
            colors: gradientWhiteColors
                .map((color) => color.withOpacity(0.5))
                .toList(),
          ),
        ),
      ],
    );
  }

  late List<CoinDataPoint> btcIt;
  final GlobalKey<ScaffoldState> key = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(systemNavigationBarColor: Color(0xFFC9782F)));

    AppBar appBar = AppBar(
      systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Colors.transparent, statusBarIconBrightness: Brightness.dark, systemNavigationBarColor: Color(0xFFFAFAFA)),
      centerTitle: true,
      backgroundColor: Color(0xFFC9782F),
      elevation: 0,
      title: Center(
          child: Text('PayBuyMax', style: TextStyle(color: Color(0xFFFAFAFA), fontSize: 18), textAlign: TextAlign.center)),
      leading: IconButton(
          icon: new Icon(Icons.menu), onPressed: () {key.currentState?.openDrawer();}, color: Color(0xFFFAFAFA)),
      actions: [
        IconButton(
            icon: new Icon(Icons.email_rounded),
            onPressed: () {
              Navigator.of(context).pushNamed(NotificationScreen.route);
            },
            color: Color(0xFFFAFAFA)),
        IconButton(
            icon: new Icon(Icons.notifications_rounded),
            onPressed: () {
              Navigator.of(context).pushNamed(NotificationScreen.route);
            },
            color: Color(0xFFFAFAFA))
      ],
    );

    final double height = MediaQuery.of(context).size.height - (appBar.preferredSize.height + MediaQuery.of(context).padding.top);

    Container newContainer = Container(
      height: height,
      width: MediaQuery.of(context).size.width,
      child: Expanded(
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 25,top: 10),
              child: Text("Welcome,",style: TextStyle(color: Color(0xFFC9782F), fontSize: 18)),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25),
              child: Text("Cephas Peter",style: TextStyle(color: Colors.black, fontSize: 25,fontWeight: FontWeight.bold)),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20,left: 25,right: 25,bottom:10),
              child: Container(
                  height: 250,
                  child: Card(
                    color: Color(0xFFFAFAFA),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10)), side: BorderSide(color: Color(0xFFC9782F))),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left:15,right:15),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Text('PayBuyMax', style: TextStyle(color: Colors.black54, fontSize: 18), textAlign: TextAlign.start),
                              ),
                              Expanded(
                                flex: 1,
                                child: Wrap(
                                  alignment: WrapAlignment.end,
                                  children: [
                                    IconButton(
                                        icon: new Icon(Icons.remove_red_eye_outlined),
                                        onPressed: () {

                                        }
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: Text('NGN 50,000', style: TextStyle(color: Color(0xFFC9782F), fontSize: 40,fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                            )
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: Text('Balance', style: TextStyle(color: Colors.black54, fontSize: 16), textAlign: TextAlign.center),
                            )
                          ],
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Table(
                                children: [
                                  TableRow(
                                      children: [
                                        Container(
                                          height:100,
                                          width:100,
                                          child: Padding(
                                            padding: const EdgeInsets.only(top:10,bottom:10,right:15,left:15),
                                            child: Card(
                                              elevation: 3,
                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  IconButton(
                                                      icon: new Icon(Icons.send_rounded),
                                                      onPressed: () {

                                                      },
                                                  ),
                                                  Text('Send', style: TextStyle(fontSize: 14), textAlign: TextAlign.center)
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height:100,
                                          width:100,
                                          child: Padding(
                                            padding: const EdgeInsets.only(top:10,bottom:10,right:15,left:15),
                                            child: Card(
                                              elevation: 3,
                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  IconButton(
                                                    icon: new Icon(Icons.call_received_rounded),
                                                    onPressed: () {

                                                    },
                                                  ),
                                                  Text('Receive', style: TextStyle(fontSize: 14), textAlign: TextAlign.center)
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height:100,
                                          width:100,
                                          child: Padding(
                                            padding: const EdgeInsets.only(top:10,bottom:10,right:15,left:15),
                                            child: Card(
                                              elevation: 3,
                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  IconButton(
                                                    icon: new Icon(Icons.shopping_cart),
                                                    onPressed: () {

                                                    },
                                                  ),
                                                  Text('Buy', style: TextStyle(fontSize: 14), textAlign: TextAlign.center)
                                                ],
                                              ),
                                            ),
                                          ),
                                        )
                                      ]
                                  )
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                )
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top:15,right: 25,left: 25),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Text('Coins', style: TextStyle(color: Colors.black, fontSize: 18,fontWeight: FontWeight.bold), textAlign: TextAlign.start),
                  ),
                  Expanded(
                    flex: 1,
                    child: Wrap(
                      alignment: WrapAlignment.end,
                      children: [
                        ElevatedButton(
                          onPressed: expand,
                          style: ButtonStyle(
                              elevation: MaterialStateProperty.resolveWith<double>((Set<MaterialState> states) {
                                if (states.contains(MaterialState.pressed))
                                  return 10.0;
                                return 0.0;
                                },
                              ),
                              backgroundColor: MaterialStateProperty.all(Color(0xFFFAFAFA)),
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.circular(10.0),
                                      side: BorderSide(color: Color(0xFFC9782F)))
                              )
                          ),
                          child: Text('NGN',style: TextStyle(color: Colors.black, fontSize: 18,fontWeight: FontWeight.bold)),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(25),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        child: Image(image: AssetImage("assets/images/bitcoin_logo.png"))),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text('Bitcoin', style: TextStyle(color: Colors.black, fontSize: 18), textAlign: TextAlign.start),
                        Text('BTC', style: TextStyle(color: Colors.black54, fontSize: 18), textAlign: TextAlign.start),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Wrap(
                      alignment: WrapAlignment.end,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text('NGN 55,000', style: TextStyle(color: Colors.black, fontSize: 18), textAlign: TextAlign.start),
                            Text('+ 10.1%', style: TextStyle(color: Color(0xFFC9782F), fontSize: 18), textAlign: TextAlign.start),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(25),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        child: Image(image: AssetImage("assets/images/ethereum_logo.png"))),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text('Ethereum', style: TextStyle(color: Colors.black, fontSize: 18), textAlign: TextAlign.start),
                        Text('ETH', style: TextStyle(color: Colors.black54, fontSize: 18), textAlign: TextAlign.start),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Wrap(
                      alignment: WrapAlignment.end,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text('NGN 3000', style: TextStyle(color: Colors.black, fontSize: 18), textAlign: TextAlign.start),
                            Text('+ 1.1%', style: TextStyle(color: Color(0xFFC9782F), fontSize: 18), textAlign: TextAlign.start),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(25),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        child: Image(image: AssetImage("assets/images/usdt_logo.png"))),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text('Tether', style: TextStyle(color: Colors.black, fontSize: 18), textAlign: TextAlign.start),
                        Text('USDT', style: TextStyle(color: Colors.black54, fontSize: 18), textAlign: TextAlign.start),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Wrap(
                      alignment: WrapAlignment.end,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text('NGN 580', style: TextStyle(color: Colors.black, fontSize: 18), textAlign: TextAlign.start),
                            Text('+ 1.1%', style: TextStyle(color: Color(0xFFC9782F), fontSize: 18), textAlign: TextAlign.start),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top:15,left: 25),
              child: Text("What do you want to do today?",style: TextStyle(color: Colors.black, fontSize: 18,fontWeight: FontWeight.bold)),
            ),
            Padding(
              padding: const EdgeInsets.all(25),
              child: Table(
                children: [
                  TableRow(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 8,bottom: 8),
                        child: Container(
                          height:150,
                          child: Card(
                            elevation: 8,
                            color: Color(0xFFE5E7FE),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Text('Crypto Currency', style: TextStyle(color: Colors.black, fontSize: 18), textAlign: TextAlign.start),
                                  Text('Buy and sell crypto currency today', style: TextStyle(color: Colors.black54, fontSize: 15), textAlign: TextAlign.start),
                                  Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Wrap(
                                          alignment: WrapAlignment.end,
                                          runAlignment: WrapAlignment.end,
                                          children: [
                                            CircleAvatar(
                                                backgroundColor: Colors.transparent,
                                                child: Image(image: AssetImage("assets/images/wallet.png")))
                                          ],
                                        ),
                                      )
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8,bottom: 8),
                        child: Container(
                          height:150,
                          child: Card(
                            elevation: 8,
                            color: Color(0xFFE5E7FE),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Text('Gift Card', style: TextStyle(color: Colors.black, fontSize: 18), textAlign: TextAlign.start),
                                  Text('Buy and sell gift cards today', style: TextStyle(color: Colors.black54, fontSize: 15), textAlign: TextAlign.start),
                                  Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Wrap(
                                          alignment: WrapAlignment.end,
                                          runAlignment: WrapAlignment.end,
                                          children: [
                                            CircleAvatar(
                                                backgroundColor: Colors.transparent,
                                                child: Image(image: AssetImage("assets/images/gift_card.png")))
                                          ],
                                        ),
                                      )
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 8,top: 8),
                        child: Container(
                          height:150,
                          child: Card(
                            elevation: 8,
                            color: Color(0xFFFEFEF4),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Text('Invest', style: TextStyle(color: Colors.black, fontSize: 18), textAlign: TextAlign.start),
                                  Text('Invest in daily and monthly plans today', style: TextStyle(color: Colors.black54, fontSize: 15), textAlign: TextAlign.start),
                                  Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Wrap(
                                          alignment: WrapAlignment.end,
                                          runAlignment: WrapAlignment.end,
                                          children: [
                                            CircleAvatar(
                                                backgroundColor: Colors.transparent,
                                                child: Image(image: AssetImage("assets/images/invest.png")))
                                          ],
                                        ),
                                      )
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8,top: 8),
                        child: Container(
                          height:150,
                          child: Card(
                            elevation: 8,
                            color: Color(0xFFFEFEF4),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Text('Learn', style: TextStyle(color: Colors.black, fontSize: 18), textAlign: TextAlign.start),
                                  Text('Subscribe to courses today', style: TextStyle(color: Colors.black54, fontSize: 15), textAlign: TextAlign.start),
                                  Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Wrap(
                                          alignment: WrapAlignment.end,
                                          runAlignment: WrapAlignment.end,
                                          children: [
                                            CircleAvatar(
                                                backgroundColor: Colors.transparent,
                                                child: Image(image: AssetImage("assets/images/subscribe.png")))
                                          ],
                                        ),
                                      )
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );

    final _fragNav = FragNavigate(
        firstKey: ValueKey(HomePage.route),
        screens: <Posit>[
          Posit(
            title: "Home",
              key: ValueKey(HomePage.route),
              fragment: newContainer
          ),
          Posit(
            title: "Wallet",
              key: ValueKey(AllWalletScreen.route),
              fragment: AllWalletScreen(),
          )
        ]
    );
    _fragNav.setDrawerContext = context;

    return StreamBuilder<FullPosit>(
        stream: _fragNav.outStreamFragment,
        builder: (con, s){
          if(s.data != null){
            return DefaultTabController(
                length: s.data!.bottom!.length,
                child: Scaffold(
                  key: _fragNav.drawerKey,
                  appBar: AppBar(
                    systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Colors.transparent, statusBarIconBrightness: Brightness.dark, systemNavigationBarColor: Color(0xFFFAFAFA)),
                    centerTitle: true,
                    backgroundColor: Color(0xFFC9782F),
                    elevation: 0,
                    title: Text((s.data!.title).toString()),
                    bottom: s.data!.bottom!.child,
                    actions: [
                      IconButton(
                          icon: new Icon(Icons.email_rounded),
                          onPressed: () {Navigator.of(context).pushNamed(NotificationScreen.route);},
                          color: Color(0xFFFAFAFA)),
                      IconButton(
                          icon: new Icon(Icons.notifications_rounded),
                          onPressed: () {Navigator.of(context).pushNamed(NotificationScreen.route);},
                          color: Color(0xFFFAFAFA))
                    ],
                  ),
                  drawer: Drawer(
                    backgroundColor: Color(0xFFC9782F),
                    child: ListView(
                      padding: EdgeInsets.zero,
                      children: [
                        const DrawerHeader(
                      decoration: BoxDecoration(
                        color: Color(0xFFFAFAFA),
                        image: DecorationImage(
                            image: AssetImage('assets/images/logo.png'),
                            fit: BoxFit.contain),
                      ),
                      child: Center(child: Text('',style: TextStyle(color: Color(0xFFFAFAFA), fontSize: 20))),
                    ),
                        ListTile(
                      iconColor: Color(0xFFFAFAFA),
                      textColor: Color(0xFFFAFAFA),
                      tileColor: Color(0xFFC9782F),
                      leading: Icon(Icons.dashboard_rounded),
                      title: const Text('Dashboard'),
                      onTap: () {
                        //DefaultTabController.of(context)!.animateTo(0);
                        _fragNav.putPosit(key: ValueKey(HomePage.route),closeDrawer: false);
                      },
                    ),
                        ExpansionTile(
                        collapsedTextColor: Color(0xFFFAFAFA),
                        collapsedIconColor: Color(0xFFFAFAFA),
                        iconColor: Color(0xFFFAFAFA),
                        textColor: Color(0xFFFAFAFA),
                        backgroundColor: Color(0xFFC9782F),
                        collapsedBackgroundColor: Color(0xFFC9782F),
                        leading: Icon(Icons.account_balance_wallet),
                        title: const Text('Wallets'),
                        children: [
                          ListTile(leading: Icon(Icons.arrow_forward_ios_rounded),title: const Text('Wallet Balance',style: TextStyle(color: Color(0xFFFAFAFA))),onTap: () {
                            _fragNav.putPosit(key: ValueKey(AllWalletScreen.route),closeDrawer: false);
                          }),
                          ListTile(leading: Icon(Icons.arrow_forward_ios_rounded),title: const Text('Fund Naira Wallet',style: TextStyle(color: Color(0xFFFAFAFA))),onTap: () {

                          }),
                          ListTile(leading: Icon(Icons.arrow_forward_ios_rounded),title: const Text('Fund Crypto Wallet',style: TextStyle(color: Color(0xFFFAFAFA))),onTap: () {

                          }),
                          ListTile(leading: Icon(Icons.arrow_forward_ios_rounded),title: const Text('History',style: TextStyle(color: Color(0xFFFAFAFA))),onTap: () {

                          }),
                        ]
                    ),
                        ExpansionTile(
                        collapsedTextColor: Color(0xFFFAFAFA),
                        collapsedIconColor: Color(0xFFFAFAFA),
                        iconColor: Color(0xFFFAFAFA),
                        textColor: Color(0xFFFAFAFA),
                        backgroundColor: Color(0xFFC9782F),
                        collapsedBackgroundColor: Color(0xFFC9782F),
                        leading: Icon(Icons.show_chart),
                        title: const Text('Exchange'),
                        children: [
                          ListTile(leading: Icon(Icons.arrow_forward_ios_rounded),title: const Text('Cryptos',style: TextStyle(color: Color(0xFFFAFAFA))),onTap: () {

                          }),
                          ListTile(leading: Icon(Icons.arrow_forward_ios_rounded),title: const Text('Gift Cards',style: TextStyle(color: Color(0xFFFAFAFA))),onTap: () {

                          })
                        ]
                    ),
                        ExpansionTile(
                        collapsedTextColor: Color(0xFFFAFAFA),
                        collapsedIconColor: Color(0xFFFAFAFA),
                        iconColor: Color(0xFFFAFAFA),
                        textColor: Color(0xFFFAFAFA),
                        backgroundColor: Color(0xFFC9782F),
                        collapsedBackgroundColor: Color(0xFFC9782F),
                        leading: Icon(Icons.book_rounded),
                        title: const Text('Learn'),
                        children: [
                          ListTile(leading: Icon(Icons.arrow_forward_ios_rounded),title: const Text('Courses',style: TextStyle(color: Color(0xFFFAFAFA))),onTap: () {

                          }),
                          ListTile(leading: Icon(Icons.arrow_forward_ios_rounded),title: const Text('My Plan',style: TextStyle(color: Color(0xFFFAFAFA))),onTap: () {

                          }),
                        ]
                    ),
                        ExpansionTile(
                        collapsedTextColor: Color(0xFFFAFAFA),
                        collapsedIconColor: Color(0xFFFAFAFA),
                        iconColor: Color(0xFFFAFAFA),
                        textColor: Color(0xFFFAFAFA),
                        backgroundColor: Color(0xFFC9782F),
                        collapsedBackgroundColor: Color(0xFFC9782F),
                        leading: Icon(Icons.show_chart),
                        title: const Text('Investments'),
                        children: [
                          ListTile(leading: Icon(Icons.arrow_forward_ios_rounded),title: const Text('My Investments',style: TextStyle(color: Color(0xFFFAFAFA))),onTap: () {

                          }),
                          ListTile(leading: Icon(Icons.arrow_forward_ios_rounded),title: const Text('Investments Package',style: TextStyle(color: Color(0xFFFAFAFA))),onTap: () {

                          }),
                          ListTile(leading: Icon(Icons.arrow_forward_ios_rounded),title: const Text('History',style: TextStyle(color: Color(0xFFFAFAFA))),onTap: () {

                          }),
                        ]
                    ),
                        ExpansionTile(
                        collapsedTextColor: Color(0xFFFAFAFA),
                        collapsedIconColor: Color(0xFFFAFAFA),
                        iconColor: Color(0xFFFAFAFA),
                        textColor: Color(0xFFFAFAFA),
                        backgroundColor: Color(0xFFC9782F),
                        collapsedBackgroundColor: Color(0xFFC9782F),
                        leading: Icon(Icons.history_rounded),
                        title: const Text('My Transactions'),
                        children: [
                          ListTile(leading: Icon(Icons.arrow_forward_ios_rounded),title: const Text('Sell',style: TextStyle(color: Color(0xFFFAFAFA))),onTap: () {

                          }),
                          ListTile(leading: Icon(Icons.arrow_forward_ios_rounded),title: const Text('Buy',style: TextStyle(color: Color(0xFFFAFAFA))),onTap: () {

                          }),
                        ]
                    ),
                        ExpansionTile(
                        iconColor: Color(0xFFFAFAFA),
                        textColor: Color(0xFFFAFAFA),
                        collapsedTextColor: Color(0xFFFAFAFA),
                        collapsedIconColor: Color(0xFFFAFAFA),
                        backgroundColor: Color(0xFFC9782F),
                        collapsedBackgroundColor: Color(0xFFC9782F),
                        leading: Icon(Icons.money),
                        title: const Text('Withdrawal'),
                        children: [
                          ListTile(leading: Icon(Icons.arrow_forward_ios_rounded),title: const Text('Withdraw Naira',style: TextStyle(color: Color(0xFFFAFAFA))),onTap: () {

                          }),
                          ListTile(leading: Icon(Icons.arrow_forward_ios_rounded),title: const Text('Withdraw Coin',style: TextStyle(color: Color(0xFFFAFAFA))),onTap: () {

                          }),
                          ListTile(leading: Icon(Icons.arrow_forward_ios_rounded),title: const Text('Transfer History',style: TextStyle(color: Color(0xFFFAFAFA))),onTap: () {

                          }),
                          ListTile(leading: Icon(Icons.arrow_forward_ios_rounded),title: const Text('My Withdrawals',style: TextStyle(color: Color(0xFFFAFAFA))),onTap: () {

                          }),
                        ]
                    ),
                        ListTile(
                      iconColor: Color(0xFFFAFAFA),
                      textColor: Color(0xFFFAFAFA),
                      tileColor: Color(0xFFC9782F),
                      leading: Icon(Icons.person_add_rounded),
                      title: const Text('My Referrals'),
                      onTap: () {

                      },
                    ),
                        ListTile(
                      iconColor: Color(0xFFFAFAFA),
                      textColor: Color(0xFFFAFAFA),
                      tileColor: Color(0xFFC9782F),
                      leading: Icon(Icons.admin_panel_settings_rounded),
                      title: const Text('Admin Messages'),
                      onTap: () {

                      },
                    ),
                        ListTile(
                      iconColor: Color(0xFFFAFAFA),
                      textColor: Color(0xFFFAFAFA),
                      tileColor: Color(0xFFC9782F),
                      leading: Icon(Icons.settings_rounded),
                      title: const Text('Settings'),
                      onTap: () {

                      },
                    ),
                        ListTile(
                      iconColor: Color(0xFFFAFAFA),
                      textColor: Color(0xFFFAFAFA),
                      tileColor: Color(0xFFC9782F),
                      leading: Icon(Icons.logout_rounded),
                      title: const Text('Log Out'),
                      onTap: () {

                      },
                    )
                      ],
                    ),
                  ),
                  body: ScreenNavigate(
                      child: s.data!.fragment,
                      control: _fragNav
                  ),
                )
            );
          }
          return Container();
        }
    );
  }
}
