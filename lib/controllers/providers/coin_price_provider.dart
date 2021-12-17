import 'package:coingecko_dart/coingecko_dart.dart';
import 'package:coingecko_dart/dataClasses/coins/PricedCoin.dart';
import 'package:flutter/material.dart';

class CoinPriceProvider extends ChangeNotifier{
  CoinGeckoApi apiInstance = CoinGeckoApi();

  late CoinGeckoResult<List<PricedCoin>>? _bitcoinPrice;
  CoinGeckoResult<List<PricedCoin>>? get bitcoinPrice => _bitcoinPrice;

  late CoinGeckoResult<List<PricedCoin>>? _ethereumPrice;
  CoinGeckoResult<List<PricedCoin>>? get ethereumPrice => _ethereumPrice;

  late CoinGeckoResult<List<PricedCoin>>? _tetherPrice;
  CoinGeckoResult<List<PricedCoin>>? get tetherPrice => _tetherPrice;

  void getBitcoinPrice(){
    queryBitcoinPrice().then((value){
      _bitcoinPrice = value;
      notifyListeners();
    }, onError: (error) {
      print(error);
    });
  }

  void getEthereumPrice(){
    queryBitcoinPrice().then((value){
      _ethereumPrice = value;
      notifyListeners();
    }, onError: (error) {
      print(error);
    });
  }

  void getTetherPrice(){
    queryBitcoinPrice().then((value){
      _tetherPrice = value;
      notifyListeners();
    }, onError: (error) {
      print(error);
    });
  }

  Future<CoinGeckoResult<List<PricedCoin>>> queryBitcoinPrice() async {
    CoinGeckoResult<List<PricedCoin>> result = await apiInstance.simplePrice(
        ids: ["bitcoin"],
        vs_currencies: ["ngn"],
        includeLastUpdatedAt: true,
        includeMarketCap: true);

    return result;
  }

  Future<CoinGeckoResult<List<PricedCoin>>> queryEthereumPrice() async {
    CoinGeckoResult<List<PricedCoin>> result = await apiInstance.simplePrice(
        ids: ["ethereum"],
        vs_currencies: ["ngn"],
        includeLastUpdatedAt: true,
        includeMarketCap: true);

    return result;
  }

  Future<CoinGeckoResult<List<PricedCoin>>> queryTetherPrice() async {
    CoinGeckoResult<List<PricedCoin>> result = await apiInstance.simplePrice(
        ids: ["tether"],
        vs_currencies: ["ngn"],
        includeLastUpdatedAt: true,
        includeMarketCap: true);

    return result;
  }

}