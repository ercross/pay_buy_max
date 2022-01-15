import 'package:pay_buy_max/generated/json/base/json_convert_content.dart';
import 'package:pay_buy_max/generated/json/base/json_field.dart';

class BankListEntity with JsonConvert<BankListEntity> {
	bool? status;
	String? message;
	List<BankListData>? data;
}

class BankListData with JsonConvert<BankListData> {
	String? name;
	String? slug;
	String? code;
	String? longcode;
	String? gateway;
	@JSONField(name: "pay_with_bank")
	bool? payWithBank;
	bool? active;
	@JSONField(name: "is_deleted")
	bool? isDeleted;
	String? country;
	String? currency;
	String? type;
	int? id;
	String? createdAt;
	String? updatedAt;
}
