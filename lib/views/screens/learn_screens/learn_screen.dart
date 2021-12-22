import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pay_buy_max/controllers/providers/coin_price_provider.dart';
import 'package:pay_buy_max/generated/assets.dart';
import 'package:provider/provider.dart';

class LearnScreen extends StatelessWidget {
  const LearnScreen();

  static const String route = "/learnScreen";

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CoinPriceProvider>(
            create: (context) => CoinPriceProvider()),
      ],
      child: const _LearnScreen(),
    );
  }
}

class _LearnScreen extends StatefulWidget {
  const _LearnScreen();

  @override
  State<StatefulWidget> createState() => _LearnState();
}

class _LearnState extends State<_LearnScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Color(0xFFF5F5F5),
      body: SafeArea(
        child: Expanded(
          child: ListView(
            scrollDirection: Axis.vertical,
            children: [
              Container(
                height:300,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Card(
                    elevation: 6,
                    color: Color(0xFFFAFAFA),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left:15,right:15,bottom: 15,top: 10),
                          child:  Text('Basic Plan', style: TextStyle(color: Colors.black87, fontSize: 20,fontWeight: FontWeight.bold),textAlign: TextAlign.center),
                        ),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(left:15,right:15,bottom: 2,top: 10),
                          child:  Text('NGN0.00', style: TextStyle(color: Colors.black54, fontSize: 25), textAlign: TextAlign.center),
                        ),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(left:15,right:15,bottom: 10,top: 10),
                          child:  Text('Offers = "Introduction to the Cryptocurrency market, Introduction to Blockchain technology, How to execute p2p trade, "', style: TextStyle(color: Colors.black54, fontSize: 20), textAlign: TextAlign.center),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left:15,right:15,bottom: 10),
                          child: ElevatedButton(onPressed: (){}, child: Text("Learn")),
                        )
                      ],
                    ),
                  )
                ),
              ),
              Container(
                height:400,
                child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Card(
                      elevation: 6,
                      color: Color(0xFFFAFAFA),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left:15,right:15,bottom: 15,top: 10),
                            child:  Text('Standard Plan', style: TextStyle(color: Colors.black87, fontSize: 20,fontWeight: FontWeight.bold),textAlign: TextAlign.center),
                          ),
                          Spacer(),
                          Padding(
                            padding: const EdgeInsets.only(left:15,right:15,bottom: 2,top: 10),
                            child:  Text('NGN180,000.00', style: TextStyle(color: Colors.black54, fontSize: 25), textAlign: TextAlign.center),
                          ),
                          Spacer(),
                          Padding(
                            padding: const EdgeInsets.only(left:15,right:15,bottom: 10,top: 10),
                            child:  Text('Offers = "Basic+, Fundamental Analysis, Technical Analysis, Sentimental Analysis, Risk Management, Candlesticks, Use of indicators, Trading Psychology, Practical trading Session"', style: TextStyle(color: Colors.black54, fontSize: 20), textAlign: TextAlign.center),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left:15,right:15,bottom: 10),
                            child: ElevatedButton(onPressed: (){}, child: Text("Learn")),
                          )
                        ],
                      ),
                    )
                ),
              ),
              Container(
                height:500,
                child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Card(
                      elevation: 6,
                      color: Color(0xFFFAFAFA),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left:15,right:15,bottom: 15,top: 10),
                            child:  Text('Premium Plan', style: TextStyle(color: Colors.black87, fontSize: 20,fontWeight: FontWeight.bold),textAlign: TextAlign.center),
                          ),
                          Spacer(),
                          Padding(
                            padding: const EdgeInsets.only(left:15,right:15,bottom: 2,top: 10),
                            child:  Text('NGN184,500.00', style: TextStyle(color: Colors.black54, fontSize: 25), textAlign: TextAlign.center),
                          ),
                          Spacer(),
                          Padding(
                            padding: const EdgeInsets.only(left:15,right:15,bottom: 10,top: 10),
                            child:  Text('Offers = "Standard+, Staking and farming, Margin and Futures Trading, Dollar-cost Averaging {DCA}, Decentralized finance {DEFI}, non-fungible token {NFT}, Initial dex offerings {IDO}, 1month Free access to our VIP signal room, Offline training opportunity, Free Certification, 100% cash refund to the best student + employment opportunity @ PAYBUYMAX"', style: TextStyle(color: Colors.black54, fontSize: 20), textAlign: TextAlign.center),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left:15,right:15,bottom: 10),
                            child: ElevatedButton(onPressed: (){}, child: Text("Learn")),
                          )
                        ],
                      ),
                    )
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}