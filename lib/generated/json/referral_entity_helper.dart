import 'package:pay_buy_max/models/referral/referral_entity.dart';

referralEntityFromJson(ReferralEntity data, Map<String, dynamic> json) {
	if (json['status'] != null) {
		data.status = json['status'];
	}
	if (json['referrals'] != null) {
		data.referrals = (json['referrals'] as List).map((v) => ReferralReferrals().fromJson(v)).toList();
	}
	return data;
}

Map<String, dynamic> referralEntityToJson(ReferralEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['status'] = entity.status;
	data['referrals'] =  entity.referrals?.map((v) => v.toJson())?.toList();
	return data;
}

referralReferralsFromJson(ReferralReferrals data, Map<String, dynamic> json) {
	if (json['id'] != null) {
		data.id = json['id'].toString();
	}
	if (json['referral_id'] != null) {
		data.referralId = json['referral_id'].toString();
	}
	if (json['user_id'] != null) {
		data.userId = json['user_id'].toString();
	}
	if (json['haveCollectedBonus'] != null) {
		data.haveCollectedBonus = json['haveCollectedBonus'];
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
		data.user = ReferralReferralsUser().fromJson(json['user']);
	}
	return data;
}

Map<String, dynamic> referralReferralsToJson(ReferralReferrals entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['referral_id'] = entity.referralId;
	data['user_id'] = entity.userId;
	data['haveCollectedBonus'] = entity.haveCollectedBonus;
	data['createdAt'] = entity.createdAt;
	data['updatedAt'] = entity.updatedAt;
	data['deletedAt'] = entity.deletedAt;
	data['user'] = entity.user?.toJson();
	return data;
}

referralReferralsUserFromJson(ReferralReferralsUser data, Map<String, dynamic> json) {
	if (json['email'] != null) {
		data.email = json['email'].toString();
	}
	if (json['name'] != null) {
		data.name = json['name'].toString();
	}
	if (json['id'] != null) {
		data.id = json['id'].toString();
	}
	return data;
}

Map<String, dynamic> referralReferralsUserToJson(ReferralReferralsUser entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['email'] = entity.email;
	data['name'] = entity.name;
	data['id'] = entity.id;
	return data;
}