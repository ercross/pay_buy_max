import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pay_buy_max/controllers/providers/coin_price_provider.dart';
import 'package:pay_buy_max/views/widgets/chart_container.dart';
import 'package:provider/provider.dart';

import 'investment_items.dart';

class InvestmentScreen extends StatelessWidget {
  const InvestmentScreen();

  static const String route = "/investmentScreen";

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CoinPriceProvider>(
            create: (context) => CoinPriceProvider()),
      ],
      child: const _InvestmentScreen(),
    );
  }
}

class _InvestmentScreen extends StatefulWidget {
  const _InvestmentScreen();

  @override
  State<StatefulWidget> createState() => _InvestmentState();
}

class _InvestmentState extends State<_InvestmentScreen> {
  late List<InvestmentItems> investItems;

  @override
  void initState() {
    super.initState();
    investItems = new List<InvestmentItems>.from(List.empty());
    investItems.add(InvestmentItems("Bronze Plan", "50.0K - 500.0K", "10 %", "3 Months"));
    investItems.add(InvestmentItems("Silver Plan", "501.0K - 1.0M", "20 %", "6 Months"));
    investItems.add(InvestmentItems("Gold Plan", "1.0M - 5.0M", "30 %", "9 Months"));
    investItems.add(InvestmentItems("Diamond Plan", "5.0M - 50.0M", "50 %", "12 Months"));
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
      title: Text("Investment", style: TextStyle(color: Colors.blueGrey, fontSize: 18), textAlign: TextAlign.start),
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
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: 250,
            decoration: BoxDecoration(
                image: DecorationImage(
                    opacity: 0.2,
                    image: AssetImage(
                        'assets/images/background_image.jpg'),
                    fit: BoxFit.cover)),
            child:  ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, position) {
                return Container(
                  width: 250,
                  height: 250,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        elevation: 6,
                        color: Color(0xFF4B8800),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            side: BorderSide(color: Color(0xFF4B8800))
                        ),
                        child: Container(
                          width: 250,
                          height: 250,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  opacity: 0.15,
                                  image: AssetImage('assets/images/background_image.jpg'),
                                  fit: BoxFit.cover)),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Padding(
                                  padding: const EdgeInsets.only(left: 10,top: 10),
                                  child: Text(investItems.elementAt(position).title,style: TextStyle(color: Color(0xFFFAFAFA), fontSize: 25),textAlign: TextAlign.start),
                                ),
                                  Padding(
                                  padding: const EdgeInsets.only(left: 10,top: 5),
                                  child: Text(investItems.elementAt(position).price,style: TextStyle(color: Colors.white60, fontSize: 15),textAlign: TextAlign.start),
                                ),
                                  Spacer(flex: 1),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10,top: 5),
                                    child: Text(investItems.elementAt(position).commission,style: TextStyle(color: Colors.white60, fontSize: 15),textAlign: TextAlign.start),
                                  ),
                                  Padding(
                                  padding: const EdgeInsets.only(left: 10,top: 5),
                                  child: Text(investItems.elementAt(position).duration,style: TextStyle(color: Colors.white60, fontSize: 15),textAlign: TextAlign.start),
                                ),
                                  Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: ElevatedButton(
                                    onPressed: () {  },
                                    child: Text("Invest Now",style: TextStyle(color: Color(0xFF4B8800))),
                                    style: ButtonStyle(
                                        backgroundColor: MaterialStateProperty.all(Color(0xFFFAFAFA)),
                                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0),side: BorderSide(color: Color(0xFFFAFAFA))))),
                                  ),
                                )
                              ]
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
              itemCount: investItems.length,
            ),
          ),
          Expanded(child: DefaultTabController(
              length: 2,
              child:Scaffold(
                appBar:  TabBar(
                  indicatorColor: Color(0xFF4B8800),
                  labelColor: Color(0xFF4B8800),
                  unselectedLabelColor: Colors.black45,
                  indicatorWeight: 1,
                  tabs: [
                    Tab(text: "My Investments",),
                    Tab(text: "History"),
                  ],
                ),
                body: const TabBarView(
                  children: [
                    Icon(Icons.directions_car),
                    Icon(Icons.directions_transit),
                  ],
                ),
              ),
          )
          )
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