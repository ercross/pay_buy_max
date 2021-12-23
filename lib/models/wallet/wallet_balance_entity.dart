import 'package:pay_buy_max/generated/json/base/json_convert_content.dart';
import 'package:pay_buy_max/generated/json/base/json_field.dart';

class WalletBalanceEntity with JsonConvert<WalletBalanceEntity> {
	bool? status;
	WalletBalanceUser? user;
}

class WalletBalanceUser with JsonConvert<WalletBalanceUser> {
	String? id;
	dynamic? name;
	String? email;
	@JSONField(name: "email_token")
	String? emailToken;
	int? activated;
	dynamic? phone;
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
	dynamic? oauthToken;
	List<WalletBalanceUserUserCoins>? userCoins;
}

class WalletBalanceUserUserCoins with JsonConvert<WalletBalanceUserUserCoins> {
	String? id;
	String? userId;
	String? coinId;
	int? balance;
	WalletBalanceUserUserCoinsCoinTypes? coinTypes;
}

class WalletBalanceUserUserCoinsCoinTypes with JsonConvert<WalletBalanceUserUserCoinsCoinTypes> {
	String? id;
	String? name;
	String? symbol;
	int? rate;
	int? dollarRate;
	int? charge;
	int? maxWithdrawal;
	String? image;
}
