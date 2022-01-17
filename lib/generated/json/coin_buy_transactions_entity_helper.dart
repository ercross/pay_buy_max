import 'package:pay_buy_max/models/history/coin_buy_transactions_entity.dart';

coinBuyTransactionsEntityFromJson(CoinBuyTransactionsEntity data, Map<String, dynamic> json) {
	if (json['status'] != null) {
		data.status = json['status'];
	}
	if (json['transactions'] != null) {
		data.transactions = (json['transactions'] as List).map((v) => CoinBuyTransactionsTransactions().fromJson(v)).toList();
	}
	return data;
}

Map<String, dynamic> coinBuyTransactionsEntityToJson(CoinBuyTransactionsEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['status'] = entity.status;
	data['transactions'] =  entity.transactions?.map((v) => v.toJson())?.toList();
	return data;
}

coinBuyTransactionsTransactionsFromJson(CoinBuyTransactionsTransactions data, Map<String, dynamic> json) {
	if (json['id'] != null) {
		data.id = json['id'].toString();
	}
	if (json['userId'] != null) {
		data.userId = json['userId'].toString();
	}
	if (json['customerName'] != null) {
		data.customerName = json['customerName'].toString();
	}
	if (json['customerEmail'] != null) {
		data.customerEmail = json['customerEmail'].toString();
	}
	if (json['coinId'] != null) {
		data.coinId = json['coinId'].toString();
	}
	if (json['qty'] != null) {
		data.qty = json['qty'] is String
				? double.tryParse(json['qty'])
				: json['qty'].toDouble();
	}
	if (json['dollarAmount'] != null) {
		data.dollarAmount = json['dollarAmount'] is String
				? int.tryParse(json['dollarAmount'])
				: json['dollarAmount'].toInt();
	}
	if (json['nairaAmount'] != null) {
		data.nairaAmount = json['nairaAmount'] is String
				? int.tryParse(json['nairaAmount'])
				: json['nairaAmount'].toInt();
	}
	if (json['medium'] != null) {
		data.medium = json['medium'].toString();
	}
	if (json['exchange'] != null) {
		data.exchange = json['exchange'].toString();
	}
	if (json['reference'] != null) {
		data.reference = json['reference'].toString();
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
	if (json['coin'] != null) {
		data.coin = CoinBuyTransactionsTransactionsCoin().fromJson(json['coin']);
	}
	if (json['user'] != null) {
		data.user = CoinBuyTransactionsTransactionsUser().fromJson(json['user']);
	}
	return data;
}

Map<String, dynamic> coinBuyTransactionsTransactionsToJson(CoinBuyTransactionsTransactions entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['userId'] = entity.userId;
	data['customerName'] = entity.customerName;
	data['customerEmail'] = entity.customerEmail;
	data['coinId'] = entity.coinId;
	data['qty'] = entity.qty;
	data['dollarAmount'] = entity.dollarAmount;
	data['nairaAmount'] = entity.nairaAmount;
	data['medium'] = entity.medium;
	data['exchange'] = entity.exchange;
	data['reference'] = entity.reference;
	data['createdAt'] = entity.createdAt;
	data['updatedAt'] = entity.updatedAt;
	data['deletedAt'] = entity.deletedAt;
	data['coin'] = entity.coin?.toJson();
	data['user'] = entity.user?.toJson();
	return data;
}

coinBuyTransactionsTransactionsCoinFromJson(CoinBuyTransactionsTransactionsCoin data, Map<String, dynamic> json) {
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
				? double.tryParse(json['dollarRate'])
				: json['dollarRate'].toDouble();
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

Map<String, dynamic> coinBuyTransactionsTransactionsCoinToJson(CoinBuyTransactionsTransactionsCoin entity) {
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

coinBuyTransactionsTransactionsUserFromJson(CoinBuyTransactionsTransactionsUser data, Map<String, dynamic> json) {
	if (json['id'] != null) {
		data.id = json['id'].toString();
	}
	if (json['name'] != null) {
		data.name = json['name'].toString();
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
		data.phone = json['phone'].toString();
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
		data.oauthToken = json['oauth_token'].toString();
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

Map<String, dynamic> coinBuyTransactionsTransactionsUserToJson(CoinBuyTransactionsTransactionsUser entity) {
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
	data['createdAt'] = entity.createdAt;
	data['updatedAt'] = entity.updatedAt;
	data['deletedAt'] = entity.deletedAt;
	return data;
}