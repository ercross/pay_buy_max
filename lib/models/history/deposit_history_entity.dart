import 'package:pay_buy_max/generated/json/base/json_convert_content.dart';
import 'package:pay_buy_max/generated/json/base/json_field.dart';

class DepositHistoryEntity with JsonConvert<DepositHistoryEntity> {
	bool? status;
	List<DepositHistoryDeposits>? deposits;
}

class DepositHistoryDeposits with JsonConvert<DepositHistoryDeposits> {
	String? id;
	@JSONField(name: "user_id")
	String? userId;
	int? amount;
	String? reference;
	String? channel;
	String? currency;
	dynamic? walletAddress;
	String? status;
	String? createdAt;
	String? updatedAt;
	dynamic? deletedAt;
}
