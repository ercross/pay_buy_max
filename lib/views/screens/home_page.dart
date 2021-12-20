import 'package:coingecko_dart/coingecko_dart.dart';
import 'package:coingecko_dart/dataClasses/coins/CoinDataPoint.dart';
import 'package:coingecko_dart/dataClasses/coins/PricedCoin.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
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

    CoinGeckoResult<List<PricedCoin>> btcItems = Provider.of<CoinPriceProvider>(context, listen: false).bitcoinPrice;
    CoinGeckoResult<List<PricedCoin>> ethItems = Provider.of<CoinPriceProvider>(context, listen: false).ethereumPrice;
    CoinGeckoResult<List<PricedCoin>> tetherItems = Provider.of<CoinPriceProvider>(context, listen: false).tetherPrice;

    CoinGeckoResult<List<CoinDataPoint>> bitcoinChart = Provider.of<CoinPriceProvider>(context, listen: false).bitcoinChart;
    CoinGeckoResult<List<CoinDataPoint>> ethereumChart = Provider.of<CoinPriceProvider>(context, listen: true).ethereumChart;
    CoinGeckoResult<List<CoinDataPoint>> tetherChart = Provider.of<CoinPriceProvider>(context, listen: true).tetherChart;

    RefreshController _refreshController = RefreshController(initialRefresh: false);
    void _onListRefresh() {
      var date = DateTime.now();
      Provider.of<CoinPriceProvider>(context, listen: false)
          .getBitCoinMarketChart(date.subtract(Duration(days: 7)), date)
          .then((value) {
        _refreshController.refreshCompleted();
        setState(() {
          showAvg = !showAvg;
          btcIt = value.data;
        });
      }, onError: (error) {
        print(error);
        _refreshController.refreshFailed();
      });
    }

    Container container = Container(
      height: height,
      width: MediaQuery.of(context).size.width,
      child: SmartRefresher(
        enablePullDown: true,
        enablePullUp: false,
        controller: _refreshController,
        onRefresh: _onListRefresh,
        onLoading: null,
        header: MaterialClassicHeader(
          color: Color(0xFFFAFAFA),
          backgroundColor: Color(0xFFC9782F),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              height: (height / 2) - appBar.preferredSize.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      opacity: 0.2,
                      image: AssetImage(
                          'assets/images/background_image.jpg'),
                      fit: BoxFit.cover)),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextField(
                    controller: priceController,
                    readOnly: true,
                    enableInteractiveSelection: false,
                    keyboardType:  TextInputType.text,
                    textAlign: TextAlign.center,
                    style:TextStyle(color: Color(0xFFC9782F), fontSize: 60),
                    maxLines: 1,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(-5)
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: IntrinsicHeight(
                          child: IntrinsicWidth(
                            child: TextField(controller: priceIncreaseController,readOnly: true,textAlign: TextAlign.center,enableInteractiveSelection: false,maxLines: 1,style:TextStyle(color: Color(0xFFC9782F),fontSize: 16),
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
                            child: TextField(controller: percentController,readOnly: true,enableInteractiveSelection: false,textAlign: TextAlign.center,maxLines: 1,style:TextStyle(color: Colors.blueGrey,fontSize: 16),
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.all(0)
                                )
                            )
                        ),
                      ),
                      IntrinsicWidth(
                          child: TextField(controller: timeController,readOnly: true,enableInteractiveSelection: false,textAlign: TextAlign.center,maxLines: 1,style:TextStyle(color: Colors.blueGrey,fontSize: 16),
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.all(0)
                              )
                          )
                      )
                    ],
                  )
                ],
              ),
            ),
            Container(
              height: (height / 2) + appBar.preferredSize.height,
              width: MediaQuery.of(context).size.width,
              color: Color(0xFFFAFAFA),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Flexible(
                      fit: FlexFit.tight,
                      flex: 1,
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 30),
                              child: Text('Funds',
                                  style: TextStyle(
                                      color: Colors.blueGrey, fontSize: 18),
                                  textAlign: TextAlign.start),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 30),
                              child: Wrap(
                                alignment: WrapAlignment.end,
                                children: [
                                  ElevatedButton.icon(
                                    onPressed: expand,
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Color(0xFFC9782F)),
                                        shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(18.0),
                                                side: BorderSide(
                                                    color: Color(0xFFC9782F))))),
                                    label: Text('Expand'),
                                    icon: Icon(Icons.list_rounded,
                                        color: Color(0xFFFAFAFA)),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      )),
                  Expanded(
                      flex: 6,
                      child: Padding(
                        padding:
                            const EdgeInsets.only(left: 20, top: 5, bottom: 5),
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Container(
                                width: 220.0,
                                decoration: BoxDecoration(
                                    color: Color(0xFFC9782F),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                    image: DecorationImage(
                                        opacity: 0.1,
                                        image: AssetImage(
                                            'assets/images/background_image.jpg'),
                                        fit: BoxFit.cover)),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 25, bottom: 8, top: 30),
                                      child: CircleAvatar(
                                          backgroundColor: Color(0xFFC9782F),
                                          child: SvgPicture.asset(
                                              'assets/images/naira.svg')),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 15, bottom: 1, top: 5),
                                      child: Text('Wallet Balance',
                                          style: TextStyle(
                                              color: Color(0xFFFAFAFA),
                                              fontSize: 20),
                                          textAlign: TextAlign.start),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 16),
                                      child: IntrinsicHeight(
                                        child: TextField(
                                          controller: walletController,
                                          readOnly: true,
                                          enableInteractiveSelection: false,
                                          keyboardType: TextInputType.text,
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              color: Colors.white70,
                                              fontSize: 15),
                                          maxLines: 1,
                                          decoration: InputDecoration(
                                              border: InputBorder.none,
                                              contentPadding:
                                                  EdgeInsets.only(top: -5)),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          Column(
                                            mainAxisSize: MainAxisSize.max,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(right: 16,bottom: 8),
                                                child: ElevatedButton.icon(
                                                  onPressed:(){
                                                    moreLocalDetails();
                                                  },
                                                  style: ButtonStyle(
                                                      backgroundColor:
                                                      MaterialStateProperty.all(Color(0xFFFAFAFA)),
                                                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0),side: BorderSide(color: Color(0xFFFAFAFA))))),
                                                  label: Text('Open',style: TextStyle(color:Color(0xFFC9782F)),),
                                                  icon: Icon(Icons.open_in_full_rounded, color: Color(0xFFC9782F)),
                                                ),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Container(
                                width: 200.0,
                                decoration: BoxDecoration(
                                    color: Color(0xFFC9782F),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                    image: DecorationImage(
                                        opacity: 0.1,
                                        image: AssetImage(
                                            'assets/images/background_image.jpg'),
                                        fit: BoxFit.cover)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 25, bottom: 8, top: 30),
                                      child: CircleAvatar(
                                          backgroundColor: Color(0xFFC9782F),
                                          child: Image(
                                              image: AssetImage(
                                                  'assets/images/bitcoin_logo.png'))),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 15, bottom: 1, top: 5),
                                      child: Text('Bitcoin',
                                          style: TextStyle(
                                              color: Color(0xFFFAFAFA),
                                              fontSize: 20),
                                          textAlign: TextAlign.start),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 16),
                                      child: IntrinsicHeight(
                                        child: TextField(
                                          controller: bitcoinController,
                                          readOnly: true,
                                          enableInteractiveSelection: false,
                                          keyboardType: TextInputType.text,
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              color: Colors.white70,
                                              fontSize: 15),
                                          maxLines: 1,
                                          decoration: InputDecoration(
                                              border: InputBorder.none,
                                              contentPadding:
                                                  EdgeInsets.only(top: -5)),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          Column(
                                            mainAxisSize: MainAxisSize.max,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(right: 16,bottom: 8),
                                                child: ElevatedButton.icon(
                                                  onPressed: (){
                                                    moreDetails(WalletArguments("Bitcoin","BTC","assets/images/bitcoin_logo.png"));
                                                  },
                                                  style: ButtonStyle(
                                                      backgroundColor:
                                                      MaterialStateProperty.all(Color(0xFFFAFAFA)),
                                                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0),side: BorderSide(color: Color(0xFFFAFAFA))))),
                                                  label: Text('Open',style: TextStyle(color:Color(0xFFC9782F)),),
                                                  icon: Icon(Icons.open_in_full_rounded, color: Color(0xFFC9782F)),
                                                ),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Container(
                                width: 200.0,
                                decoration: BoxDecoration(
                                    color: Color(0xFFC9782F),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                    image: DecorationImage(
                                        opacity: 0.1,
                                        image: AssetImage(
                                            'assets/images/background_image.jpg'),
                                        fit: BoxFit.cover)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 25, bottom: 8, top: 30),
                                      child: CircleAvatar(
                                          backgroundColor: Color(0xFFC9782F),
                                          child: Image(
                                              image: AssetImage(
                                                  'assets/images/ethereum_logo.png'))),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 15, bottom: 1, top: 5),
                                      child: Text('Ethereum',
                                          style: TextStyle(
                                              color: Color(0xFFFAFAFA),
                                              fontSize: 20),
                                          textAlign: TextAlign.start),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 16),
                                      child: IntrinsicHeight(
                                        child: TextField(
                                          controller: ethController,
                                          readOnly: true,
                                          enableInteractiveSelection: false,
                                          keyboardType: TextInputType.text,
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              color: Colors.white70,
                                              fontSize: 15),
                                          maxLines: 1,
                                          decoration: InputDecoration(
                                              border: InputBorder.none,
                                              contentPadding:
                                                  EdgeInsets.only(top: -5)),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          Column(
                                            mainAxisSize: MainAxisSize.max,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(right: 16,bottom: 8),
                                                child: ElevatedButton.icon(
                                                  onPressed: (){
                                                    moreDetails(WalletArguments("Ethereum","ETH","assets/images/ethereum_logo.png"));
                                                  },
                                                  style: ButtonStyle(
                                                      backgroundColor:
                                                      MaterialStateProperty.all(Color(0xFFFAFAFA)),
                                                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0),side: BorderSide(color: Color(0xFFFAFAFA))))),
                                                  label: Text('Open',style: TextStyle(color:Color(0xFFC9782F)),),
                                                  icon: Icon(Icons.open_in_full_rounded, color: Color(0xFFC9782F)),
                                                ),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Container(
                                width: 200.0,
                                decoration: BoxDecoration(
                                    color: Color(0xFFC9782F),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                    image: DecorationImage(
                                        opacity: 0.1,
                                        image: AssetImage(
                                            'assets/images/background_image.jpg'),
                                        fit: BoxFit.cover)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 25, bottom: 8, top: 30),
                                      child: CircleAvatar(
                                          backgroundColor: Color(0xFFC9782F),
                                          child: Image(
                                              image: AssetImage(
                                                  'assets/images/usdt_logo.png'))),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 15, bottom: 1, top: 5),
                                      child: Text('Tether',
                                          style: TextStyle(
                                              color: Color(0xFFFAFAFA),
                                              fontSize: 20),
                                          textAlign: TextAlign.start),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 16),
                                      child: IntrinsicHeight(
                                        child: TextField(
                                          controller: usdtController,
                                          readOnly: true,
                                          enableInteractiveSelection: false,
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              color: Colors.white70,
                                              fontSize: 15),
                                          maxLines: 1,
                                          decoration: InputDecoration(
                                              border: InputBorder.none,
                                              contentPadding:
                                                  EdgeInsets.only(top: -5)),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          Column(
                                            mainAxisSize: MainAxisSize.max,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(right: 16,bottom: 8),
                                                child: ElevatedButton.icon(
                                                  onPressed: (){
                                                    moreDetails(WalletArguments("Tether","USDT","assets/images/usdt_logo.png"));
                                                  },
                                                  style: ButtonStyle(
                                                      backgroundColor: MaterialStateProperty.all(Color(0xFFFAFAFA)),
                                                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0),side: BorderSide(color: Color(0xFFFAFAFA))))),
                                                  label: Text('Open',style: TextStyle(color:Color(0xFFC9782F)),),
                                                  icon: Icon(Icons.open_in_full_rounded, color: Color(0xFFC9782F)),
                                                ),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      )),
                  Expanded(
                      flex: 4,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 30),
                                child: Material(
                                    color: Colors.transparent,
                                    shape: CircleBorder(),
                                    clipBehavior: Clip.hardEdge,
                                    child: IconButton(
                                        icon: new Icon(Icons.book_rounded),
                                        onPressed: learn,
                                        color: Colors.blueGrey)),
                              ),
                              Container(
                                height: 90,
                                width: 90,
                                child: FloatingActionButton(
                                  child: Icon(
                                    Icons.show_chart,
                                    color: Color(0xFFFAFAFA),
                                  ),
                                  backgroundColor: Color(0xFFC9782F),
                                  onPressed: investment,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 30),
                                child: Material(
                                    color: Colors.transparent,
                                    shape: CircleBorder(),
                                    clipBehavior: Clip.hardEdge,
                                    child: IconButton(
                                        icon: new Icon(Icons.card_giftcard_rounded),
                                        onPressed: exchange,
                                        color: Colors.blueGrey)),
                              )
                            ],
                          ),
                        ),
                      ))
                ],
              ),
            )
          ],
        ),
      ),
    );

    TabBarView tabBarView = TabBarView(
        children: [
          Expanded(
            child: container,
          ),
          Expanded(
            child: AllWalletScreen(),
          ),
        ],
      );

    return LayoutBuilder(
      builder: (_, constraints) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Scaffold(
            key: key,
            appBar: appBar,
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
                      tabBarView.controller?.animateTo(0,duration: Duration());
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
                          tabBarView.controller?.animateTo(1,duration: Duration());
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
            body: DefaultTabController(length: 2,
            child: tabBarView),
          ),
        );
      },
    );
  }
}
