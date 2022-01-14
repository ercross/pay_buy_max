import 'package:pay_buy_max/models/invest/investment_history_entity.dart';

investmentHistoryEntityFromJson(InvestmentHistoryEntity data, Map<String, dynamic> json) {
	if (json['success'] != null) {
		data.success = json['success'];
	}
	if (json['investments'] != null) {
		data.investments = (json['investments'] as List).map((v) => InvestmentHistoryInvestments().fromJson(v)).toList();
	}
	if (json['totalEarned'] != null) {
		data.totalEarned = json['totalEarned'] is String
				? int.tryParse(json['totalEarned'])
				: json['totalEarned'].toInt();
	}
	return data;
}

Map<String, dynamic> investmentHistoryEntityToJson(InvestmentHistoryEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['success'] = entity.success;
	data['investments'] =  entity.investments?.map((v) => v.toJson())?.toList();
	data['totalEarned'] = entity.totalEarned;
	return data;
}

investmentHistoryInvestmentsFromJson(InvestmentHistoryInvestments data, Map<String, dynamic> json) {
	if (json['id'] != null) {
		data.id = json['id'].toString();
	}
	if (json['user_id'] != null) {
		data.userId = json['user_id'].toString();
	}
	if (json['package_id'] != null) {
		data.packageId = json['package_id'].toString();
	}
	if (json['status'] != null) {
		data.status = json['status'].toString();
	}
	if (json['amount'] != null) {
		data.amount = json['amount'] is String
				? int.tryParse(json['amount'])
				: json['amount'].toInt();
	}
	if (json['earning'] != null) {
		data.earning = json['earning'] is String
				? int.tryParse(json['earning'])
				: json['earning'].toInt();
	}
	if (json['duration'] != null) {
		data.duration = json['duration'] is String
				? int.tryParse(json['duration'])
				: json['duration'].toInt();
	}
	if (json['weeklyEarning'] != null) {
		data.weeklyEarning = json['weeklyEarning'] is String
				? int.tryParse(json['weeklyEarning'])
				: json['weeklyEarning'].toInt();
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
	if (json['package'] != null) {
		data.package = InvestmentHistoryInvestmentsPackage().fromJson(json['package']);
	}
	return data;
}

Map<String, dynamic> investmentHistoryInvestmentsToJson(InvestmentHistoryInvestments entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['user_id'] = entity.userId;
	data['package_id'] = entity.packageId;
	data['status'] = entity.status;
	data['amount'] = entity.amount;
	data['earning'] = entity.earning;
	data['duration'] = entity.duration;
	data['weeklyEarning'] = entity.weeklyEarning;
	data['expiredAt'] = entity.expiredAt;
	data['createdAt'] = entity.createdAt;
	data['updatedAt'] = entity.updatedAt;
	data['deletedAt'] = entity.deletedAt;
	data['package'] = entity.package?.toJson();
	return data;
}

investmentHistoryInvestmentsPackageFromJson(InvestmentHistoryInvestmentsPackage data, Map<String, dynamic> json) {
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

Map<String, dynamic> investmentHistoryInvestmentsPackageToJson(InvestmentHistoryInvestmentsPackage entity) {
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