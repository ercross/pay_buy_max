import 'package:pay_buy_max/models/messages/admin_messages_entity.dart';

adminMessagesEntityFromJson(AdminMessagesEntity data, Map<String, dynamic> json) {
	if (json['status'] != null) {
		data.status = json['status'];
	}
	if (json['messages'] != null) {
		data.messages = (json['messages'] as List).map((v) => AdminMessagesMessages().fromJson(v)).toList();
	}
	return data;
}

Map<String, dynamic> adminMessagesEntityToJson(AdminMessagesEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['status'] = entity.status;
	data['messages'] =  entity.messages?.map((v) => v.toJson())?.toList();
	return data;
}

adminMessagesMessagesFromJson(AdminMessagesMessages data, Map<String, dynamic> json) {
	if (json['id'] != null) {
		data.id = json['id'].toString();
	}
	if (json['adminId'] != null) {
		data.adminId = json['adminId'].toString();
	}
	if (json['title'] != null) {
		data.title = json['title'].toString();
	}
	if (json['message'] != null) {
		data.message = json['message'].toString();
	}
	if (json['expiredAt'] != null) {
		data.expiredAt = json['expiredAt'].toString();
	}
	if (json['createdAt'] != null) {
		data.createdAt = json['createdAt'].toString();
	}
	if (json['updatedAt'] != null) {
		data.updatedAt = json['updatedAt'].toString();
	}
	if (json['deletedAt'] != null) {
		data.deletedAt = json['deletedAt'];
	}
	return data;
}

Map<String, dynamic> adminMessagesMessagesToJson(AdminMessagesMessages entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['adminId'] = entity.adminId;
	data['title'] = entity.title;
	data['message'] = entity.message;
	data['expiredAt'] = entity.expiredAt;
	data['createdAt'] = entity.createdAt;
	data['updatedAt'] = entity.updatedAt;
	data['deletedAt'] = entity.deletedAt;
	return data;
}