import 'package:pay_buy_max/models/history/naira_withdrawal_history_entity.dart';

nairaWithdrawalHistoryEntityFromJson(NairaWithdrawalHistoryEntity data, Map<String, dynamic> json) {
	if (json['status'] != null) {
		data.status = json['status'];
	}
	if (json['withdrawals'] != null) {
		data.withdrawals = (json['withdrawals'] as List).map((v) => NairaWithdrawalHistoryWithdrawals().fromJson(v)).toList();
	}
	return data;
}

Map<String, dynamic> nairaWithdrawalHistoryEntityToJson(NairaWithdrawalHistoryEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['status'] = entity.status;
	data['withdrawals'] =  entity.withdrawals?.map((v) => v.toJson())?.toList();
	return data;
}

nairaWithdrawalHistoryWithdrawalsFromJson(NairaWithdrawalHistoryWithdrawals data, Map<String, dynamic> json) {
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
	if (json['charge'] != null) {
		data.charge = json['charge'] is String
				? int.tryParse(json['charge'])
				: json['charge'].toInt();
	}
	if (json['acct_name'] != null) {
		data.acctName = json['acct_name'].toString();
	}
	if (json['acct_number'] != null) {
		data.acctNumber = json['acct_number'].toString();
	}
	if (json['bank_name'] != null) {
		data.bankName = json['bank_name'].toString();
	}
	if (json['bank_code'] != null) {
		data.bankCode = json['bank_code'].toString();
	}
	if (json['reference'] != null) {
		data.reference = json['reference'];
	}
	if (json['recipient_code'] != null) {
		data.recipientCode = json['recipient_code'].toString();
	}
	if (json['transfer_code'] != null) {
		data.transferCode = json['transfer_code'];
	}
	if (json['status'] != null) {
		data.status = json['status'].toString();
	}
	if (json['meta'] != null) {
		data.meta = json['meta'].toString();
	}
	if (json['fileDoc'] != null) {
		data.fileDoc = json['fileDoc'];
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

Map<String, dynamic> nairaWithdrawalHistoryWithdrawalsToJson(NairaWithdrawalHistoryWithdrawals entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['user_id'] = entity.userId;
	data['amount'] = entity.amount;
	data['charge'] = entity.charge;
	data['acct_name'] = entity.acctName;
	data['acct_number'] = entity.acctNumber;
	data['bank_name'] = entity.bankName;
	data['bank_code'] = entity.bankCode;
	data['reference'] = entity.reference;
	data['recipient_code'] = entity.recipientCode;
	data['transfer_code'] = entity.transferCode;
	data['status'] = entity.status;
	data['meta'] = entity.meta;
	data['fileDoc'] = entity.fileDoc;
	data['createdAt'] = entity.createdAt;
	data['updatedAt'] = entity.updatedAt;
	data['deletedAt'] = entity.deletedAt;
	return data;
}