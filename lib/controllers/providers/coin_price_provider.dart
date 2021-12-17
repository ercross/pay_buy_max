import 'package:coingecko_dart/coingecko_dart.dart';
import 'package:coingecko_dart/dataClasses/coins/CoinDataPoint.dart';
import 'package:coingecko_dart/dataClasses/coins/PricedCoin.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

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

  CoinGeckoResult<List<CoinDataPoint>> bitcoinChart = CoinGeckoResult(List.empty());
  Future<CoinGeckoResult<List<CoinDataPoint>>> getBitCoinMarketChart(DateTime from,DateTime to,RefreshController _refreshController) async {
    var result = await apiInstance.getCoinMarketChartRanged(
        id: "bitcoin",
        vsCurrency: "ngn",
        from: from,
        to: to);
    
    if(result.isError){
      if(bitcoinChart.data.isEmpty){
        _refreshController.resetNoData();
      }else{
        _refreshController.refreshFailed();
      }
    }else{
      bitcoinChart = result;
      notifyListeners();
      if(bitcoinChart.data.isEmpty){
        _refreshController.resetNoData();
      }else{
        _refreshController.refreshCompleted();
      }
    }
    return result;
  }

  CoinGeckoResult<List<CoinDataPoint>> ethereumChart = CoinGeckoResult(List.empty());
  Future<CoinGeckoResult<List<CoinDataPoint>>> getEthereumMarketChart(DateTime from,DateTime to,RefreshController _refreshController) async {
    var result = await apiInstance.getCoinMarketChartRanged(
        id: "ethereum",
        vsCurrency: "ngn",
        from: from,
        to: to);
    
    if(result.isError){
      if(ethereumChart.data.isEmpty){
        _refreshController.resetNoData();
      }else{
        _refreshController.refreshFailed();
      }
    }else{
      ethereumChart = result;
      notifyListeners();
      if(ethereumChart.data.isEmpty){
        _refreshController.resetNoData();
      }else{
        _refreshController.refreshCompleted();
      }
    }
    return result;
  }

  CoinGeckoResult<List<CoinDataPoint>> tetherChart = CoinGeckoResult(List.empty());
  Future<CoinGeckoResult<List<CoinDataPoint>>> getTetherMarketChart(DateTime from,DateTime to,RefreshController _refreshController) async {
    var result = await apiInstance.getCoinMarketChartRanged(
        id: "tether",
        vsCurrency: "ngn",
        from: from,
        to: to);

    if(result.isError){
      if(tetherChart.data.isEmpty){
        _refreshController.resetNoData();
      }else{
        _refreshController.refreshFailed();
      }
    }else{
      tetherChart = result;
      notifyListeners();
      if(tetherChart.data.isEmpty){
        _refreshController.resetNoData();
      }else{
        _refreshController.refreshCompleted();
      }
    }
    return result;
  }

}