import 'package:pay_buy_max/models/invest/investment_list_entity.dart';

investmentListEntityFromJson(InvestmentListEntity data, Map<String, dynamic> json) {
	if (json['status'] != null) {
		data.status = json['status'];
	}
	if (json['packages'] != null) {
		data.packages = (json['packages'] as List).map((v) => InvestmentListPackages().fromJson(v)).toList();
	}
	return data;
}

Map<String, dynamic> investmentListEntityToJson(InvestmentListEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['status'] = entity.status;
	data['packages'] =  entity.packages?.map((v) => v.toJson())?.toList();
	return data;
}

investmentListPackagesFromJson(InvestmentListPackages data, Map<String, dynamic> json) {
	if (json['id'] != null) {
		data.id = json['id'].toString();
	}
	if (json['name'] != null) {
		data.name = json['name'].toString();
	}
	if (json['fromPrice'] != null) {
		data.fromPrice = json['fromPrice'] is String
				? int.tryParse(json['fromPrice'])
				: json['fromPrice'].toInt();
	}
	if (json['toPrice'] != null) {
		data.toPrice = json['toPrice'] is String
				? int.tryParse(json['toPrice'])
				: json['toPrice'].toInt();
	}
	if (json['commission'] != null) {
		data.commission = json['commission'] is String
				? int.tryParse(json['commission'])
				: json['commission'].toInt();
	}
	if (json['duration'] != null) {
		data.duration = json['duration'] is String
				? int.tryParse(json['duration'])
				: json['duration'].toInt();
	}
	if (json['charge'] != null) {
		data.charge = json['charge'] is String
				? int.tryParse(json['charge'])
				: json['charge'].toInt();
	}
	if (json['bonus'] != null) {
		data.bonus = json['bonus'].toString();
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

Map<String, dynamic> investmentListPackagesToJson(InvestmentListPackages entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['name'] = entity.name;
	data['fromPrice'] = entity.fromPrice;
	data['toPrice'] = entity.toPrice;
	data['commission'] = entity.commission;
	data['duration'] = entity.duration;
	data['charge'] = entity.charge;
	data['bonus'] = entity.bonus;
	data['createdAt'] = entity.createdAt;
	data['updatedAt'] = entity.updatedAt;
	data['deletedAt'] = entity.deletedAt;
	return data;
}