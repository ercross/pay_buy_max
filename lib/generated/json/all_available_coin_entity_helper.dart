import 'package:pay_buy_max/models/wallet/all_available_coin_entity.dart';

allAvailableCoinEntityFromJson(AllAvailableCoinEntity data, Map<String, dynamic> json) {
	if (json['status'] != null) {
		data.status = json['status'];
	}
	if (json['products'] != null) {
		data.products = (json['products'] as List).map((v) => AllAvailableCoinProducts().fromJson(v)).toList();
	}
	return data;
}

Map<String, dynamic> allAvailableCoinEntityToJson(AllAvailableCoinEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['status'] = entity.status;
	data['products'] =  entity.products?.map((v) => v.toJson())?.toList();
	return data;
}

allAvailableCoinProductsFromJson(AllAvailableCoinProducts data, Map<String, dynamic> json) {
	if (json['id'] != null) {
		data.id = json['id'].toString();
	}
	if (json['name'] != null) {
		data.name = json['name'].toString();
	}
	if (json['symbol'] != null) {
		data.symbol = json['symbol'].toString();
	}
	if (json['rate'] != null) {
		data.rate = json['rate'] is String
				? int.tryParse(json['rate'])
				: json['rate'].toInt();
	}
	if (json['dollarRate'] != null) {
		data.dollarRate = json['dollarRate'] is String
				? int.tryParse(json['dollarRate'])
				: json['dollarRate'].toInt();
	}
	if (json['charge'] != null) {
		data.charge = json['charge'] is String
				? int.tryParse(json['charge'])
				: json['charge'].toInt();
	}
	if (json['maxWithdrawal'] != null) {
		data.maxWithdrawal = json['maxWithdrawal'] is String
				? int.tryParse(json['maxWithdrawal'])
				: json['maxWithdrawal'].toInt();
	}
	if (json['image'] != null) {
		data.image = json['image'].toString();
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

Map<String, dynamic> allAvailableCoinProductsToJson(AllAvailableCoinProducts entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['name'] = entity.name;
	data['symbol'] = entity.symbol;
	data['rate'] = entity.rate;
	data['dollarRate'] = entity.dollarRate;
	data['charge'] = entity.charge;
	data['maxWithdrawal'] = entity.maxWithdrawal;
	data['image'] = entity.image;
	data['createdAt'] = entity.createdAt;
	data['updatedAt'] = entity.updatedAt;
	data['deletedAt'] = entity.deletedAt;
	return data;
}