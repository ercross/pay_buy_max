
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pay_buy_max/controllers/providers/coin_price_provider.dart';
import 'package:provider/provider.dart';

class SellCoin extends StatelessWidget {
  const SellCoin();

  static const String route = "/sellCoin";

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CoinPriceProvider>(
            create: (context) => CoinPriceProvider()),
      ],
      child: const SellCoinWidget(),
    );
  }

}

class SellCoinWidget extends StatefulWidget {
  const SellCoinWidget();

  @override
  _SellCoinWidgetState createState() => _SellCoinWidgetState();
}

class _SellCoinWidgetState extends State<SellCoinWidget> {
  late TextEditingController textController;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  String value = "Bitcoin";
  String value2 = "Amount In Dollar";

  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  color: Color(0xFFF5F5F5),
                  elevation: 6,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Align(
                        alignment: AlignmentDirectional(-1, 0),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                          child: Container(
                            width: 110,
                            height: 110,
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: Image(image: AssetImage("assets/images/bitcoin_logo.png")),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Align(
                          alignment: AlignmentDirectional(0, 0),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 10, 0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(
                                  'BTC 0.0125',
                                  textAlign: TextAlign.end,
                                ),
                                Text(
                                    'NGN 50,000',
                                    textAlign: TextAlign.end,
                                    style: TextStyle( fontSize: 20)
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  color: Color(0xFFF5F5F5),
                  elevation: 6,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Align(
                        alignment: AlignmentDirectional(-1, 0),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                          child: Container(
                            width: 110,
                            height: 110,
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: Image(image: AssetImage("assets/images/ethereum_logo.png")),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Align(
                          alignment: AlignmentDirectional(0, 0),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 10, 0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(
                                  'ETH 0.0125',
                                  textAlign: TextAlign.end,
                                ),
                                Text(
                                    'NGN 50,000',
                                    textAlign: TextAlign.end,
                                    style: TextStyle( fontSize: 30)
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  color: Color(0xFFF5F5F5),
                  elevation: 6,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Align(
                        alignment: AlignmentDirectional(-1, 0),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                          child: Container(
                            width: 110,
                            height: 110,
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: Image(image: AssetImage("assets/images/usdt_logo.png")),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Align(
                          alignment: AlignmentDirectional(0, 0),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 10, 0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(
                                  'USDT 0.0125',
                                  textAlign: TextAlign.end,
                                ),
                                Text(
                                    'NGN 50,000',
                                    textAlign: TextAlign.end,
                                    style: TextStyle( fontSize: 30)
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height:450,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
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
                          child:  Text('Sell From Wallet', style: TextStyle(color: Colors.black54, fontSize: 20,fontWeight: FontWeight.bold), textAlign: TextAlign.start),
                        ),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(left:15,right:15,bottom: 2,top: 10),
                          child:  Text('Choose Coin Type', style: TextStyle(color: Colors.black54, fontSize: 14), textAlign: TextAlign.start),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left:15,right:15),
                            child: DropdownButton(
                                value: value,
                                isExpanded: true, items: ["Bitcoin","Ethereum"].map((String value) {
                              return DropdownMenuItem(value: value,child: Text(value));
                            }).toList(), onChanged: (_value){
                              setState(() {
                                value = _value as String;
                              });
                            }),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left:15,right:15,bottom: 2,top: 10),
                          child:  Text('Medium', style: TextStyle(color: Colors.black54, fontSize: 14), textAlign: TextAlign.start),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left:15,right:15),
                            child: DropdownButton(
                                value: value2,
                                isExpanded: true, items: ["Amount In Dollar","Amount In Naira","Amount In Quantity"].map((String value) {
                              return DropdownMenuItem(value: value,child: Text(value));
                            }).toList(), onChanged: (_value){
                              setState(() {
                                value2 = _value as String;
                              });
                            }),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left:15,right:15,bottom: 2,top: 10),
                          child:  Text('Amount', style: TextStyle(color: Colors.black54, fontSize: 14), textAlign: TextAlign.start),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15,right: 15,bottom: 15),
                            child: TextFormField(
                              controller: textController,
                              obscureText: false,
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0x00000000),
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0x00000000),
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                filled: true,
                                contentPadding:
                                EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left:15,right:15,bottom: 10),
                          child: ElevatedButton(onPressed: (){}, child: Text("SELL COIN"),style: ElevatedButton.styleFrom(primary:Colors.black)),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
