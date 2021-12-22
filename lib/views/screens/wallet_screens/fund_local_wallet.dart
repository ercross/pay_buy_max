
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pay_buy_max/controllers/providers/coin_price_provider.dart';
import 'package:provider/provider.dart';

class FundLocalWallet extends StatelessWidget {
  const FundLocalWallet();

  static const String route = "/fundLocalWallet";

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CoinPriceProvider>(
            create: (context) => CoinPriceProvider()),
      ],
      child: const FundLocalWalletWidget(),
    );
  }

}

class FundLocalWalletWidget extends StatefulWidget {
  const FundLocalWalletWidget();

  @override
  _FundLocalWalletWidgetState createState() => _FundLocalWalletWidgetState();
}

class _FundLocalWalletWidgetState extends State<FundLocalWalletWidget> {
  late TextEditingController textController;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  String value = "Bitcoin";

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
              Container(
                height:250,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    elevation: 6,
                    color: Color(0xFFFAFAFA),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left:15,right:15,bottom: 15,top: 10),
                          child:  Text('Fund Your Naira Wallet', style: TextStyle(color: Colors.black54, fontSize: 20,fontWeight: FontWeight.bold), textAlign: TextAlign.start),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left:15,right:15,bottom: 2,top: 10),
                          child:  Text('Amount In Naira', style: TextStyle(color: Colors.black54, fontSize: 14), textAlign: TextAlign.start),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15,right: 15),
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
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(left:15,right:15,bottom: 10),
                          child: ElevatedButton(onPressed: (){}, child: Text("FUND NAIRA WALLET"),style: ElevatedButton.styleFrom(primary:Colors.black)),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                height:300,
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
                          child:  Text('Fund Your Crypto Wallet', style: TextStyle(color: Colors.black54, fontSize: 20,fontWeight: FontWeight.bold), textAlign: TextAlign.start),
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
                          child:  Text('Amount', style: TextStyle(color: Colors.black54, fontSize: 14), textAlign: TextAlign.start),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15,right: 15),
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
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(left:15,right:15,bottom: 10),
                          child: ElevatedButton(onPressed: (){}, child: Text("FUND CRYPTO WALLET"),style: ElevatedButton.styleFrom(primary:Colors.black)),
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