import 'package:pay_buy_max/generated/json/base/json_convert_content.dart';

class InvestmentListEntity with JsonConvert<InvestmentListEntity> {
	bool? status;
	List<InvestmentListPackages>? packages;
}

class InvestmentListPackages with JsonConvert<InvestmentListPackages> {
	String? id;
	String? name;
	int? fromPrice;
	int? toPrice;
	int? commission;
	int? duration;
	int? charge;
	String? bonus;
	String? createdAt;
	String? updatedAt;
	dynamic? deletedAt;
}
