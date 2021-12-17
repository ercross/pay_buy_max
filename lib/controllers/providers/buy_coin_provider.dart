import 'package:flutter/material.dart';
import 'package:pay_buy_max/views/screens/landing_screen_scaffold/tabs/home_tab/buy_services.dart';
import '../../models/coin.dart';

class BuyCoinProvider extends ChangeNotifier {
  late BuySource? _buySource;
  int _currentCoinIndex;
  double _amount = 0;
  double _nairaEquivalent = 0;
  double _dollarEquivalent = 0;
  final double dollarToNaira = 508;
  late List<Coin> _coins = [
    Coin(
        logoUrl: "assets/images/bitcoin_logo.png",
        abbreviatedName: "BTC",
        name: "Bitcoin",
        nairaAmount: 21930000,
        dollarAmount: 43000),
    Coin(
        logoUrl: "assets/images/ethereum_logo.png",
        abbreviatedName: "ETH",
        name: "Ethereum",
        nairaAmount: 1520000,
        dollarAmount: 3000),
    Coin(
        logoUrl: "assets/images/usdt_logo.png",
        abbreviatedName: "USDT",
        name: "Tether",
        nairaAmount: 508,
        dollarAmount: 1),

    // Coin(
    //     logoUrl: "assets/images/bnb_logo.png",
    //     abbreviatedName: "BNB",
    //     name: "Binance Coin",
    //     nairaAmount: 200000,
    //     dollarAmount: 420),
    // Coin(
    //     logoUrl: "assets/images/dogecoin_logo.png",
    //     abbreviatedName: "DOGE",
    //     name: "Doge Coin",
    //     nairaAmount: 300,
    //     dollarAmount: 0.6200),
    // Coin(
    //     logoUrl: "assets/images/rmb_logo.jpg",
    //     name: "Ren Min Bi",
    //     abbreviatedName: "RMB",
    //     nairaAmount: 5000,
    //     dollarAmount: 10),
  ];

  BuyCoinProvider() : _currentCoinIndex = 0;

  /// [amount] is the unit of the coin to be bought has entered by the user
  double get amount => _amount;
  double get nairaEquivalent => _nairaEquivalent;
  double get dollarEquivalent => _dollarEquivalent;
  BuySource? get buySource => _buySource;
  int get currentCoinIndex => _currentCoinIndex;
  List<Coin> get coins => _coins;

  void changeAmount(double newAmount) {
    _amount = newAmount;
    _nairaEquivalent = _amount * _coins[_currentCoinIndex].dollarAmount * dollarToNaira;
    _dollarEquivalent = _coins[_currentCoinIndex].dollarAmount * _amount;
    notifyListeners();
  }

  void updateBuySource(BuySource? newValue) {
    _buySource = newValue;
    notifyListeners();
  }

  void changeCurrent(int index) {
    _currentCoinIndex = index;
    notifyListeners();
  }

}
