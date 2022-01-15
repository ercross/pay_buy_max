import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fragment_navigate/navigate-control.dart';
import 'package:fragment_navigate/navigate-support.dart';
import 'package:pay_buy_max/controllers/providers/user_provider.dart';
import 'package:pay_buy_max/models/auth/sign_in_response_entity.dart';
import 'package:pay_buy_max/models/transfer/bank_list_entity.dart';
import 'package:pay_buy_max/views/screens/exchange_screens/exchange_screen.dart';
import 'package:pay_buy_max/views/screens/learn_screens/learn_screen.dart';
import 'package:pay_buy_max/views/screens/settings_screens/setting_screen.dart';
import 'package:pay_buy_max/views/screens/wallet_screens/all_wallet_balance.dart';
import 'package:pay_buy_max/views/screens/wallet_screens/fund_local_wallet.dart';
import 'package:pay_buy_max/views/screens/wallet_screens/local_wallet_screen.dart';
import 'package:pay_buy_max/views/screens/wallet_screens/wallet_arguments.dart';
import 'package:pay_buy_max/views/screens/wallet_screens/wallet_screen.dart';
import 'package:pay_buy_max/models/wallet/wallet_balance_entity.dart';
import 'package:pay_buy_max/views/screens/withdraw/withdraw.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../../../style_sheet.dart';
import 'authentication_screens/sign_up_screen.dart';
import 'exchange_screens/sell_coin.dart';
import 'history/history.dart';
import 'investment_screens/investment_screen.dart';
import 'notification_screens/notification_screen.dart';

class HomePage extends StatelessWidget {
  const HomePage();

  static const String route = "/home";

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UserProvider>(
            create: (context) => UserProvider()),
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
  late FragNavigate _fragNav;
  final color = const Color(0xFFC9782F);

