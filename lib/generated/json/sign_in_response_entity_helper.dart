import 'package:pay_buy_max/models/auth/sign_in_response_entity.dart';

signInResponseEntityFromJson(SignInResponseEntity data, Map<String, dynamic> json) {
	if (json['status'] != null) {
		data.status = json['status'];
	}
	if (json['token'] != null) {
		data.token = json['token'].toString();
	}
	if (json['user'] != null) {
		data.user = SignInResponseUser().fromJson(json['user']);
	}
	if (json['message'] != null) {
		data.message = json['message'].toString();
	}
	return data;
}

Map<String, dynamic> signInResponseEntityToJson(SignInResponseEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['status'] = entity.status;
	data['token'] = entity.token;
	data['user'] = entity.user?.toJson();
	data['message'] = entity.message;
	return data;
}

signInResponseUserFromJson(SignInResponseUser data, Map<String, dynamic> json) {
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
	return data;
}

Map<String, dynamic> signInResponseUserToJson(SignInResponseUser entity) {
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
	return data;
}