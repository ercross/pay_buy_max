import 'package:pay_buy_max/models/history/notifications_entity.dart';

notificationsEntityFromJson(NotificationsEntity data, Map<String, dynamic> json) {
	if (json['status'] != null) {
		data.status = json['status'];
	}
	if (json['notifications'] != null) {
		data.notifications = (json['notifications'] as List).map((v) => NotificationsNotifications().fromJson(v)).toList();
	}
	return data;
}

Map<String, dynamic> notificationsEntityToJson(NotificationsEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['status'] = entity.status;
	data['notifications'] =  entity.notifications?.map((v) => v.toJson())?.toList();
	return data;
}

notificationsNotificationsFromJson(NotificationsNotifications data, Map<String, dynamic> json) {
	if (json['id'] != null) {
		data.id = json['id'].toString();
	}
	if (json['userId'] != null) {
		data.userId = json['userId'].toString();
	}
	if (json['type'] != null) {
		data.type = json['type'].toString();
	}
	if (json['message'] != null) {
		data.message = json['message'].toString();
	}
	if (json['status'] != null) {
		data.status = json['status'];
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
	if (json['user'] != null) {
		data.user = NotificationsNotificationsUser().fromJson(json['user']);
	}
	return data;
}

Map<String, dynamic> notificationsNotificationsToJson(NotificationsNotifications entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['userId'] = entity.userId;
	data['type'] = entity.type;
	data['message'] = entity.message;
	data['status'] = entity.status;
	data['createdAt'] = entity.createdAt;
	data['updatedAt'] = entity.updatedAt;
	data['deletedAt'] = entity.deletedAt;
	data['user'] = entity.user?.toJson();
	return data;
}

notificationsNotificationsUserFromJson(NotificationsNotificationsUser data, Map<String, dynamic> json) {
	if (json['id'] != null) {
		data.id = json['id'].toString();
	}
	if (json['name'] != null) {
		data.name = json['name'];
	}
	return data;
}

Map<String, dynamic> notificationsNotificationsUserToJson(NotificationsNotificationsUser entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['name'] = entity.name;
	return data;
}