import 'package:flutter/material.dart';
import 'package:pay_buy_max/models/coin.dart';

class BuyCoinProvider extends ChangeNotifier {
  int _currentCoinIndex;
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
    Coin(
        logoUrl: "assets/images/bnb_logo.png",
        abbreviatedName: "BNB",
        name: "Binance Coin",
        nairaAmount: 200000,
        dollarAmount: 420),
    Coin(
        logoUrl: "assets/images/dogecoin_logo.png",
        abbreviatedName: "DOGE",
        name: "Doge Coin",
        nairaAmount: 300,
        dollarAmount: 0.6200),
    Coin(
        logoUrl: "assets/images/rmb_logo.jpg",
        name: "Ren Min Bi",
        abbreviatedName: "RMB",
        nairaAmount: 5000,
        dollarAmount: 10),
  ];

  BuyCoinProvider() : _currentCoinIndex = 0;

  int get currentCoinIndex => _currentCoinIndex;
  List<Coin> get coins => _coins;

  void changeCurrent(int index) {
    _currentCoinIndex = index;
    notifyListeners();
  }
}
