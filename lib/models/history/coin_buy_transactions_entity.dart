import 'package:pay_buy_max/generated/json/base/json_convert_content.dart';
import 'package:pay_buy_max/generated/json/base/json_field.dart';

class CoinBuyTransactionsEntity with JsonConvert<CoinBuyTransactionsEntity> {
	bool? status;
	List<CoinBuyTransactionsTransactions>? transactions;
}

class CoinBuyTransactionsTransactions with JsonConvert<CoinBuyTransactionsTransactions> {
	String? id;
	String? userId;
	String? customerName;
	String? customerEmail;
	String? coinId;
	double? qty;
	int? dollarAmount;
	int? nairaAmount;
	String? medium;
	String? exchange;
	String? reference;
	String? createdAt;
	String? updatedAt;
	dynamic? deletedAt;
	CoinBuyTransactionsTransactionsCoin? coin;
	CoinBuyTransactionsTransactionsUser? user;
}

class CoinBuyTransactionsTransactionsCoin with JsonConvert<CoinBuyTransactionsTransactionsCoin> {
	String? id;
	String? name;
	String? symbol;
	int? rate;
	double? dollarRate;
	int? charge;
	int? maxWithdrawal;
	String? image;
	String? createdAt;
	String? updatedAt;
	dynamic? deletedAt;
}

class CoinBuyTransactionsTransactionsUser with JsonConvert<CoinBuyTransactionsTransactionsUser> {
	String? id;
	String? name;
	String? email;
	@JSONField(name: "email_token")
	String? emailToken;
	int? activated;
	String? phone;
	dynamic? mining;
	int? wallet;
	int? revenue;
	dynamic? walletAddress;
	@JSONField(name: "referral_count")
	int? referralCount;
	@JSONField(name: "referral_amount")
	int? referralAmount;
	String? password;
	String? reference;
	@JSONField(name: "referral_id")
	dynamic? referralId;
	@JSONField(name: "oauth_id")
	dynamic? oauthId;
	@JSONField(name: "oauth_token")
	String? oauthToken;
	String? createdAt;
	String? updatedAt;
	dynamic? deletedAt;
}
