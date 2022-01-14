import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pay_buy_max/controllers/providers/coin_price_provider.dart';
import 'package:pay_buy_max/models/invest/investment_list_entity.dart';
import 'package:pay_buy_max/views/widgets/chart_container.dart';
import '../../../style_sheet.dart';
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
  late List<InvestmentListPackages> investItems;

  @override
  void initState() {
    super.initState();
    investItems = new List<InvestmentListPackages>.from(List.empty());
  }

  @override
  Widget build(BuildContext context) {

    final double height = MediaQuery.of(context).size.height - (MediaQuery.of(context).padding.top);

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
            color: StyleSheet.primaryColor.withOpacity(0.09),
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
                                  child: Text(investItems.elementAt(position).name!,style: TextStyle(color: Color(0xFFFAFAFA), fontSize: 25),textAlign: TextAlign.start),
                                ),
                                  Padding(
                                  padding: const EdgeInsets.only(left: 10,top: 5),
                                  child: Text(investItems.elementAt(position).fromPrice.toString()+"-"+investItems.elementAt(position).toPrice.toString(),style: TextStyle(color: Colors.white60, fontSize: 15),textAlign: TextAlign.start),
                                ),
                                  Spacer(flex: 1),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10,top: 5),
                                    child: Text(investItems.elementAt(position).commission.toString()+" %",style: TextStyle(color: Colors.white60, fontSize: 15),textAlign: TextAlign.start),
                                  ),
                                  Padding(
                                  padding: const EdgeInsets.only(left: 10,top: 5),
                                  child: Text(investItems.elementAt(position).duration.toString()+" Months",style: TextStyle(color: Colors.white60, fontSize: 15),textAlign: TextAlign.start),
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
                backgroundColor: StyleSheet.primaryColor.withOpacity(0.09),
                body: TabBarView(
                  children: [
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
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left: 30, bottom: 5,top: 15),
                                        child: Text('Bronze Plan', style: TextStyle(color: Color(0xFF4B8800), fontSize: 18), textAlign: TextAlign.start),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 30, bottom: 15),
                                        child: Text('50.0k - 500.0k', style: TextStyle(fontSize: 15), textAlign: TextAlign.start),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 30,top: 15,bottom: 15),
                                    child: Wrap(
                                      alignment: WrapAlignment.end,
                                      children: [
                                        Text('NGN 50000', style: TextStyle(color: Colors.black, fontSize: 18), textAlign: TextAlign.start),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 30,top: 10),
                                          child: Text('27 November 2022', style: TextStyle(fontSize: 15), textAlign: TextAlign.start),
                                        ),
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
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left: 30, bottom: 5,top: 15),
                                        child: Text('Bronze Plan', style: TextStyle(color: Color(0xFF4B8800), fontSize: 18), textAlign: TextAlign.start),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 30, bottom: 15),
                                        child: Text('50.0k - 500.0k', style: TextStyle(fontSize: 15), textAlign: TextAlign.start),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 30,top: 15,bottom: 15),
                                    child: Wrap(
                                      alignment: WrapAlignment.end,
                                      children: [
                                        Text('NGN 50000', style: TextStyle(color: Colors.black, fontSize: 18), textAlign: TextAlign.start),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 30,top: 10),
                                          child: Text('27 November 2022', style: TextStyle(fontSize: 15), textAlign: TextAlign.start),
                                        ),
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
                    ),
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
            body: container,
          ),
        );
      },
    );
  }

}