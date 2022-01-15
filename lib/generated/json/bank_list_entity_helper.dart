import 'package:pay_buy_max/models/transfer/bank_list_entity.dart';

bankListEntityFromJson(BankListEntity data, Map<String, dynamic> json) {
	if (json['status'] != null) {
		data.status = json['status'];
	}
	if (json['message'] != null) {
		data.message = json['message'].toString();
	}
	if (json['data'] != null) {
		data.data = (json['data'] as List).map((v) => BankListData().fromJson(v)).toList();
	}
	return data;
}

Map<String, dynamic> bankListEntityToJson(BankListEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['status'] = entity.status;
	data['message'] = entity.message;
	data['data'] =  entity.data?.map((v) => v.toJson())?.toList();
	return data;
}

bankListDataFromJson(BankListData data, Map<String, dynamic> json) {
	if (json['name'] != null) {
		data.name = json['name'].toString();
	}
	if (json['slug'] != null) {
		data.slug = json['slug'].toString();
	}
	if (json['code'] != null) {
		data.code = json['code'].toString();
	}
	if (json['longcode'] != null) {
		data.longcode = json['longcode'].toString();
	}
	if (json['gateway'] != null) {
		data.gateway = json['gateway'].toString();
	}
	if (json['pay_with_bank'] != null) {
		data.payWithBank = json['pay_with_bank'];
	}
	if (json['active'] != null) {
		data.active = json['active'];
	}
	if (json['is_deleted'] != null) {
		data.isDeleted = json['is_deleted'];
	}
	if (json['country'] != null) {
		data.country = json['country'].toString();
	}
	if (json['currency'] != null) {
		data.currency = json['currency'].toString();
	}
	if (json['type'] != null) {
		data.type = json['type'].toString();
	}
	if (json['id'] != null) {
		data.id = json['id'] is String
				? int.tryParse(json['id'])
				: json['id'].toInt();
	}
	if (json['createdAt'] != null) {
		data.createdAt = json['createdAt'].toString();
	}
	if (json['updatedAt'] != null) {
		data.updatedAt = json['updatedAt'].toString();
	}
	return data;
}

Map<String, dynamic> bankListDataToJson(BankListData entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['name'] = entity.name;
	data['slug'] = entity.slug;
	data['code'] = entity.code;
	data['longcode'] = entity.longcode;
	data['gateway'] = entity.gateway;
	data['pay_with_bank'] = entity.payWithBank;
	data['active'] = entity.active;
	data['is_deleted'] = entity.isDeleted;
	data['country'] = entity.country;
	data['currency'] = entity.currency;
	data['type'] = entity.type;
	data['id'] = entity.id;
	data['createdAt'] = entity.createdAt;
	data['updatedAt'] = entity.updatedAt;
	return data;
}