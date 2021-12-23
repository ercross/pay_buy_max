import 'package:pay_buy_max/models/wallet/fund_wallet_entity.dart';

fundWalletEntityFromJson(FundWalletEntity data, Map<String, dynamic> json) {
	if (json['status'] != null) {
		data.status = json['status'];
	}
	if (json['message'] != null) {
		data.message = json['message'].toString();
	}
	return data;
}

Map<String, dynamic> fundWalletEntityToJson(FundWalletEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['status'] = entity.status;
	data['message'] = entity.message;
	return data;
}