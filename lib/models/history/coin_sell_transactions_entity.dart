import 'package:pay_buy_max/generated/json/base/json_convert_content.dart';
import 'package:pay_buy_max/generated/json/base/json_field.dart';

class CoinSellTransactionsEntity with JsonConvert<CoinSellTransactionsEntity> {
	bool? status;
	List<CoinSellTransactionsTransactions>? transactions;
}

class CoinSellTransactionsTransactions with JsonConvert<CoinSellTransactionsTransactions> {
	String? id;
	String? userId;
	String? coinId;
	double? qty;
	int? dollarAmount;
	int? nairaAmount;
	String? sellBy;
	String? reference;
	String? createdAt;
	String? updatedAt;
	dynamic? deletedAt;
	CoinSellTransactionsTransactionsCoin? coin;
	CoinSellTransactionsTransactionsUser? user;
}

class CoinSellTransactionsTransactionsCoin with JsonConvert<CoinSellTransactionsTransactionsCoin> {
	String? id;
	String? name;
	String? symbol;
	int? rate;
	int? dollarRate;
	int? charge;
	int? maxWithdrawal;
	String? image;
	String? createdAt;
	String? updatedAt;
	dynamic? deletedAt;
}

class CoinSellTransactionsTransactionsUser with JsonConvert<CoinSellTransactionsTransactionsUser> {
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
