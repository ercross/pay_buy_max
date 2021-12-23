import 'package:pay_buy_max/generated/json/base/json_convert_content.dart';

class AllAvailableCoinEntity with JsonConvert<AllAvailableCoinEntity> {
	bool? status;
	List<AllAvailableCoinProducts>? products;
}

class AllAvailableCoinProducts with JsonConvert<AllAvailableCoinProducts> {
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
