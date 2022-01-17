import 'package:pay_buy_max/models/transfer/withdraw_naira_entity.dart';

withdrawNairaEntityFromJson(WithdrawNairaEntity data, Map<String, dynamic> json) {
	if (json['status'] != null) {
		data.status = json['status'];
	}
	if (json['message'] != null) {
		data.message = json['message'].toString();
	}
	return data;
}

Map<String, dynamic> withdrawNairaEntityToJson(WithdrawNairaEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['status'] = entity.status;
	data['message'] = entity.message;
	return data;
}