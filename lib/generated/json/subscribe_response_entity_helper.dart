import 'package:pay_buy_max/models/wallet/subscribe_response_entity.dart';

subscribeResponseEntityFromJson(SubscribeResponseEntity data, Map<String, dynamic> json) {
	if (json['success'] != null) {
		data.success = json['success'];
	}
	if (json['message'] != null) {
		data.message = json['message'].toString();
	}
	return data;
}

Map<String, dynamic> subscribeResponseEntityToJson(SubscribeResponseEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['success'] = entity.success;
	data['message'] = entity.message;
	return data;
}