  @override
  Widget build(BuildContext context) {
    _fragNav = FragNavigate(
        firstKey: ValueKey(HomePage.route),
        screens: <Posit>[
          Posit(
              title: "Home",
              key: ValueKey(HomePage.route),
              fragment: _HomeContainer()
          ),
          Posit(
            title: "Wallet",
            key: ValueKey(AllWalletScreen.route),
            fragment: AllWalletScreen(),
          ),
          Posit(
            title: "Gift Cards",
            key: ValueKey(ExchangeScreen.route),
            fragment: ExchangeScreen(),
          ),
          Posit(
            title: "Investment",
            key: ValueKey(InvestmentScreen.route),
            fragment: InvestmentScreen(),
          ),
          Posit(
            title: "Fund Wallet",
            key: ValueKey(FundLocalWallet.route),
            fragment: FundLocalWallet(),
          ),
          Posit(
            title: "Trade Crypto",
            key: ValueKey(SellCoin.route),
            fragment: SellCoin(),
          ),
          Posit(
            title: "Learn",
            key: ValueKey(LearnScreen.route),
            fragment: LearnScreen(),
          ),
          Posit(
            title: "Settings",
            key: ValueKey(SettingScreen.route),
            fragment: SettingScreen(),
          ),
          Posit(
            title: "History",
            key: ValueKey("History"),
            fragment: History(),
          ),
          Posit(
            title: "History",
            key: ValueKey("Sell History"),
            fragment: History(),
          ),
          Posit(
            title: "History",
            key: ValueKey("Buy History"),
            fragment: History(),
          ),
        ]
    );
    _fragNav.setDrawerContext = context;

    return StreamBuilder<FullPosit>(
        stream: _fragNav.outStreamFragment,
        builder: (con, s) {
          if (s.data != null) {
            return DefaultTabController(
                length: s.data!.bottom!.length,
                child: Scaffold(
                  key: _fragNav.drawerKey,
                  appBar: AppBar(
                    systemOverlayStyle: SystemUiOverlayStyle(
                        statusBarColor: Colors.transparent,
                        statusBarIconBrightness: Brightness.dark,
                        systemNavigationBarColor: StyleSheet.primaryColor
                            .withOpacity(0.09)),
                    centerTitle: true,
                    backgroundColor: Color(0xFFC9782F),
                    elevation: 0,
                    title: Text((s.data!.title).toString()),
                    bottom: s.data!.bottom!.child,
                    actions: [
                      IconButton(
                          icon: new Icon(Icons.notifications_rounded),
                          onPressed: () {
                            Navigator.of(context).pushNamed(
                                NotificationScreen.route);
                          },
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
                          child: Center(child: Text('', style: TextStyle(
                              color: Color(0xFFFAFAFA), fontSize: 20))),
                        ),
                        ListTile(
                          iconColor: Color(0xFFFAFAFA),
                          textColor: Color(0xFFFAFAFA),
                          tileColor: Color(0xFFC9782F),
                          leading: Icon(Icons.dashboard_rounded),
                          title: const Text('Dashboard'),
                          onTap: () {
                            //DefaultTabController.of(context)!.animateTo(0);
                            _fragNav.putPosit(key: ValueKey(HomePage.route),
                                closeDrawer: true);
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
                              ListTile(leading: Icon(Icons
                                  .arrow_forward_ios_rounded),
                                  title: const Text('Fund Wallets',
                                      style: TextStyle(
                                          color: Color(0xFFFAFAFA))),
                                  onTap: () {
                                    _fragNav.putPosit(
                                        key: ValueKey(FundLocalWallet.route),
                                        closeDrawer: true);
                                  }),
                              ListTile(leading: Icon(Icons
                                  .arrow_forward_ios_rounded),
                                  title: const Text('History', style: TextStyle(
                                      color: Color(0xFFFAFAFA))),
                                  onTap: () {
                                    _fragNav.putPosit(
                                        key: ValueKey("History"),
                                        closeDrawer: true);
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
                              ListTile(leading: Icon(Icons
                                  .arrow_forward_ios_rounded),
                                  title: const Text('Trade Crypto',
                                      style: TextStyle(
                                          color: Color(0xFFFAFAFA))),
                                  onTap: () {
                                    _fragNav.putPosit(
                                        key: ValueKey(SellCoin.route),
                                        closeDrawer: true);
                                  }),
                              ListTile(leading: Icon(Icons
                                  .arrow_forward_ios_rounded),
                                  title: const Text('Gift Cards',
                                      style: TextStyle(
                                          color: Color(0xFFFAFAFA))),
                                  onTap: () {
                                    _fragNav.putPosit(
                                        key: ValueKey(ExchangeScreen.route),
                                        closeDrawer: true);
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
                            leading: Icon(Icons.history_rounded),
                            title: const Text('My Transactions'),
                            children: [
                              ListTile(leading: Icon(Icons
                                  .arrow_forward_ios_rounded),
                                  title: const Text('Sell', style: TextStyle(
                                      color: Color(0xFFFAFAFA))),
                                  onTap: () {
                                    _fragNav.putPosit(
                                        key: ValueKey("Sell History"),
                                        closeDrawer: true);
                                  }),
                              ListTile(leading: Icon(Icons
                                  .arrow_forward_ios_rounded),
                                  title: const Text('Buy', style: TextStyle(
                                      color: Color(0xFFFAFAFA))),
                                  onTap: () {
                                    _fragNav.putPosit(
                                        key: ValueKey("Buy History"),
                                        closeDrawer: true);
                                  }),
                            ]
                        ),
                        ListTile(
                            iconColor: Color(0xFFFAFAFA),
                            textColor: Color(0xFFFAFAFA),
                            tileColor: Color(0xFFC9782F),
                            leading: Icon(Icons.show_chart),
                            title: const Text('My Investments',
                                style: TextStyle(
                                    color: Color(0xFFFAFAFA))),
                            onTap: () {
                              _fragNav.putPosit(
                                  key: ValueKey(InvestmentScreen.route),
                                  closeDrawer: true);
                            }),
                        ListTile(
                            iconColor: Color(0xFFFAFAFA),
                            textColor: Color(0xFFFAFAFA),
                            tileColor: Color(0xFFC9782F),
                            leading: Icon(Icons.book_rounded),
                            title: const Text('Courses', style: TextStyle(
                                color: Color(0xFFFAFAFA))),
                            onTap: () {
                              _fragNav.putPosit(
                                  key: ValueKey(LearnScreen.route),
                                  closeDrawer: true);
                            }),
                        /* ListTile(
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
                        ),*/
                        ListTile(
                          iconColor: Color(0xFFFAFAFA),
                          textColor: Color(0xFFFAFAFA),
                          tileColor: Color(0xFFC9782F),
                          leading: Icon(Icons.settings_rounded),
                          title: const Text('Settings'),
                          onTap: () {
                            _fragNav.putPosit(key: ValueKey(
                                SettingScreen.route), closeDrawer: true);
                          },
                        ),
                        ListTile(
                          iconColor: Color(0xFFFAFAFA),
                          textColor: Color(0xFFFAFAFA),
                          tileColor: Color(0xFFC9782F),
                          leading: Icon(Icons.logout_rounded),
                          title: const Text('Log Out'),
                          onTap: () {
                            Navigator.of(context).pushReplacementNamed(
                                SignUpPage.route);
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

class _HomeContainer extends StatefulWidget {
  const _HomeContainer();

  @override
  State<StatefulWidget> createState() => _HomeStateContainer();
}

class _HomeStateContainer extends State<_HomeContainer> {
  final color = const Color(0xFFC9782F);
  WalletBalanceEntity? walletBalanceEntity;
  late SignInResponseEntity args;
  late BankListEntity bankListEntity;
  bool isDollar = true;
  bool showBalance = true;
  String currency = "NGN";
  late TextEditingController _amtFieldController;
  late TextEditingController _accFieldController;
  late TextEditingController _otpFieldController;
  late TextEditingController _nameFieldController;

  @override
  void initState() {
    super.initState();
    _amtFieldController = TextEditingController();
    _accFieldController = TextEditingController();
    _otpFieldController = TextEditingController();
    _nameFieldController = TextEditingController();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _getWalletInfo();
      getBankList().then((value) => {
        bankListEntity = value
      });
    });
  }

  void _getWalletInfo() {
    // final response = await getWalletInfo();
    getWalletInfo().then((value) {
      setState(() {
        if (value.status == true) {
          walletBalanceEntity = value;
        } else {
          walletBalanceEntity = null;
          /*if(response.message == null){
        AppOverlay.snackbar(message: "An Error Occurred!. Please Try Again");
      }else{
        if(response.message!.isEmpty){
          AppOverlay.snackbar(message: "An Error Occurred!. Please Try Again");
        }else{
          AppOverlay.snackbar(message: response.message.toString());
        }
      }*/
        }
      });
    });
  }

  Future<WalletBalanceEntity> getWalletInfo() async {
    String url = 'https://paybuymax.com/api/user';
    final response = await http.get(
        Uri.parse(url), headers: {"Authorization": args.token.toString()});
    return WalletBalanceEntity().fromJson(json.decode(response.body));
  }

  Future<BankListEntity> getBankList() async {
    String url = 'https://paybuymax.com/api/banklist';
    final response = await http.get(Uri.parse(url), headers: {"Authorization": args.token.toString()});
    return BankListEntity().fromJson(json.decode(response.body));
  }

  Future<BankListEntity> getBankName(String accountNo,String bankCode) async {
    try{
      String url = 'https://paybuymax.com/api/verifyAccount';
      var body = {"account":accountNo,"bank_code":bankCode};
      final response = await http.post(Uri.parse(url), headers: {"Authorization": args.token.toString()},body: body);
      return BankListEntity().fromJson(json.decode(response.body));
    }catch(e){
      var error = BankListEntity();
      error.status = false;
      return error;
    }
  }

  Future<BankListEntity> withdrawNaira(String accountNo,String accountName,String bankCode,String bankName,String amount,String otpCode) async {
    try {
      String url = 'https://paybuymax.com/api/userwithdraw';
      var body = {"account":accountNo,"bank_code":bankCode,"acct_name":accountName,"bank_name":bankName,"amount":amount,"code":otpCode};
      final response = await http.post(Uri.parse(url), headers: {"Authorization": args.token.toString()},body: body);
      return BankListEntity().fromJson(json.decode(response.body));
    } catch(e){
      var error = BankListEntity();
      error.status = false;
      return error;
    }
  }

  Future<BankListEntity> withdrawCoin(String coinType,String walletAddress,String amount,String otpCode) async {
    try {
      String url = 'https://paybuymax.com/api/userwithdraw';
      var body = {"amount":amount,"coinType":coinType,"wallet_address":walletAddress,"code":otpCode};
      final response = await http.post(Uri.parse(url), headers: {"Authorization": args.token.toString()},body: body);
      return BankListEntity().fromJson(json.decode(response.body));
    } catch(e){
      var error = BankListEntity();
      error.status = false;
      return error;
    }
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
    Navigator.of(context).pushNamed(
        WalletScreen.route, arguments: walletArguments);
  }

  void moreLocalDetails() {
    Navigator.of(context).pushNamed(LocalWalletScreen.route);
  }

  Future<void> showTransferDialog(BuildContext context1) async {
    String value1 = "";
    var banks = List<String>.from(List.empty());
    var bankMap = {"":""};

    for(int i = 0;i< bankListEntity.data!.length;i++){
      banks.add(bankListEntity.data!.elementAt(i).name.toString());
      bankMap.putIfAbsent(bankListEntity.data!.elementAt(i).name.toString(), () => bankListEntity.data!.elementAt(i).code.toString());
    }

    value1 = banks.elementAt(0);

    return showDialog(
        barrierDismissible: false,
        context: context1,
        builder: (context) {
          return AlertDialog(
            title: Text('Withdraw From Naira Wallet', style: TextStyle(color: Color(0xFFC9782F)), textAlign: TextAlign.start),
            content: StatefulBuilder(
              builder: (BuildContext context,StateSetter setState){
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child:  Text('Amount To Send', style: TextStyle(color: Color(0xFF000000), fontSize: 14,fontWeight: FontWeight.bold), textAlign: TextAlign.start),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 1),
                      child: TextField(
                        controller: _amtFieldController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFFC9782F),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(5),
                            ),hintText: "Enter Amount",border: OutlineInputBorder(),contentPadding: EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child:  Text('Bank Name', style: TextStyle(color: Color(0xFF000000), fontSize: 14,fontWeight: FontWeight.bold), textAlign: TextAlign.start),
                    ),
                    Container(
                      height: 50,
                      child: InputDecorator(
                        decoration: InputDecoration(focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFFC9782F),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(5),
                        ),border: OutlineInputBorder(),contentPadding: EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8)),
                        child: DropdownButton(
                            value: value1,
                            underline: SizedBox.shrink(),
                            isExpanded: true, items: banks.map((String value) {
                          return DropdownMenuItem(value: value,child: Text(value));
                        }).toList(), onChanged: (_value){
                          setState(() {
                            value1 = _value as String;
                          });
                        }),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child:  Text('Account Number', style: TextStyle(color: Color(0xFF000000), fontSize: 14,fontWeight: FontWeight.bold), textAlign: TextAlign.start),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 1),
                      child: TextField(
                        controller: _accFieldController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFFC9782F),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            hintText: "Enter Account Number",border: OutlineInputBorder(),contentPadding: EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child:  Text('Account Name', style: TextStyle(color: Color(0xFF000000), fontSize: 14,fontWeight: FontWeight.bold), textAlign: TextAlign.start),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 1),
                      child: TextFormField(
                        controller: _nameFieldController,
                        obscureText: false,
                        readOnly: true,
                        decoration: InputDecoration(
                          hintText: "Account Name",
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0x00000000),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFFC9782F),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          filled: true,
                          contentPadding: EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child:  Text('OTP Code', style: TextStyle(color: Color(0xFF000000), fontSize: 14,fontWeight: FontWeight.bold), textAlign: TextAlign.start),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 1),
                      child: TextField(
                        controller: _otpFieldController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFFC9782F),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            hintText: "Enter OTP Code",
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8)),
                      ),
                    )
                  ],
                );
              },
            ),
            actions: <Widget>[
              FlatButton(
                color: Colors.black,
                textColor: Colors.white,
                child: Text('CANCEL'),
                onPressed: () {
                  setState(() {
                    _amtFieldController.text = "";
                    _accFieldController.text = "";
                    _otpFieldController.text = "";
                    _nameFieldController.text = "";
                    Navigator.pop(context);
                  });
                },
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: FlatButton(
                  color: Color(0xFFC9782F),
                  textColor: Colors.white,
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.pop(context1);
                    _amtFieldController.text = "";
                    _accFieldController.text = "";
                    _otpFieldController.text = "";
                    _nameFieldController.text = "";
                  },
                ),
              ),
            ],
          );
        });
  }

