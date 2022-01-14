import 'package:pay_buy_max/generated/json/base/json_convert_content.dart';
import 'package:pay_buy_max/generated/json/base/json_field.dart';

class InvestmentHistoryEntity with JsonConvert<InvestmentHistoryEntity> {
	bool? success;
	List<InvestmentHistoryInvestments>? investments;
	int? totalEarned;
}

class InvestmentHistoryInvestments with JsonConvert<InvestmentHistoryInvestments> {
	String? id;
	@JSONField(name: "user_id")
	String? userId;
	@JSONField(name: "package_id")
	String? packageId;
	String? status;
	int? amount;
	int? earning;
	int? duration;
	int? weeklyEarning;
	String? expiredAt;
	String? createdAt;
	String? updatedAt;
	dynamic? deletedAt;
	InvestmentHistoryInvestmentsPackage? package;
}

class InvestmentHistoryInvestmentsPackage with JsonConvert<InvestmentHistoryInvestmentsPackage> {
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
