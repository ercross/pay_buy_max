import 'package:pay_buy_max/models/history/deposit_history_entity.dart';

depositHistoryEntityFromJson(DepositHistoryEntity data, Map<String, dynamic> json) {
	if (json['status'] != null) {
		data.status = json['status'];
	}
	if (json['deposits'] != null) {
		data.deposits = (json['deposits'] as List).map((v) => DepositHistoryDeposits().fromJson(v)).toList();
	}
	return data;
}

Map<String, dynamic> depositHistoryEntityToJson(DepositHistoryEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['status'] = entity.status;
	data['deposits'] =  entity.deposits?.map((v) => v.toJson())?.toList();
	return data;
}

depositHistoryDepositsFromJson(DepositHistoryDeposits data, Map<String, dynamic> json) {
	if (json['id'] != null) {
		data.id = json['id'].toString();
	}
	if (json['user_id'] != null) {
		data.userId = json['user_id'].toString();
	}
	if (json['amount'] != null) {
		data.amount = json['amount'] is String
				? int.tryParse(json['amount'])
				: json['amount'].toInt();
	}
	if (json['reference'] != null) {
		data.reference = json['reference'].toString();
	}
	if (json['channel'] != null) {
		data.channel = json['channel'].toString();
	}
	if (json['currency'] != null) {
		data.currency = json['currency'].toString();
	}
	if (json['walletAddress'] != null) {
		data.walletAddress = json['walletAddress'];
	}
	if (json['status'] != null) {
		data.status = json['status'].toString();
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

Map<String, dynamic> depositHistoryDepositsToJson(DepositHistoryDeposits entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['user_id'] = entity.userId;
	data['amount'] = entity.amount;
	data['reference'] = entity.reference;
	data['channel'] = entity.channel;
	data['currency'] = entity.currency;
	data['walletAddress'] = entity.walletAddress;
	data['status'] = entity.status;
	data['createdAt'] = entity.createdAt;
	data['updatedAt'] = entity.updatedAt;
	data['deletedAt'] = entity.deletedAt;
	return data;
}