  Future<void> showCryptoTransferDialog(String type){
    var coins = walletBalanceEntity!.user!.userCoins!;
    String value1 = "";
    var coinList = List<String>.from(List.empty());
    var coinMap = {"":""};

    for(int i = 0;i< coins.length;i++){
      coinList.add(coins.elementAt(i).coinTypes!.name!);
      coinMap.putIfAbsent(coins.elementAt(i).coinTypes!.name!, () => coins.elementAt(i).coinId!);
    }

    value1 = type;

    return null;
  }

  void showWalletDialog(BuildContext context){
    AlertDialog alertDialog = AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                showTransferDialog(context);
              },
              child: Text("Withdraw From Naira Wallet",style: TextStyle(color: Color(0xFFFAFAFA))),
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Color(0xFFC9782F)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0),side: BorderSide(color: Color(0xFFC9782F))))),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {

              },
              child: Text("Withdraw From Bitcoin Wallet",style: TextStyle(color: Color(0xFFFAFAFA))),
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Color(0xFFC9782F)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0),side: BorderSide(color: Color(0xFFC9782F))))),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {

              },
              child: Text("Withdraw From Ethereum Wallet",style: TextStyle(color: Color(0xFFFAFAFA))),
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Color(0xFFC9782F)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0),side: BorderSide(color: Color(0xFFC9782F))))),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {

              },
              child: Text("Withdraw From Tether Wallet",style: TextStyle(color: Color(0xFFFAFAFA))),
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Color(0xFFC9782F)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0),side: BorderSide(color: Color(0xFFC9782F))))),
            ),
          )
        ],
      ),
    );

    showDialog(barrierDismissible: true, context:context, builder: (BuildContext context){
      return alertDialog;
    });
  }

  void showLoadingDialog(BuildContext context){
    AlertDialog alertDialog = AlertDialog(
      content: Row(
        children: [
          CircularProgressIndicator(),
          Container(
            margin: EdgeInsets.only(left: 10),
            child: Text("Signing you in. Please wait"),
          )
        ],
      ),
    );

    showDialog(barrierDismissible: false, context:context, builder: (BuildContext context){
      return alertDialog;
    });
  }

  final GlobalKey<ScaffoldState> key = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    args = ModalRoute
        .of(context)!
        .settings
        .arguments as SignInResponseEntity;

    AppBar appBar = AppBar(
      systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
          systemNavigationBarColor: Color(0xFFFAFAFA)),
      centerTitle: true,
      backgroundColor: Color(0xFFC9782F),
      elevation: 0,
      title: Center(
          child: Text('PayBuyMax',
              style: TextStyle(color: Color(0xFFFAFAFA), fontSize: 18),
              textAlign: TextAlign.center)),
      leading: IconButton(
          icon: new Icon(Icons.menu), onPressed: () {
        key.currentState?.openDrawer();
      }, color: Color(0xFFFAFAFA)),
      actions: [
        IconButton(
            icon: new Icon(Icons.notifications_rounded),
            onPressed: () {
              Navigator.of(context).pushNamed(NotificationScreen.route);
            },
            color: Color(0xFFFAFAFA))
      ],
    );

    final double height = MediaQuery
        .of(context)
        .size
        .height - (appBar.preferredSize.height + MediaQuery
        .of(context)
        .padding
        .top);

    Container newContainer = new Container(
      height: height,
      color: StyleSheet.primaryColor.withOpacity(0.09),
      width: MediaQuery
          .of(context)
          .size
          .width,
      child: Flex(
        direction: Axis.vertical,
        children: [
          Expanded(
            child: ListView(
              scrollDirection: Axis.vertical,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 26, top: 10),
                  child: Text("Welcome,", style: TextStyle(color: Color(0xFFC9782F), fontSize: 18)),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 26),
                  child: Builder(
                    builder: (context) {
                      if (args.user!.name != null && args.user!.name.toString().isNotEmpty) {
                        return Text(args.user!.name.toString(),
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 22,
                                fontWeight: FontWeight.bold));
                      }
                      else if (args.user!.email != null && args.user!.email.toString().isNotEmpty) {
                        return Text(args.user!.email.toString(),
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 22,
                                fontWeight: FontWeight.bold));
                      }
                      return Text("", style: TextStyle(color: Colors.black,
                          fontSize: 22,
                          fontWeight: FontWeight.bold));
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 20, left: 25, right: 25, bottom: 10),
                  child: Container(
                      height: 250,
                      child: Card(
                        color: Color(0xFFFAFAFA),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            side: BorderSide(color: Color(0xFFC9782F))),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 15, right: 15),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Text('PayBuyMax', style: TextStyle(
                                        color: Colors.black54, fontSize: 18),
                                        textAlign: TextAlign.start),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Wrap(
                                      alignment: WrapAlignment.end,
                                      children: [
                                        IconButton(
                                            icon: new Icon(
                                                Icons.remove_red_eye_outlined),
                                            onPressed: () {
                                              setState(() {
                                                showBalance = !showBalance;
                                              });
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
                                    child: Builder(
                                        builder: (context) {
                                          if (!showBalance) {
                                            return Text("*****",
                                                style: TextStyle(
                                                    color: Color(0xFFC9782F),
                                                    fontSize: 40,
                                                    fontWeight: FontWeight
                                                        .bold),
                                                textAlign: TextAlign.center);
                                          }
                                          return Text("NGN " +
                                              args.user!.wallet.toString(),
                                              style: TextStyle(
                                                  color: Color(0xFFC9782F),
                                                  fontSize: 40,
                                                  fontWeight: FontWeight.bold),
                                              textAlign: TextAlign.center);
                                        }
                                    )
                                )
                              ],
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Expanded(
                                  child: Text('Balance', style: TextStyle(
                                      color: Colors.black54, fontSize: 16),
                                      textAlign: TextAlign.center),
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
                                              height: 100,
                                              width: 100,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 10,
                                                    bottom: 10,
                                                    right: 15,
                                                    left: 15),
                                                child: Card(
                                                  elevation: 3,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius
                                                          .all(
                                                          Radius.circular(10))),
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment
                                                        .center,
                                                    crossAxisAlignment: CrossAxisAlignment
                                                        .stretch,
                                                    mainAxisSize: MainAxisSize
                                                        .max,
                                                    children: [
                                                      IconButton(
                                                        icon: new Icon(
                                                            Icons.send_rounded),
                                                        onPressed: () {
                                                          showWalletDialog(context);
                                                        },
                                                      ),
                                                      Text('Withdraw',
                                                          style: TextStyle(
                                                              fontSize: 14),
                                                          textAlign: TextAlign
                                                              .center)
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              height: 100,
                                              width: 100,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 10,
                                                    bottom: 10,
                                                    right: 15,
                                                    left: 15),
                                                child: Card(
                                                  elevation: 3,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius
                                                          .all(
                                                          Radius.circular(10))),
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment
                                                        .center,
                                                    crossAxisAlignment: CrossAxisAlignment
                                                        .stretch,
                                                    mainAxisSize: MainAxisSize
                                                        .max,
                                                    children: [
                                                      IconButton(
                                                        icon: new Icon(Icons
                                                            .call_received_rounded),
                                                        onPressed: () {

                                                        },
                                                      ),
                                                      Text('Receive',
                                                          style: TextStyle(
                                                              fontSize: 14),
                                                          textAlign: TextAlign
                                                              .center)
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              height: 100,
                                              width: 100,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 10,
                                                    bottom: 10,
                                                    right: 15,
                                                    left: 15),
                                                child: Card(
                                                  elevation: 3,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius
                                                          .all(
                                                          Radius.circular(10))),
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment
                                                        .center,
                                                    crossAxisAlignment: CrossAxisAlignment
                                                        .stretch,
                                                    mainAxisSize: MainAxisSize
                                                        .max,
                                                    children: [
                                                      IconButton(
                                                        icon: new Icon(
                                                            Icons
                                                                .shopping_cart),
                                                        onPressed: () {

                                                        },
                                                      ),
                                                      Text('Buy',
                                                          style: TextStyle(
                                                              fontSize: 14),
                                                          textAlign: TextAlign
                                                              .center)
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
                  padding: const EdgeInsets.only(top: 15, right: 25, left: 25),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Text('Coins', style: TextStyle(color: Colors
                            .black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                            textAlign: TextAlign.start),
                      ),
                      Expanded(
                        flex: 1,
                        child: Wrap(
                          alignment: WrapAlignment.end,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  if (!isDollar) {
                                    isDollar = true;
                                    currency = "NGN";
                                  } else {
                                    isDollar = false;
                                    currency = "USD";
                                  }
                                });
                              },
                              style: ButtonStyle(
                                  elevation: MaterialStateProperty.resolveWith<
                                      double>((Set<MaterialState> states) {
                                    if (states.contains(MaterialState.pressed))
                                      return 10.0;
                                    return 0.0;
                                  },
                                  ),
                                  backgroundColor: MaterialStateProperty.all(
                                      Color(0xFFFAFAFA)),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(10.0),
                                          side: BorderSide(
                                              color: Color(0xFFC9782F)))
                                  )
                              ),
                              child: Text(currency, style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold)),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Builder(
                  builder: (context) {
                    if (walletBalanceEntity == null) {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.all(25),
                          child: CircularProgressIndicator(
                            color: Color(0xFFC9782F),
                          ),
                        ),
                      );
                    } else {
                      if (walletBalanceEntity!.user!.userCoins == null) {
                        return Center(
                          child: Padding(
                            padding: const EdgeInsets.all(25),
                            child: CircularProgressIndicator(
                              color: Color(0xFFC9782F),
                            ),
                          ),
                        );
                      } else
                      if (walletBalanceEntity!.user!.userCoins!.isEmpty) {
                        return Center(
                          child: Padding(
                            padding: const EdgeInsets.all(25),
                            child: CircularProgressIndicator(
                              color: Color(0xFFC9782F),
                            ),
                          ),
                        );
                      }
                    }
                    return ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, position) {
                        var coin = walletBalanceEntity!.user!.userCoins!.elementAt(position);
                        int? rate = coin.coinTypes!.dollarRate;

                        String rateText = "USD " + rate!.toString();
                        if (!isDollar) {
                          rate = coin.coinTypes!.rate;
                          rateText = "NGN " + coin.coinTypes!.rate.toString();
                        }

                        return Padding(
                          padding: const EdgeInsets.all(25),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 8),
                                child: CircleAvatar(
                                    backgroundColor: Colors.transparent,
                                    child: CachedNetworkImage(
                                      imageUrl: coin.coinTypes!.image
                                          .toString(),
                                      placeholder: (context,
                                          url) => new CircularProgressIndicator(),
                                      errorWidget: (context, url,
                                          error) => new Icon(Icons.error),
                                    )),
                              ),
                              Expanded(
                                flex: 1,
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment
                                      .stretch,
                                  children: [
                                    Text(coin.coinTypes!.name.toString(),
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 18),
                                        textAlign: TextAlign.start),
                                    Text(coin.coinTypes!.symbol.toString()
                                        .toUpperCase(), style: TextStyle(
                                        color: Colors.black54,
                                        fontSize: 18),
                                        textAlign: TextAlign.start),
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
                                      mainAxisAlignment: MainAxisAlignment
                                          .center,
                                      crossAxisAlignment: CrossAxisAlignment
                                          .end,
                                      children: [
                                        Text(coin.coinTypes!.symbol.toString()
                                            .toUpperCase() + " " +
                                            coin.balance!.toString(),
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 18),
                                            textAlign: TextAlign.start),
                                        Text(rateText, style: TextStyle(
                                            color: Color(0xFFC9782F),
                                            fontSize: 18),
                                            textAlign: TextAlign.start),
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        );
                      },
                      shrinkWrap: true,
                      itemCount: 3,
                    );
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15, left: 25),
                  child: Text("What do you want to do today?", style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold)),
                ),
                Padding(
                  padding: const EdgeInsets.all(25),
                  child: Table(
                    children: [
                      TableRow(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 8, bottom: 8),
                            child: Container(
                              height: 150,
                              child: Card(
                                elevation: 8,
                                color: Color(0xFFE5E7FE),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(10))),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment
                                        .stretch,
                                    children: [
                                      Text('Crypto Currency', style: TextStyle(
                                          color: Colors.black, fontSize: 18),
                                          textAlign: TextAlign.start),
                                      Text('Buy and sell crypto currency today',
                                          style: TextStyle(
                                              color: Colors.black54,
                                              fontSize: 15),
                                          textAlign: TextAlign.start),
                                      Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Wrap(
                                              alignment: WrapAlignment.end,
                                              runAlignment: WrapAlignment.end,
                                              children: [
                                                CircleAvatar(
                                                    backgroundColor: Colors
                                                        .transparent,
                                                    child: Image(
                                                        image: AssetImage(
                                                            "assets/images/wallet.png")))
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
                            padding: const EdgeInsets.only(left: 8, bottom: 8),
                            child: Container(
                              height: 150,
                              child: Card(
                                elevation: 8,
                                color: Color(0xFFE5E7FE),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(10))),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment
                                        .stretch,
                                    children: [
                                      Text('Gift Card', style: TextStyle(
                                          color: Colors.black, fontSize: 18),
                                          textAlign: TextAlign.start),
                                      Text('Buy and sell gift cards today',
                                          style: TextStyle(
                                              color: Colors.black54,
                                              fontSize: 15),
                                          textAlign: TextAlign.start),
                                      Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Wrap(
                                              alignment: WrapAlignment.end,
                                              runAlignment: WrapAlignment.end,
                                              children: [
                                                CircleAvatar(
                                                    backgroundColor: Colors
                                                        .transparent,
                                                    child: Image(
                                                        image: AssetImage(
                                                            "assets/images/gift_card.png")))
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
                            padding: const EdgeInsets.only(right: 8, top: 8),
                            child: Container(
                              height: 150,
                              child: Card(
                                elevation: 8,
                                color: Color(0xFFFEFEF4),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(10))),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment
                                        .stretch,
                                    children: [
                                      Text('Invest', style: TextStyle(
                                          color: Colors.black, fontSize: 18),
                                          textAlign: TextAlign.start),
                                      Text(
                                          'Invest in daily and monthly plans today',
                                          style: TextStyle(
                                              color: Colors.black54,
                                              fontSize: 15),
                                          textAlign: TextAlign.start),
                                      Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Wrap(
                                              alignment: WrapAlignment.end,
                                              runAlignment: WrapAlignment.end,
                                              children: [
                                                CircleAvatar(
                                                    backgroundColor: Colors
                                                        .transparent,
                                                    child: Image(
                                                        image: AssetImage(
                                                            "assets/images/invest.png")))
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
                            padding: const EdgeInsets.only(left: 8, top: 8),
                            child: Container(
                              height: 150,
                              child: Card(
                                elevation: 8,
                                color: Color(0xFFFEFEF4),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(10))),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment
                                        .stretch,
                                    children: [
                                      Text('Learn', style: TextStyle(
                                          color: Colors.black, fontSize: 18),
                                          textAlign: TextAlign.start),
                                      Text('Subscribe to courses today',
                                          style: TextStyle(
                                              color: Colors.black54,
                                              fontSize: 15),
                                          textAlign: TextAlign.start),
                                      Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Wrap(
                                              alignment: WrapAlignment.end,
                                              runAlignment: WrapAlignment.end,
                                              children: [
                                                CircleAvatar(
                                                    backgroundColor: Colors
                                                        .transparent,
                                                    child: Image(
                                                        image: AssetImage(
                                                            "assets/images/subscribe.png")))
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
        ],
      ),
    );

    return newContainer;
  }
}
