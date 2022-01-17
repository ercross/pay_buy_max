import 'package:pay_buy_max/generated/json/base/json_convert_content.dart';

class NotificationsEntity with JsonConvert<NotificationsEntity> {
	bool? status;
	List<NotificationsNotifications>? notifications;
}

class NotificationsNotifications with JsonConvert<NotificationsNotifications> {
	String? id;
	String? userId;
	String? type;
	String? message;
	bool? status;
	String? createdAt;
	String? updatedAt;
	dynamic? deletedAt;
	NotificationsNotificationsUser? user;
}

class NotificationsNotificationsUser with JsonConvert<NotificationsNotificationsUser> {
	String? id;
	dynamic? name;
}
