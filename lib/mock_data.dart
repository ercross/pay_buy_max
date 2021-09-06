import 'models/transaction.dart';

import 'models/asset.dart';

class MockData {
  static final Transaction _t1 = Transaction(
      amount: 100000,
      date: DateTime.now(),
      transactionType: TransactionType.withdrawal,
      currency: "NGN");

  static final Transaction _t2 = Transaction(
      amount: 0.123100,
      date: DateTime.now(),
      transactionType: TransactionType.sell,
      currency: "BTC");

  static final Transaction _t3 = Transaction(
      amount: 12,
      date: DateTime.now(),
      transactionType: TransactionType.buy,
      currency: "ETH");

  static final Transaction _t4 = Transaction(
      amount: 2,
      date: DateTime.now(),
      transactionType: TransactionType.sell,
      currency: "Amazon Giftcard");

  static final Transaction _t5 = Transaction(
      amount: 230000,
      date: DateTime.now(),
      transactionType: TransactionType.credit,
      currency: "NGN");

  static late List<Transaction> transactions = [_t1, _t2, _t3, _t4, _t5];

  static final Asset _a1 = Asset(
      logoUrl: "assets/images/bitcoin_logo.png",
      balance: 12.212012,
      fullname: "Bitcoin",
      abbreviatedName: "BTC",
      nairaAmount: 140000000);

  static final Asset _a2 = Asset(
      logoUrl: "assets/images/ethereum_logo.png",
      balance: 120,
      fullname: "Ethereum",
      abbreviatedName: "ETH",
      nairaAmount: 98000000);

  static final Asset _a3 = Asset(
      logoUrl: "assets/images/dogecoin_logo.png",
      balance: 12000000,
      fullname: "Doge Coin",
      abbreviatedName: "DOGE",
      nairaAmount: 4000000);

  static final Asset _a4 = Asset(
      logoUrl: "assets/images/rmb_logo.jpg",
      balance: 1000000,
      fullname: "Ren Min Bi",
      abbreviatedName: "RMB",
      nairaAmount: 5000000);

  static final Asset _a5 = Asset(
      logoUrl: "assets/images/bnb_logo.png",
      balance: 120,
      fullname: "Binance Coin",
      abbreviatedName: "BNB",
      nairaAmount: 6500000);

  static final Asset _a6 = Asset(
      logoUrl: "assets/images/amazon_giftcard.png",
      balance: 12,
      fullname: "Amazon Giftcards",
      abbreviatedName: "AMG",
      nairaAmount: 200000);

  static late List<Asset> assets = [_a1, _a2, _a3, _a4, _a5, _a6];
}
