import 'package:pay_buy_max/models/auth/sign_up_response_entity.dart';

signUpResponseEntityFromJson(SignUpResponseEntity data, Map<String, dynamic> json) {
	if (json['status'] != null) {
		data.status = json['status'];
	}
	if (json['message'] != null) {
		data.message = json['message'].toString();
	}
	return data;
}

Map<String, dynamic> signUpResponseEntityToJson(SignUpResponseEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['status'] = entity.status;
	data['message'] = entity.message;
	return data;
}