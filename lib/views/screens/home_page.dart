import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fragment_navigate/navigate-control.dart';
import 'package:fragment_navigate/navigate-support.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pay_buy_max/controllers/providers/user_provider.dart';
import 'package:pay_buy_max/models/auth/sign_in_response_entity.dart';
import 'package:pay_buy_max/models/transfer/bank_list_entity.dart';
import 'package:pay_buy_max/models/transfer/verify_bank_entity.dart';
import 'package:pay_buy_max/models/transfer/withdraw_naira_entity.dart';
import 'package:pay_buy_max/models/transfer/withdraw_coin_entity.dart';
import 'package:pay_buy_max/models/wallet/code_response_entity.dart';
import 'package:pay_buy_max/views/screens/exchange_screens/exchange_screen.dart';
import 'package:pay_buy_max/views/screens/history/history_buy.dart';
import 'package:pay_buy_max/views/screens/history/history_sell.dart';
import 'package:pay_buy_max/views/screens/learn_screens/learn_screen.dart';
import 'package:pay_buy_max/views/screens/refer_screens/referral.dart';
import 'package:pay_buy_max/views/screens/settings_screens/setting_screen.dart';
import 'package:pay_buy_max/views/screens/tawk/chat.dart';
import 'package:pay_buy_max/views/screens/wallet_screens/all_wallet_balance.dart';
import 'package:pay_buy_max/views/screens/wallet_screens/fund_local_wallet.dart';
import 'package:pay_buy_max/views/screens/wallet_screens/local_wallet_screen.dart';
import 'package:pay_buy_max/views/screens/wallet_screens/wallet_arguments.dart';
import 'package:pay_buy_max/views/screens/wallet_screens/wallet_screen.dart';
import 'package:pay_buy_max/models/wallet/wallet_balance_entity.dart';
import 'package:pay_buy_max/views/screens/withdraw/withdraw.dart';
import 'package:pay_buy_max/views/widgets/overlays.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../../../style_sheet.dart';
import '../../main.dart';
import 'admin_screens/admin_screen.dart';
import 'authentication_screens/sign_up_screen.dart';
import 'exchange_screens/sell_coin.dart';
import 'history/history.dart';
import 'investment_screens/investment_screen.dart';
import 'notification_screens/notification_screen.dart';
import 'package:get/get.dart';

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
  late TextEditingController _errorFieldController;

  @override
  void initState() {
    super.initState();
    _amtFieldController = TextEditingController();
    _accFieldController = TextEditingController();
    _otpFieldController = TextEditingController();
    _nameFieldController = TextEditingController();
    _errorFieldController = TextEditingController();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      getBankList().then((value) => {
        bankListEntity = value
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

  Future<WithdrawNairaEntity> withdrawNaira(String accountNo,String accountName,String bankCode,String bankName,String amount,String otpCode) async {
    try {
      print(accountNo);
      String url = 'https://paybuymax.com/api/userwithdraw';
      var body = {"acct_number":accountNo,"bank_code":bankCode,"acct_name":accountName,"bank_name":bankName,"amount":amount,"code":otpCode};
      final response = await http.post(Uri.parse(url), headers: {"Authorization": args.token.toString()},body: body);
      print(response.body);
      return WithdrawNairaEntity().fromJson(json.decode(response.body));
    } catch(e){
      var error = WithdrawNairaEntity();
      error.status = false;
      return error;
    }
  }

  Future<WithdrawCoinEntity> withdrawCoin(String coinType,String walletAddress,String amount,String otpCode) async {
    try {
      String url = 'https://paybuymax.com/api/userwithdraw-coin';
      var body = {"amount":amount,"coinType":coinType,"wallet_address":walletAddress,"code":otpCode};
      final response = await http.post(Uri.parse(url), headers: {"Authorization": args.token.toString()},body: body);
      print(response.body);
      return WithdrawCoinEntity().fromJson(json.decode(response.body));
    } catch(e){
      var error = WithdrawCoinEntity();
      error.status = false;
      return error;
    }
  }

  Future<VerifyBankEntity> getAccountName(String account,String bankCode) async {
    try {
      String url = 'https://paybuymax.com/api/verifyAccount';
      var body = {"account":account,"bank_code":bankCode};
      final response = await http.post(Uri.parse(url), headers: {"Authorization": args.token.toString()},body: body);
      print(response.body);
      return VerifyBankEntity().fromJson(json.decode(response.body));
    } catch(e){
      var error = VerifyBankEntity();
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
    var sentOTP = false;
    var gotName = false;
    _amtFieldController.text = "";
    _accFieldController.text = "";
    _otpFieldController.text = "";
    _nameFieldController.text = "";
    _errorFieldController.text = "Fill The Empty Fields And Click Ok To Continue";

    return showDialog(
        barrierDismissible: false,
        context: context1,
        builder: (context) {
          return AlertDialog(
            title: Column(
              children: [
                Text('Withdraw From Naira Wallet', style: TextStyle(color: Color(0xFFC9782F)), textAlign: TextAlign.center),
                TextField(
                    controller: _errorFieldController,
                    style: TextStyle(color: Colors.black,fontSize: 15),
                    textAlign: TextAlign.center,
                    readOnly: true,
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
                      filled: false,
                      contentPadding: EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
                    )),
              ],
            ),
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
                          gotName = false;
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
                        onChanged: (text) {
                          gotName = false;
                        },
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
                    if(_amtFieldController.text.isEmpty){
                      _errorFieldController.text = "Enter Amount";
                    }else if(_accFieldController.text.isEmpty){
                      _errorFieldController.text = "Enter Account Number";
                    } else{
                      if(gotName){
                        if(sentOTP){
                          if(_otpFieldController.text.isEmpty){
                            _errorFieldController.text = "Enter OTP Code";
                          }else{
                            Navigator.pop(context1);
                            showLoadingDialog(context1,"Performing Transaction, Please Wait");
                            withdrawNaira(_accFieldController.text, _nameFieldController.text, bankMap[value1].toString(), value1, _amtFieldController.text, _otpFieldController.text).then((value){
                              Navigator.pop(context1);
                              if(value.status == true){
                                if(value.message == null){
                                  AppOverlay.snackbar(title: "Success",message: "Transaction Successful");
                                }else{
                                  AppOverlay.snackbar(title: "Success",message: value.message.toString());
                                }
                              }else{
                                if(value.message == null){
                                  AppOverlay.snackbar(title: "Error",message: "An Error Occurred");
                                }else{
                                  AppOverlay.snackbar(title: "Error",message: value.message.toString());
                                }
                              }
                            });
                          }
                        }else{
                          showLoadingDialog(context1,"Sending OTP Code");
                          sendOTPCode("money", args.user!.id.toString(), double.parse(_amtFieldController.text)).then((value){
                            Navigator.pop(context1);
                            if(value.success == true){
                              _errorFieldController.text = "Check Your Email For OTP Code";
                              sentOTP = true;
                            }else{
                              _errorFieldController.text = "Unable To Send OTP Code.Please Try Again";
                              sentOTP = false;
                            }
                          });
                        }
                      }else{
                        _errorFieldController.text = "Getting Account Name";
                        showLoadingDialog(context1,"Getting Account Name, Please Wait");
                        getAccountName(_accFieldController.text, bankMap[value1].toString()).then((value){
                          Navigator.pop(context1);
                          if(value.status == true){
                            _errorFieldController.text = "Click Ok To Continue With Transfer";
                            _nameFieldController.text = value.data!.accountName.toString();
                            gotName = true;
                          }else{
                            _errorFieldController.text = "An Error Occurred";
                            if(value.message.toString().isNotEmpty){
                              _errorFieldController.text = value.message.toString();
                            }
                            gotName = false;
                          }
                        });
                      }
                    }
                  },
                ),
              ),
            ],
          );
        });
  }

  Future<void> showCryptoTransferDialog(BuildContext context1){
    var coins = walletBalanceEntity!.user!.userCoins!;
    String value1 = "";
    var coinList = List<String>.from(List.empty());
    var coinMap = {"":""};
    var sentOTP = false;

    _errorFieldController.text = "Fill The Empty Fields And Click Ok To Continue";
    _amtFieldController.text = "";
    _accFieldController.text = "";
    _otpFieldController.text = "";
    _nameFieldController.text = "";

    for(int i = 0;i< coins.length;i++){
      coinList.add(coins.elementAt(i).coinTypes!.name!);
      coinMap.putIfAbsent(coins.elementAt(i).coinTypes!.name!, () => coins.elementAt(i).coinId!);
    }

    value1 = coinList.elementAt(0);

    return showDialog(
        barrierDismissible: false,
        context: context1,
        builder: (context) {
          return AlertDialog(
            title: Column(
              children: [
                Text('Withdraw From Crypto Wallet', style: TextStyle(color: Color(0xFFC9782F)), textAlign: TextAlign.center),
                TextField(
                    controller: _errorFieldController,
                    style: TextStyle(color: Colors.black,fontSize: 15),
                    textAlign: TextAlign.center,
                    readOnly: true,
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
                      filled: false,
                      contentPadding: EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
                    )),
              ],
            ),
            content: StatefulBuilder(
              builder: (BuildContext context,StateSetter setState){
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Amount To Send', style: TextStyle(color: Color(0xFF000000), fontSize: 14,fontWeight: FontWeight.bold), textAlign: TextAlign.start),
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
                      child:  Text('Crypto Type', style: TextStyle(color: Color(0xFF000000), fontSize: 14,fontWeight: FontWeight.bold), textAlign: TextAlign.start),
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
                            isExpanded: true, items: coinList.map((String value) {
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
                      child:  Text('Wallet Address', style: TextStyle(color: Color(0xFF000000), fontSize: 14,fontWeight: FontWeight.bold), textAlign: TextAlign.start),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 1),
                      child: TextField(
                        controller: _accFieldController,
                        decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFFC9782F),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            hintText: "Enter Wallet Address",border: OutlineInputBorder(),contentPadding: EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8)),
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
                    if(_amtFieldController.text.isEmpty){
                      _errorFieldController.text = "Enter Amount";
                    }else if(_accFieldController.text.isEmpty){
                      _errorFieldController.text = "Enter Wallet Address";
                    } else{
                      _errorFieldController.text = "Sending OTP Code";
                      if(sentOTP){
                        if(_otpFieldController.text.isEmpty){
                          _errorFieldController.text = "Enter OTP Code";
                        }else{
                          Navigator.pop(context1);
                          showLoadingDialog(context1,"Performing Transaction, Please Wait");
                          withdrawCoin(coinMap[value1].toString(), _accFieldController.text, _amtFieldController.text, _otpFieldController.text).then((value) {
                            Navigator.pop(context1);
                            if(value.status == true){
                              if(value.message == null){
                                AppOverlay.snackbar(title: "Success",message: "Transaction Successful");
                              }else{
                                AppOverlay.snackbar(title: "Success",message: value.message.toString());
                              }
                            }else{
                              if(value.message == null){
                                AppOverlay.snackbar(title: "Error",message: "An Error Occurred");
                              }else{
                                AppOverlay.snackbar(title: "Error",message: value.message.toString());
                              }
                            }
                            _errorFieldController.text = "";
                          });
                        }
                      }else{
                        showLoadingDialog(context1,"Sending OTP Code");
                        sendOTPCode("money", args.user!.id.toString(), double.parse(_amtFieldController.text)).then((value){
                          Navigator.pop(context1);
                          if(value.success == true){
                            _errorFieldController.text = "Check Your Email For OTP Code";
                            sentOTP = true;
                          }else{
                            _errorFieldController.text = "Unable To Send OTP Code.Please Try Again";
                            sentOTP = false;
                          }
                        });
                      }
                    }
                  },
                ),
              ),
            ],
          );
        });
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
                Navigator.pop(context);
                showCryptoTransferDialog(context);
              },
              child: Text("Withdraw From Crypto Wallet",style: TextStyle(color: Color(0xFFFAFAFA))),
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Color(0xFFC9782F)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0),side: BorderSide(color: Color(0xFFC9782F))))),
            ),
          ),
        ],
      ),
    );

    showDialog(barrierDismissible: true, context:context, builder: (BuildContext context){
      return alertDialog;
    });
  }

  void showLoadingDialog(BuildContext context,String text){
    AlertDialog alertDialog = AlertDialog(
      content: Row(
        children: [
          CircularProgressIndicator(),
          Container(
            margin: EdgeInsets.only(left: 10),
            child: Text(text),
          )
        ],
      ),
    );

    showDialog(barrierDismissible: false, context:context, builder: (BuildContext context){
      return alertDialog;
    });
  }

  Future<CodeResponseEntity> sendOTPCode(String type, String userID, double amount) async{
    try {
      String url = 'https://paybuymax.com/api/withdraw/code';

      var body = {"type":type,"userId":userID,"amount":amount.toString()};
      final response = await http.post(Uri.parse(url),headers: {"Authorization":args.token.toString()},body: body);
      print(response.body);
      return CodeResponseEntity().fromJson(json.decode(response.body));
    } catch(e){
      var error = CodeResponseEntity();
      error.msg = "An Error Occurred";
      error.success = false;
      return error;
    }
  }

  final GlobalKey<ScaffoldState> key = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    args = ModalRoute.of(context)!.settings.arguments as SignInResponseEntity;

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
              Navigator.of(context).pushNamed(NotificationScreen.route,arguments: args);
            },
            color: Color(0xFFFAFAFA))
      ],
    );

    final double height = MediaQuery.of(context).size.height - (appBar.preferredSize.height + MediaQuery.of(context).padding.top);

    Container newContainer = new Container(
      height: height,
      color: StyleSheet.primaryColor.withOpacity(0.09),
      width: MediaQuery.of(context).size.width,
      child: Flex(
        direction: Axis.vertical,
        children: [
          Expanded(
            child: StatefulBuilder(
              builder: (BuildContext context1,StateSetter setState){
                getWalletInfo().then((value) {
                  try{
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
                  }catch(e){

                  }
                });

                return ListView(
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
                          return Text("", style: TextStyle(color: Colors.black, fontSize: 22,
                              fontWeight: FontWeight.bold));
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 20, left: 25, right: 25, bottom: 10),
                      child: Container(
                          height: 290,
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
                                                              _fragNav.putPosit(key: ValueKey(FundLocalWallet.route), closeDrawer: true);
                                                            },
                                                          ),
                                                          Text('Fund',
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
                                                            icon: new Icon(Icons.show_chart),
                                                            onPressed: () {
                                                              _fragNav.putPosit(key: ValueKey(InvestmentScreen.route), closeDrawer: true);
                                                            },
                                                          ),
                                                          Text('Invest',
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
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 15, right: 15, bottom: 5),
                                        child: ElevatedButton(
                                          onPressed: () {
                                            var link = "https://paybuymax.com/signup?ref="+args.user!.referralId.toString();
                                            Clipboard.setData(ClipboardData(text: link));
                                            AppOverlay.snackbar(title: "Success",message: "Link Copied To Clipboard");
                                          },
                                          child: Text("Copy Referral Link",style: TextStyle(color: Color(0xFF000000))),
                                          style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Color(0xFFFFFFFF))),
                                        ),
                                      )
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
                                  child: GestureDetector(
                                    onTap: (){
                                      _fragNav.putPosit(
                                          key: ValueKey(SellCoin.route),
                                          closeDrawer: true);
                                    },
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
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8, bottom: 8),
                                child: Container(
                                  height: 150,
                                  child: GestureDetector(
                                    onTap: (){
                                      _fragNav.putPosit(
                                          key: ValueKey(ExchangeScreen.route),
                                          closeDrawer: true);
                                    },
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
                              ),
                            ],
                          ),
                          TableRow(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 8, top: 8),
                                child: Container(
                                    height: 150,
                                    child:
                                    GestureDetector(
                                      onTap: (){
                                        _fragNav.putPosit(
                                            key: ValueKey(InvestmentScreen.route),
                                            closeDrawer: true);
                                      },
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
                                    )
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8, top: 8),
                                child: Container(
                                  height: 150,
                                  child: GestureDetector(
                                    onTap: (){
                                      _fragNav.putPosit(
                                          key: ValueKey(LearnScreen.route),
                                          closeDrawer: true);
                                    },
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
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );

    _fragNav = FragNavigate(
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
            title: "Fund History",
            key: ValueKey(History.route),
            fragment: History(),
          ),
          Posit(
            title: "Sell History",
            key: ValueKey(HistoryBuy.route),
            fragment: HistoryBuy(),
          ),
          Posit(
            title: "Buy History",
            key: ValueKey(HistorySell.route),
            fragment: HistorySell(),
          ),
          Posit(
            title: "My Referrals",
            key: ValueKey(ReferralScreen.route),
            fragment: ReferralScreen(),
          ),
          Posit(
            title: "Admin Messages",
            key: ValueKey(AdminScreen.route),
            fragment: AdminScreen(),
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
                            Navigator.of(context).pushNamed(NotificationScreen.route,arguments: args);
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
                                        key: ValueKey(History.route),
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
                                  title: const Text('Sell History', style: TextStyle(
                                      color: Color(0xFFFAFAFA))),
                                  onTap: () {
                                    _fragNav.putPosit(
                                        key: ValueKey(HistoryBuy.route),
                                        closeDrawer: true);
                                  }),
                              ListTile(leading: Icon(Icons
                                  .arrow_forward_ios_rounded),
                                  title: const Text('Buy History', style: TextStyle(
                                      color: Color(0xFFFAFAFA))),
                                  onTap: () {
                                    _fragNav.putPosit(
                                        key: ValueKey(HistorySell.route),
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
                            leading: Icon(Icons.email),
                            title: const Text('Admin Messages', style: TextStyle(color: Color(0xFFFAFAFA))),
                            onTap: () {
                              _fragNav.putPosit(key: ValueKey(AdminScreen.route), closeDrawer: true);
                            }),
                        ListTile(
                            iconColor: Color(0xFFFAFAFA),
                            textColor: Color(0xFFFAFAFA),
                            tileColor: Color(0xFFC9782F),
                            leading: Icon(Icons.people_sharp),
                            title: const Text('My Referrals', style: TextStyle(color: Color(0xFFFAFAFA))),
                            onTap: () {
                              _fragNav.putPosit(key: ValueKey(ReferralScreen.route), closeDrawer: true);
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
                            //Get.offAll(SignUpPage());
                            //Navigator.of(context).pushReplacementNamed(SignUpPage.route);
                            //Navigator.of(context).popAndPushNamed(SignUpPage.route);
                            Navigator.of(context).pushNamedAndRemoveUntil(SignUpPage.route,(Route<dynamic> route) => false);
                            runApp(MultiProvider(
                                providers: [
                                  ChangeNotifierProvider<UserProvider>(create: (context) => UserProvider()),
                                ],
                                child: PayBuyMax()));
                          },
                        )
                      ],
                    ),
                  ),
                  body: Stack(
                    alignment: AlignmentDirectional.bottomEnd,
                    children: [
                      ScreenNavigate(
                          child: s.data!.fragment,
                          control: _fragNav
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: InkWell(
                          child: CircleAvatar(
                            radius: 50,
                            backgroundColor: Color(0xFFC9782F),
                            child: Padding(
                              padding: const EdgeInsets.all(10), // Border radius
                              child: ClipOval(child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Image.asset("assets/images/chat.png",scale: 0.5,color: Color(0xFFFFFFFF),),
                              )),
                            ),
                          ),
                          onTap: (){
                            Navigator.of(context).pushNamed(ChatPage.route,arguments: args);
                          },
                        ),
                      )
                    ],
                  ),
                )
            );
          }
          return Container();
        }
    );
  }
}
