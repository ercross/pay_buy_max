import 'package:pay_buy_max/models/transfer/verify_bank_entity.dart';

verifyBankEntityFromJson(VerifyBankEntity data, Map<String, dynamic> json) {
	if (json['status'] != null) {
		data.status = json['status'];
	}
	if (json['message'] != null) {
		data.message = json['message'].toString();
	}
	if (json['data'] != null) {
		data.data = VerifyBankData().fromJson(json['data']);
	}
	return data;
}

Map<String, dynamic> verifyBankEntityToJson(VerifyBankEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['status'] = entity.status;
	data['message'] = entity.message;
	data['data'] = entity.data?.toJson();
	return data;
}

verifyBankDataFromJson(VerifyBankData data, Map<String, dynamic> json) {
	if (json['account_number'] != null) {
		data.accountNumber = json['account_number'].toString();
	}
	if (json['account_name'] != null) {
		data.accountName = json['account_name'].toString();
	}
	if (json['bank_id'] != null) {
		data.bankId = json['bank_id'] is String
				? int.tryParse(json['bank_id'])
				: json['bank_id'].toInt();
	}
	return data;
}

Map<String, dynamic> verifyBankDataToJson(VerifyBankData entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['account_number'] = entity.accountNumber;
	data['account_name'] = entity.accountName;
	data['bank_id'] = entity.bankId;
	return data;
}