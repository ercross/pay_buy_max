import 'package:pay_buy_max/generated/json/base/json_convert_content.dart';

class AdminMessagesEntity with JsonConvert<AdminMessagesEntity> {
	bool? status;
	List<AdminMessagesMessages>? messages;
}

class AdminMessagesMessages with JsonConvert<AdminMessagesMessages> {
	String? id;
	String? adminId;
	String? title;
	String? message;
	String? expiredAt;
	String? createdAt;
	String? updatedAt;
	dynamic? deletedAt;
}
