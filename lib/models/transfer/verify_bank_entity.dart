import 'package:pay_buy_max/generated/json/base/json_convert_content.dart';
import 'package:pay_buy_max/generated/json/base/json_field.dart';

class VerifyBankEntity with JsonConvert<VerifyBankEntity> {
	bool? status;
	String? message;
	VerifyBankData? data;
}

class VerifyBankData with JsonConvert<VerifyBankData> {
	@JSONField(name: "account_number")
	String? accountNumber;
	@JSONField(name: "account_name")
	String? accountName;
	@JSONField(name: "bank_id")
	int? bankId;
}
