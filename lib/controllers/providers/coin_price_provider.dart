import 'package:coingecko_dart/coingecko_dart.dart';
import 'package:coingecko_dart/dataClasses/coins/PricedCoin.dart';
import 'package:flutter/material.dart';

class CoinPriceProvider extends ChangeNotifier{
  CoinGeckoApi apiInstance = CoinGeckoApi();

  CoinGeckoResult<List<PricedCoin>> _bitcoinPrice = CoinGeckoResult(List.empty());
  CoinGeckoResult<List<PricedCoin>> get bitcoinPrice => _bitcoinPrice;

  CoinGeckoResult<List<PricedCoin>> _ethereumPrice = CoinGeckoResult(List.empty());
  CoinGeckoResult<List<PricedCoin>> get ethereumPrice => _ethereumPrice;

  CoinGeckoResult<List<PricedCoin>> _tetherPrice = CoinGeckoResult(List.empty());
  CoinGeckoResult<List<PricedCoin>> get tetherPrice => _tetherPrice;

  Future<CoinGeckoResult<List<PricedCoin>>> queryBitcoinPrice() async {
    CoinGeckoResult<List<PricedCoin>> result = await apiInstance.simplePrice(
        ids: ["bitcoin"],
        vs_currencies: ["ngn"],
        includeLastUpdatedAt: true,
        includeMarketCap: true);

    _bitcoinPrice = result;
    notifyListeners();
    return result;
  }

  Future<CoinGeckoResult<List<PricedCoin>>> queryEthereumPrice() async {
    CoinGeckoResult<List<PricedCoin>> result = await apiInstance.simplePrice(
        ids: ["ethereum"],
        vs_currencies: ["ngn"],
        includeLastUpdatedAt: true,
        includeMarketCap: true);

    _ethereumPrice = result;
    notifyListeners();
    return result;
  }

  Future<CoinGeckoResult<List<PricedCoin>>> queryTetherPrice() async {
    CoinGeckoResult<List<PricedCoin>> result = await apiInstance.simplePrice(
        ids: ["tether"],
        vs_currencies: ["ngn"],
        includeLastUpdatedAt: true,
        includeMarketCap: true);

    _tetherPrice = result;
    notifyListeners();
    return result;
  }
}