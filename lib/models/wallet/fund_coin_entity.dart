import 'package:pay_buy_max/generated/json/base/json_convert_content.dart';

class FundCoinEntity with JsonConvert<FundCoinEntity> {
	bool? success;
	FundCoinData? data;
	String? currency;
	FundCoinProduct? product;
}

class FundCoinData with JsonConvert<FundCoinData> {
	String? message;
}

class FundCoinProduct with JsonConvert<FundCoinProduct> {
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
