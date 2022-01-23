import 'package:pay_buy_max/generated/json/base/json_convert_content.dart';
import 'package:pay_buy_max/generated/json/base/json_field.dart';

class ReferralEntity with JsonConvert<ReferralEntity> {
	bool? status;
	List<ReferralReferrals>? referrals;
}

class ReferralReferrals with JsonConvert<ReferralReferrals> {
	String? id;
	@JSONField(name: "referral_id")
	String? referralId;
	@JSONField(name: "user_id")
	String? userId;
	bool? haveCollectedBonus;
	String? createdAt;
	String? updatedAt;
	dynamic? deletedAt;
	ReferralReferralsUser? user;
}

class ReferralReferralsUser with JsonConvert<ReferralReferralsUser> {
	String? email;
	String? name;
	String? id;
}
