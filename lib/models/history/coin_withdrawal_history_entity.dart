import 'package:pay_buy_max/generated/json/base/json_convert_content.dart';
import 'package:pay_buy_max/generated/json/base/json_field.dart';

class CoinWithdrawalHistoryEntity with JsonConvert<CoinWithdrawalHistoryEntity> {
	bool? status;
	List<CoinWithdrawalHistoryHistory>? history;
}

class CoinWithdrawalHistoryHistory with JsonConvert<CoinWithdrawalHistoryHistory> {
	String? id;
	String? userId;
	String? coinId;
	double? amount;
	int? charge;
	String? walletAddress;
	String? coinType;
	String? reference;
	String? status;
	String? fileDoc;
	String? createdAt;
	String? updatedAt;
	dynamic? deletedAt;
	CoinWithdrawalHistoryHistoryUser? user;
	CoinWithdrawalHistoryHistoryCoin? coin;
}

class CoinWithdrawalHistoryHistoryUser with JsonConvert<CoinWithdrawalHistoryHistoryUser> {
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

class CoinWithdrawalHistoryHistoryCoin with JsonConvert<CoinWithdrawalHistoryHistoryCoin> {
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
