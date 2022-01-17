import 'package:pay_buy_max/generated/json/base/json_convert_content.dart';
import 'package:pay_buy_max/generated/json/base/json_field.dart';

class NairaWithdrawalHistoryEntity with JsonConvert<NairaWithdrawalHistoryEntity> {
	bool? status;
	List<NairaWithdrawalHistoryWithdrawals>? withdrawals;
}

class NairaWithdrawalHistoryWithdrawals with JsonConvert<NairaWithdrawalHistoryWithdrawals> {
	String? id;
	@JSONField(name: "user_id")
	String? userId;
	int? amount;
	int? charge;
	@JSONField(name: "acct_name")
	String? acctName;
	@JSONField(name: "acct_number")
	String? acctNumber;
	@JSONField(name: "bank_name")
	String? bankName;
	@JSONField(name: "bank_code")
	String? bankCode;
	dynamic? reference;
	@JSONField(name: "recipient_code")
	String? recipientCode;
	@JSONField(name: "transfer_code")
	dynamic? transferCode;
	String? status;
	String? meta;
	dynamic? fileDoc;
	String? createdAt;
	String? updatedAt;
	dynamic? deletedAt;
}
