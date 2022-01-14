import 'package:pay_buy_max/models/wallet/code_response_entity.dart';

codeResponseEntityFromJson(CodeResponseEntity data, Map<String, dynamic> json) {
	if (json['success'] != null) {
		data.success = json['success'];
	}
	if (json['msg'] != null) {
		data.msg = json['msg'].toString();
	}
	return data;
}

Map<String, dynamic> codeResponseEntityToJson(CodeResponseEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['success'] = entity.success;
	data['msg'] = entity.msg;
	return data;
}