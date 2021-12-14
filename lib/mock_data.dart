import 'models/transaction.dart';

import 'models/asset.dart';

class MockData {
  static final Transaction _t1 = Transaction(
      referenceNumber: "Qwerty",
      amount: 100000,
      date: DateTime.now(),
      type: TransactionType.withdrawal,
      currency: "NGN");

  static final Transaction _t2 = Transaction(
      referenceNumber: "Qwerty",
      amount: 0.123100,
      date: DateTime.now(),
      type: TransactionType.sell,
      currency: "BTC");

  static final Transaction _t3 = Transaction(
      referenceNumber: "Qwerty",
      amount: 12,
      date: DateTime.now(),
      type: TransactionType.buy,
      currency: "ETH");

  static final Transaction _t4 = Transaction(
      referenceNumber: "Qwerty",
      amount: 2,
      date: DateTime.now(),
      type: TransactionType.sell,
      currency: "Amazon Giftcard");

  static final Transaction _t5 = Transaction(
      amount: 230000,
      referenceNumber: "Qwerty",
      date: DateTime.now(),
      type: TransactionType.credit,
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
      logoUrl: "assets/images/usdt_logo.png",
      balance: 12000000,
      fullname: "Tether",
      abbreviatedName: "USDT",
      nairaAmount: 4000000);

  static final List<Asset> assets = [_a1, _a2, _a3];
}
