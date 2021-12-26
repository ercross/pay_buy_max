import 'package:coingecko_dart/coingecko_dart.dart';
import 'package:coingecko_dart/dataClasses/coins/CoinDataPoint.dart';
import 'package:coingecko_dart/dataClasses/coins/PricedCoin.dart';
import 'package:flutter/material.dart';
import 'package:pay_buy_max/models/auth/sign_in_response_entity.dart';
import 'package:pay_buy_max/models/wallet/wallet_balance_entity.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class UserProvider extends ChangeNotifier{
  SignInResponseEntity? signInResponseEntity;
  WalletBalanceEntity? walletBalanceEntity;

  void setSignInResponseEntity(SignInResponseEntity signInResponseEntity){
    this.signInResponseEntity = signInResponseEntity;
    notifyListeners();
  }

  void setWalletBalanceEntity(WalletBalanceEntity walletBalanceEntity){
    this.walletBalanceEntity = walletBalanceEntity;
    notifyListeners();
  }
}