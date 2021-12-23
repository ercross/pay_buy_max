import 'package:pay_buy_max/models/wallet/user_entity.dart';

userEntityFromJson(UserEntity data, Map<String, dynamic> json) {
	if (json['status'] != null) {
		data.status = json['status'];
	}
	if (json['user'] != null) {
		data.user = UserUser().fromJson(json['user']);
	}
	return data;
}

Map<String, dynamic> userEntityToJson(UserEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['status'] = entity.status;
	data['user'] = entity.user?.toJson();
	return data;
}

userUserFromJson(UserUser data, Map<String, dynamic> json) {
	if (json['id'] != null) {
		data.id = json['id'].toString();
	}
	if (json['name'] != null) {
		data.name = json['name'];
	}
	if (json['email'] != null) {
		data.email = json['email'].toString();
	}
	if (json['email_token'] != null) {
		data.emailToken = json['email_token'].toString();
	}
	if (json['activated'] != null) {
		data.activated = json['activated'] is String
				? int.tryParse(json['activated'])
				: json['activated'].toInt();
	}
	if (json['phone'] != null) {
		data.phone = json['phone'];
	}
	if (json['mining'] != null) {
		data.mining = json['mining'];
	}
	if (json['wallet'] != null) {
		data.wallet = json['wallet'] is String
				? int.tryParse(json['wallet'])
				: json['wallet'].toInt();
	}
	if (json['revenue'] != null) {
		data.revenue = json['revenue'] is String
				? int.tryParse(json['revenue'])
				: json['revenue'].toInt();
	}
	if (json['walletAddress'] != null) {
		data.walletAddress = json['walletAddress'];
	}
	if (json['referral_count'] != null) {
		data.referralCount = json['referral_count'] is String
				? int.tryParse(json['referral_count'])
				: json['referral_count'].toInt();
	}
	if (json['referral_amount'] != null) {
		data.referralAmount = json['referral_amount'] is String
				? int.tryParse(json['referral_amount'])
				: json['referral_amount'].toInt();
	}
	if (json['password'] != null) {
		data.password = json['password'].toString();
	}
	if (json['reference'] != null) {
		data.reference = json['reference'].toString();
	}
	if (json['referral_id'] != null) {
		data.referralId = json['referral_id'];
	}
	if (json['oauth_id'] != null) {
		data.oauthId = json['oauth_id'];
	}
	if (json['oauth_token'] != null) {
		data.oauthToken = json['oauth_token'];
	}
	if (json['userCoins'] != null) {
		data.userCoins = (json['userCoins'] as List).map((v) => UserUserUserCoins().fromJson(v)).toList();
	}
	return data;
}

Map<String, dynamic> userUserToJson(UserUser entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['name'] = entity.name;
	data['email'] = entity.email;
	data['email_token'] = entity.emailToken;
	data['activated'] = entity.activated;
	data['phone'] = entity.phone;
	data['mining'] = entity.mining;
	data['wallet'] = entity.wallet;
	data['revenue'] = entity.revenue;
	data['walletAddress'] = entity.walletAddress;
	data['referral_count'] = entity.referralCount;
	data['referral_amount'] = entity.referralAmount;
	data['password'] = entity.password;
	data['reference'] = entity.reference;
	data['referral_id'] = entity.referralId;
	data['oauth_id'] = entity.oauthId;
	data['oauth_token'] = entity.oauthToken;
	data['userCoins'] =  entity.userCoins?.map((v) => v.toJson())?.toList();
	return data;
}

userUserUserCoinsFromJson(UserUserUserCoins data, Map<String, dynamic> json) {
	if (json['id'] != null) {
		data.id = json['id'].toString();
	}
	if (json['userId'] != null) {
		data.userId = json['userId'].toString();
	}
	if (json['coinId'] != null) {
		data.coinId = json['coinId'].toString();
	}
	if (json['balance'] != null) {
		data.balance = json['balance'] is String
				? int.tryParse(json['balance'])
				: json['balance'].toInt();
	}
	if (json['coinTypes'] != null) {
		data.coinTypes = UserUserUserCoinsCoinTypes().fromJson(json['coinTypes']);
	}
	return data;
}

Map<String, dynamic> userUserUserCoinsToJson(UserUserUserCoins entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['userId'] = entity.userId;
	data['coinId'] = entity.coinId;
	data['balance'] = entity.balance;
	data['coinTypes'] = entity.coinTypes?.toJson();
	return data;
}

userUserUserCoinsCoinTypesFromJson(UserUserUserCoinsCoinTypes data, Map<String, dynamic> json) {
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
	return data;
}

Map<String, dynamic> userUserUserCoinsCoinTypesToJson(UserUserUserCoinsCoinTypes entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['name'] = entity.name;
	data['symbol'] = entity.symbol;
	data['rate'] = entity.rate;
	data['dollarRate'] = entity.dollarRate;
	data['charge'] = entity.charge;
	data['maxWithdrawal'] = entity.maxWithdrawal;
	data['image'] = entity.image;
	return data;
}