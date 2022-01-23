// ignore_for_file: non_constant_identifier_names
// ignore_for_file: camel_case_types
// ignore_for_file: prefer_single_quotes

// This file is automatically generated. DO NOT EDIT, all your changes would be lost.
import 'package:pay_buy_max/models/wallet/user_entity.dart';
import 'package:pay_buy_max/generated/json/user_entity_helper.dart';
import 'package:pay_buy_max/models/history/coin_buy_transactions_entity.dart';
import 'package:pay_buy_max/generated/json/coin_buy_transactions_entity_helper.dart';
import 'package:pay_buy_max/models/history/coin_withdrawal_history_entity.dart';
import 'package:pay_buy_max/generated/json/coin_withdrawal_history_entity_helper.dart';
import 'package:pay_buy_max/models/wallet/fund_wallet_entity.dart';
import 'package:pay_buy_max/generated/json/fund_wallet_entity_helper.dart';
import 'package:pay_buy_max/models/history/coin_sell_transactions_entity.dart';
import 'package:pay_buy_max/generated/json/coin_sell_transactions_entity_helper.dart';
import 'package:pay_buy_max/models/history/deposit_history_entity.dart';
import 'package:pay_buy_max/generated/json/deposit_history_entity_helper.dart';
import 'package:pay_buy_max/models/learn/course_list_entity.dart';
import 'package:pay_buy_max/generated/json/course_list_entity_helper.dart';
import 'package:pay_buy_max/models/transfer/bank_list_entity.dart';
import 'package:pay_buy_max/generated/json/bank_list_entity_helper.dart';
import 'package:pay_buy_max/models/auth/sign_up_response_entity.dart';
import 'package:pay_buy_max/generated/json/sign_up_response_entity_helper.dart';
import 'package:pay_buy_max/models/invest/investment_history_entity.dart';
import 'package:pay_buy_max/generated/json/investment_history_entity_helper.dart';
import 'package:pay_buy_max/models/history/naira_withdrawal_history_entity.dart';
import 'package:pay_buy_max/generated/json/naira_withdrawal_history_entity_helper.dart';
import 'package:pay_buy_max/models/referral/referral_entity.dart';
import 'package:pay_buy_max/generated/json/referral_entity_helper.dart';
import 'package:pay_buy_max/models/history/notifications_entity.dart';
import 'package:pay_buy_max/generated/json/notifications_entity_helper.dart';
import 'package:pay_buy_max/models/wallet/subscribe_response_entity.dart';
import 'package:pay_buy_max/generated/json/subscribe_response_entity_helper.dart';
import 'package:pay_buy_max/models/transfer/verify_bank_entity.dart';
import 'package:pay_buy_max/generated/json/verify_bank_entity_helper.dart';
import 'package:pay_buy_max/models/wallet/fund_coin_entity.dart';
import 'package:pay_buy_max/generated/json/fund_coin_entity_helper.dart';
import 'package:pay_buy_max/models/wallet/all_available_coin_entity.dart';
import 'package:pay_buy_max/generated/json/all_available_coin_entity_helper.dart';
import 'package:pay_buy_max/models/invest/investment_list_entity.dart';
import 'package:pay_buy_max/generated/json/investment_list_entity_helper.dart';
import 'package:pay_buy_max/models/wallet/code_response_entity.dart';
import 'package:pay_buy_max/generated/json/code_response_entity_helper.dart';
import 'package:pay_buy_max/models/transfer/withdraw_coin_entity.dart';
import 'package:pay_buy_max/generated/json/withdraw_coin_entity_helper.dart';
import 'package:pay_buy_max/models/auth/sign_in_response_entity.dart';
import 'package:pay_buy_max/generated/json/sign_in_response_entity_helper.dart';
import 'package:pay_buy_max/models/wallet/wallet_balance_entity.dart';
import 'package:pay_buy_max/generated/json/wallet_balance_entity_helper.dart';
import 'package:pay_buy_max/models/transfer/withdraw_naira_entity.dart';
import 'package:pay_buy_max/generated/json/withdraw_naira_entity_helper.dart';

class JsonConvert<T> {
	T fromJson(Map<String, dynamic> json) {
		return _getFromJson<T>(runtimeType, this, json);
	}

  Map<String, dynamic> toJson() {
		return _getToJson<T>(runtimeType, this);
  }

  static _getFromJson<T>(Type type, data, json) {
		switch (type) {
			case UserEntity:
				return userEntityFromJson(data as UserEntity, json) as T;
			case UserUser:
				return userUserFromJson(data as UserUser, json) as T;
			case UserUserUserCoins:
				return userUserUserCoinsFromJson(data as UserUserUserCoins, json) as T;
			case UserUserUserCoinsCoinTypes:
				return userUserUserCoinsCoinTypesFromJson(data as UserUserUserCoinsCoinTypes, json) as T;
			case CoinBuyTransactionsEntity:
				return coinBuyTransactionsEntityFromJson(data as CoinBuyTransactionsEntity, json) as T;
			case CoinBuyTransactionsTransactions:
				return coinBuyTransactionsTransactionsFromJson(data as CoinBuyTransactionsTransactions, json) as T;
			case CoinBuyTransactionsTransactionsCoin:
				return coinBuyTransactionsTransactionsCoinFromJson(data as CoinBuyTransactionsTransactionsCoin, json) as T;
			case CoinBuyTransactionsTransactionsUser:
				return coinBuyTransactionsTransactionsUserFromJson(data as CoinBuyTransactionsTransactionsUser, json) as T;
			case CoinWithdrawalHistoryEntity:
				return coinWithdrawalHistoryEntityFromJson(data as CoinWithdrawalHistoryEntity, json) as T;
			case CoinWithdrawalHistoryHistory:
				return coinWithdrawalHistoryHistoryFromJson(data as CoinWithdrawalHistoryHistory, json) as T;
			case CoinWithdrawalHistoryHistoryUser:
				return coinWithdrawalHistoryHistoryUserFromJson(data as CoinWithdrawalHistoryHistoryUser, json) as T;
			case CoinWithdrawalHistoryHistoryCoin:
				return coinWithdrawalHistoryHistoryCoinFromJson(data as CoinWithdrawalHistoryHistoryCoin, json) as T;
			case FundWalletEntity:
				return fundWalletEntityFromJson(data as FundWalletEntity, json) as T;
			case CoinSellTransactionsEntity:
				return coinSellTransactionsEntityFromJson(data as CoinSellTransactionsEntity, json) as T;
			case CoinSellTransactionsTransactions:
				return coinSellTransactionsTransactionsFromJson(data as CoinSellTransactionsTransactions, json) as T;
			case CoinSellTransactionsTransactionsCoin:
				return coinSellTransactionsTransactionsCoinFromJson(data as CoinSellTransactionsTransactionsCoin, json) as T;
			case CoinSellTransactionsTransactionsUser:
				return coinSellTransactionsTransactionsUserFromJson(data as CoinSellTransactionsTransactionsUser, json) as T;
			case DepositHistoryEntity:
				return depositHistoryEntityFromJson(data as DepositHistoryEntity, json) as T;
			case DepositHistoryDeposits:
				return depositHistoryDepositsFromJson(data as DepositHistoryDeposits, json) as T;
			case CourseListEntity:
				return courseListEntityFromJson(data as CourseListEntity, json) as T;
			case CourseListCourses:
				return courseListCoursesFromJson(data as CourseListCourses, json) as T;
			case BankListEntity:
				return bankListEntityFromJson(data as BankListEntity, json) as T;
			case BankListData:
				return bankListDataFromJson(data as BankListData, json) as T;
			case SignUpResponseEntity:
				return signUpResponseEntityFromJson(data as SignUpResponseEntity, json) as T;
			case InvestmentHistoryEntity:
				return investmentHistoryEntityFromJson(data as InvestmentHistoryEntity, json) as T;
			case InvestmentHistoryInvestments:
				return investmentHistoryInvestmentsFromJson(data as InvestmentHistoryInvestments, json) as T;
			case InvestmentHistoryInvestmentsPackage:
				return investmentHistoryInvestmentsPackageFromJson(data as InvestmentHistoryInvestmentsPackage, json) as T;
			case NairaWithdrawalHistoryEntity:
				return nairaWithdrawalHistoryEntityFromJson(data as NairaWithdrawalHistoryEntity, json) as T;
			case NairaWithdrawalHistoryWithdrawals:
				return nairaWithdrawalHistoryWithdrawalsFromJson(data as NairaWithdrawalHistoryWithdrawals, json) as T;
			case ReferralEntity:
				return referralEntityFromJson(data as ReferralEntity, json) as T;
			case ReferralReferrals:
				return referralReferralsFromJson(data as ReferralReferrals, json) as T;
			case ReferralReferralsUser:
				return referralReferralsUserFromJson(data as ReferralReferralsUser, json) as T;
			case NotificationsEntity:
				return notificationsEntityFromJson(data as NotificationsEntity, json) as T;
			case NotificationsNotifications:
				return notificationsNotificationsFromJson(data as NotificationsNotifications, json) as T;
			case NotificationsNotificationsUser:
				return notificationsNotificationsUserFromJson(data as NotificationsNotificationsUser, json) as T;
			case SubscribeResponseEntity:
				return subscribeResponseEntityFromJson(data as SubscribeResponseEntity, json) as T;
			case VerifyBankEntity:
				return verifyBankEntityFromJson(data as VerifyBankEntity, json) as T;
			case VerifyBankData:
				return verifyBankDataFromJson(data as VerifyBankData, json) as T;
			case FundCoinEntity:
				return fundCoinEntityFromJson(data as FundCoinEntity, json) as T;
			case FundCoinData:
				return fundCoinDataFromJson(data as FundCoinData, json) as T;
			case FundCoinProduct:
				return fundCoinProductFromJson(data as FundCoinProduct, json) as T;
			case AllAvailableCoinEntity:
				return allAvailableCoinEntityFromJson(data as AllAvailableCoinEntity, json) as T;
			case AllAvailableCoinProducts:
				return allAvailableCoinProductsFromJson(data as AllAvailableCoinProducts, json) as T;
			case InvestmentListEntity:
				return investmentListEntityFromJson(data as InvestmentListEntity, json) as T;
			case InvestmentListPackages:
				return investmentListPackagesFromJson(data as InvestmentListPackages, json) as T;
			case CodeResponseEntity:
				return codeResponseEntityFromJson(data as CodeResponseEntity, json) as T;
			case WithdrawCoinEntity:
				return withdrawCoinEntityFromJson(data as WithdrawCoinEntity, json) as T;
			case SignInResponseEntity:
				return signInResponseEntityFromJson(data as SignInResponseEntity, json) as T;
			case SignInResponseUser:
				return signInResponseUserFromJson(data as SignInResponseUser, json) as T;
			case WalletBalanceEntity:
				return walletBalanceEntityFromJson(data as WalletBalanceEntity, json) as T;
			case WalletBalanceUser:
				return walletBalanceUserFromJson(data as WalletBalanceUser, json) as T;
			case WalletBalanceUserUserCoins:
				return walletBalanceUserUserCoinsFromJson(data as WalletBalanceUserUserCoins, json) as T;
			case WalletBalanceUserUserCoinsCoinTypes:
				return walletBalanceUserUserCoinsCoinTypesFromJson(data as WalletBalanceUserUserCoinsCoinTypes, json) as T;
			case WithdrawNairaEntity:
				return withdrawNairaEntityFromJson(data as WithdrawNairaEntity, json) as T;    }
		return data as T;
	}

  static _getToJson<T>(Type type, data) {
		switch (type) {
			case UserEntity:
				return userEntityToJson(data as UserEntity);
			case UserUser:
				return userUserToJson(data as UserUser);
			case UserUserUserCoins:
				return userUserUserCoinsToJson(data as UserUserUserCoins);
			case UserUserUserCoinsCoinTypes:
				return userUserUserCoinsCoinTypesToJson(data as UserUserUserCoinsCoinTypes);
			case CoinBuyTransactionsEntity:
				return coinBuyTransactionsEntityToJson(data as CoinBuyTransactionsEntity);
			case CoinBuyTransactionsTransactions:
				return coinBuyTransactionsTransactionsToJson(data as CoinBuyTransactionsTransactions);
			case CoinBuyTransactionsTransactionsCoin:
				return coinBuyTransactionsTransactionsCoinToJson(data as CoinBuyTransactionsTransactionsCoin);
			case CoinBuyTransactionsTransactionsUser:
				return coinBuyTransactionsTransactionsUserToJson(data as CoinBuyTransactionsTransactionsUser);
			case CoinWithdrawalHistoryEntity:
				return coinWithdrawalHistoryEntityToJson(data as CoinWithdrawalHistoryEntity);
			case CoinWithdrawalHistoryHistory:
				return coinWithdrawalHistoryHistoryToJson(data as CoinWithdrawalHistoryHistory);
			case CoinWithdrawalHistoryHistoryUser:
				return coinWithdrawalHistoryHistoryUserToJson(data as CoinWithdrawalHistoryHistoryUser);
			case CoinWithdrawalHistoryHistoryCoin:
				return coinWithdrawalHistoryHistoryCoinToJson(data as CoinWithdrawalHistoryHistoryCoin);
			case FundWalletEntity:
				return fundWalletEntityToJson(data as FundWalletEntity);
			case CoinSellTransactionsEntity:
				return coinSellTransactionsEntityToJson(data as CoinSellTransactionsEntity);
			case CoinSellTransactionsTransactions:
				return coinSellTransactionsTransactionsToJson(data as CoinSellTransactionsTransactions);
			case CoinSellTransactionsTransactionsCoin:
				return coinSellTransactionsTransactionsCoinToJson(data as CoinSellTransactionsTransactionsCoin);
			case CoinSellTransactionsTransactionsUser:
				return coinSellTransactionsTransactionsUserToJson(data as CoinSellTransactionsTransactionsUser);
			case DepositHistoryEntity:
				return depositHistoryEntityToJson(data as DepositHistoryEntity);
			case DepositHistoryDeposits:
				return depositHistoryDepositsToJson(data as DepositHistoryDeposits);
			case CourseListEntity:
				return courseListEntityToJson(data as CourseListEntity);
			case CourseListCourses:
				return courseListCoursesToJson(data as CourseListCourses);
			case BankListEntity:
				return bankListEntityToJson(data as BankListEntity);
			case BankListData:
				return bankListDataToJson(data as BankListData);
			case SignUpResponseEntity:
				return signUpResponseEntityToJson(data as SignUpResponseEntity);
			case InvestmentHistoryEntity:
				return investmentHistoryEntityToJson(data as InvestmentHistoryEntity);
			case InvestmentHistoryInvestments:
				return investmentHistoryInvestmentsToJson(data as InvestmentHistoryInvestments);
			case InvestmentHistoryInvestmentsPackage:
				return investmentHistoryInvestmentsPackageToJson(data as InvestmentHistoryInvestmentsPackage);
			case NairaWithdrawalHistoryEntity:
				return nairaWithdrawalHistoryEntityToJson(data as NairaWithdrawalHistoryEntity);
			case NairaWithdrawalHistoryWithdrawals:
				return nairaWithdrawalHistoryWithdrawalsToJson(data as NairaWithdrawalHistoryWithdrawals);
			case ReferralEntity:
				return referralEntityToJson(data as ReferralEntity);
			case ReferralReferrals:
				return referralReferralsToJson(data as ReferralReferrals);
			case ReferralReferralsUser:
				return referralReferralsUserToJson(data as ReferralReferralsUser);
			case NotificationsEntity:
				return notificationsEntityToJson(data as NotificationsEntity);
			case NotificationsNotifications:
				return notificationsNotificationsToJson(data as NotificationsNotifications);
			case NotificationsNotificationsUser:
				return notificationsNotificationsUserToJson(data as NotificationsNotificationsUser);
			case SubscribeResponseEntity:
				return subscribeResponseEntityToJson(data as SubscribeResponseEntity);
			case VerifyBankEntity:
				return verifyBankEntityToJson(data as VerifyBankEntity);
			case VerifyBankData:
				return verifyBankDataToJson(data as VerifyBankData);
			case FundCoinEntity:
				return fundCoinEntityToJson(data as FundCoinEntity);
			case FundCoinData:
				return fundCoinDataToJson(data as FundCoinData);
			case FundCoinProduct:
				return fundCoinProductToJson(data as FundCoinProduct);
			case AllAvailableCoinEntity:
				return allAvailableCoinEntityToJson(data as AllAvailableCoinEntity);
			case AllAvailableCoinProducts:
				return allAvailableCoinProductsToJson(data as AllAvailableCoinProducts);
			case InvestmentListEntity:
				return investmentListEntityToJson(data as InvestmentListEntity);
			case InvestmentListPackages:
				return investmentListPackagesToJson(data as InvestmentListPackages);
			case CodeResponseEntity:
				return codeResponseEntityToJson(data as CodeResponseEntity);
			case WithdrawCoinEntity:
				return withdrawCoinEntityToJson(data as WithdrawCoinEntity);
			case SignInResponseEntity:
				return signInResponseEntityToJson(data as SignInResponseEntity);
			case SignInResponseUser:
				return signInResponseUserToJson(data as SignInResponseUser);
			case WalletBalanceEntity:
				return walletBalanceEntityToJson(data as WalletBalanceEntity);
			case WalletBalanceUser:
				return walletBalanceUserToJson(data as WalletBalanceUser);
			case WalletBalanceUserUserCoins:
				return walletBalanceUserUserCoinsToJson(data as WalletBalanceUserUserCoins);
			case WalletBalanceUserUserCoinsCoinTypes:
				return walletBalanceUserUserCoinsCoinTypesToJson(data as WalletBalanceUserUserCoinsCoinTypes);
			case WithdrawNairaEntity:
				return withdrawNairaEntityToJson(data as WithdrawNairaEntity);
			}
			return data as T;
		}
  //Go back to a single instance by type
	static _fromJsonSingle<M>( json) {
		String type = M.toString();
		if(type == (UserEntity).toString()){
			return UserEntity().fromJson(json);
		}
		if(type == (UserUser).toString()){
			return UserUser().fromJson(json);
		}
		if(type == (UserUserUserCoins).toString()){
			return UserUserUserCoins().fromJson(json);
		}
		if(type == (UserUserUserCoinsCoinTypes).toString()){
			return UserUserUserCoinsCoinTypes().fromJson(json);
		}
		if(type == (CoinBuyTransactionsEntity).toString()){
			return CoinBuyTransactionsEntity().fromJson(json);
		}
		if(type == (CoinBuyTransactionsTransactions).toString()){
			return CoinBuyTransactionsTransactions().fromJson(json);
		}
		if(type == (CoinBuyTransactionsTransactionsCoin).toString()){
			return CoinBuyTransactionsTransactionsCoin().fromJson(json);
		}
		if(type == (CoinBuyTransactionsTransactionsUser).toString()){
			return CoinBuyTransactionsTransactionsUser().fromJson(json);
		}
		if(type == (CoinWithdrawalHistoryEntity).toString()){
			return CoinWithdrawalHistoryEntity().fromJson(json);
		}
		if(type == (CoinWithdrawalHistoryHistory).toString()){
			return CoinWithdrawalHistoryHistory().fromJson(json);
		}
		if(type == (CoinWithdrawalHistoryHistoryUser).toString()){
			return CoinWithdrawalHistoryHistoryUser().fromJson(json);
		}
		if(type == (CoinWithdrawalHistoryHistoryCoin).toString()){
			return CoinWithdrawalHistoryHistoryCoin().fromJson(json);
		}
		if(type == (FundWalletEntity).toString()){
			return FundWalletEntity().fromJson(json);
		}
		if(type == (CoinSellTransactionsEntity).toString()){
			return CoinSellTransactionsEntity().fromJson(json);
		}
		if(type == (CoinSellTransactionsTransactions).toString()){
			return CoinSellTransactionsTransactions().fromJson(json);
		}
		if(type == (CoinSellTransactionsTransactionsCoin).toString()){
			return CoinSellTransactionsTransactionsCoin().fromJson(json);
		}
		if(type == (CoinSellTransactionsTransactionsUser).toString()){
			return CoinSellTransactionsTransactionsUser().fromJson(json);
		}
		if(type == (DepositHistoryEntity).toString()){
			return DepositHistoryEntity().fromJson(json);
		}
		if(type == (DepositHistoryDeposits).toString()){
			return DepositHistoryDeposits().fromJson(json);
		}
		if(type == (CourseListEntity).toString()){
			return CourseListEntity().fromJson(json);
		}
		if(type == (CourseListCourses).toString()){
			return CourseListCourses().fromJson(json);
		}
		if(type == (BankListEntity).toString()){
			return BankListEntity().fromJson(json);
		}
		if(type == (BankListData).toString()){
			return BankListData().fromJson(json);
		}
		if(type == (SignUpResponseEntity).toString()){
			return SignUpResponseEntity().fromJson(json);
		}
		if(type == (InvestmentHistoryEntity).toString()){
			return InvestmentHistoryEntity().fromJson(json);
		}
		if(type == (InvestmentHistoryInvestments).toString()){
			return InvestmentHistoryInvestments().fromJson(json);
		}
		if(type == (InvestmentHistoryInvestmentsPackage).toString()){
			return InvestmentHistoryInvestmentsPackage().fromJson(json);
		}
		if(type == (NairaWithdrawalHistoryEntity).toString()){
			return NairaWithdrawalHistoryEntity().fromJson(json);
		}
		if(type == (NairaWithdrawalHistoryWithdrawals).toString()){
			return NairaWithdrawalHistoryWithdrawals().fromJson(json);
		}
		if(type == (ReferralEntity).toString()){
			return ReferralEntity().fromJson(json);
		}
		if(type == (ReferralReferrals).toString()){
			return ReferralReferrals().fromJson(json);
		}
		if(type == (ReferralReferralsUser).toString()){
			return ReferralReferralsUser().fromJson(json);
		}
		if(type == (NotificationsEntity).toString()){
			return NotificationsEntity().fromJson(json);
		}
		if(type == (NotificationsNotifications).toString()){
			return NotificationsNotifications().fromJson(json);
		}
		if(type == (NotificationsNotificationsUser).toString()){
			return NotificationsNotificationsUser().fromJson(json);
		}
		if(type == (SubscribeResponseEntity).toString()){
			return SubscribeResponseEntity().fromJson(json);
		}
		if(type == (VerifyBankEntity).toString()){
			return VerifyBankEntity().fromJson(json);
		}
		if(type == (VerifyBankData).toString()){
			return VerifyBankData().fromJson(json);
		}
		if(type == (FundCoinEntity).toString()){
			return FundCoinEntity().fromJson(json);
		}
		if(type == (FundCoinData).toString()){
			return FundCoinData().fromJson(json);
		}
		if(type == (FundCoinProduct).toString()){
			return FundCoinProduct().fromJson(json);
		}
		if(type == (AllAvailableCoinEntity).toString()){
			return AllAvailableCoinEntity().fromJson(json);
		}
		if(type == (AllAvailableCoinProducts).toString()){
			return AllAvailableCoinProducts().fromJson(json);
		}
		if(type == (InvestmentListEntity).toString()){
			return InvestmentListEntity().fromJson(json);
		}
		if(type == (InvestmentListPackages).toString()){
			return InvestmentListPackages().fromJson(json);
		}
		if(type == (CodeResponseEntity).toString()){
			return CodeResponseEntity().fromJson(json);
		}
		if(type == (WithdrawCoinEntity).toString()){
			return WithdrawCoinEntity().fromJson(json);
		}
		if(type == (SignInResponseEntity).toString()){
			return SignInResponseEntity().fromJson(json);
		}
		if(type == (SignInResponseUser).toString()){
			return SignInResponseUser().fromJson(json);
		}
		if(type == (WalletBalanceEntity).toString()){
			return WalletBalanceEntity().fromJson(json);
		}
		if(type == (WalletBalanceUser).toString()){
			return WalletBalanceUser().fromJson(json);
		}
		if(type == (WalletBalanceUserUserCoins).toString()){
			return WalletBalanceUserUserCoins().fromJson(json);
		}
		if(type == (WalletBalanceUserUserCoinsCoinTypes).toString()){
			return WalletBalanceUserUserCoinsCoinTypes().fromJson(json);
		}
		if(type == (WithdrawNairaEntity).toString()){
			return WithdrawNairaEntity().fromJson(json);
		}

		return null;
	}

  //list is returned by type
	static M _getListChildType<M>(List data) {
		if(<UserEntity>[] is M){
			return data.map<UserEntity>((e) => UserEntity().fromJson(e)).toList() as M;
		}
		if(<UserUser>[] is M){
			return data.map<UserUser>((e) => UserUser().fromJson(e)).toList() as M;
		}
		if(<UserUserUserCoins>[] is M){
			return data.map<UserUserUserCoins>((e) => UserUserUserCoins().fromJson(e)).toList() as M;
		}
		if(<UserUserUserCoinsCoinTypes>[] is M){
			return data.map<UserUserUserCoinsCoinTypes>((e) => UserUserUserCoinsCoinTypes().fromJson(e)).toList() as M;
		}
		if(<CoinBuyTransactionsEntity>[] is M){
			return data.map<CoinBuyTransactionsEntity>((e) => CoinBuyTransactionsEntity().fromJson(e)).toList() as M;
		}
		if(<CoinBuyTransactionsTransactions>[] is M){
			return data.map<CoinBuyTransactionsTransactions>((e) => CoinBuyTransactionsTransactions().fromJson(e)).toList() as M;
		}
		if(<CoinBuyTransactionsTransactionsCoin>[] is M){
			return data.map<CoinBuyTransactionsTransactionsCoin>((e) => CoinBuyTransactionsTransactionsCoin().fromJson(e)).toList() as M;
		}
		if(<CoinBuyTransactionsTransactionsUser>[] is M){
			return data.map<CoinBuyTransactionsTransactionsUser>((e) => CoinBuyTransactionsTransactionsUser().fromJson(e)).toList() as M;
		}
		if(<CoinWithdrawalHistoryEntity>[] is M){
			return data.map<CoinWithdrawalHistoryEntity>((e) => CoinWithdrawalHistoryEntity().fromJson(e)).toList() as M;
		}
		if(<CoinWithdrawalHistoryHistory>[] is M){
			return data.map<CoinWithdrawalHistoryHistory>((e) => CoinWithdrawalHistoryHistory().fromJson(e)).toList() as M;
		}
		if(<CoinWithdrawalHistoryHistoryUser>[] is M){
			return data.map<CoinWithdrawalHistoryHistoryUser>((e) => CoinWithdrawalHistoryHistoryUser().fromJson(e)).toList() as M;
		}
		if(<CoinWithdrawalHistoryHistoryCoin>[] is M){
			return data.map<CoinWithdrawalHistoryHistoryCoin>((e) => CoinWithdrawalHistoryHistoryCoin().fromJson(e)).toList() as M;
		}
		if(<FundWalletEntity>[] is M){
			return data.map<FundWalletEntity>((e) => FundWalletEntity().fromJson(e)).toList() as M;
		}
		if(<CoinSellTransactionsEntity>[] is M){
			return data.map<CoinSellTransactionsEntity>((e) => CoinSellTransactionsEntity().fromJson(e)).toList() as M;
		}
		if(<CoinSellTransactionsTransactions>[] is M){
			return data.map<CoinSellTransactionsTransactions>((e) => CoinSellTransactionsTransactions().fromJson(e)).toList() as M;
		}
		if(<CoinSellTransactionsTransactionsCoin>[] is M){
			return data.map<CoinSellTransactionsTransactionsCoin>((e) => CoinSellTransactionsTransactionsCoin().fromJson(e)).toList() as M;
		}
		if(<CoinSellTransactionsTransactionsUser>[] is M){
			return data.map<CoinSellTransactionsTransactionsUser>((e) => CoinSellTransactionsTransactionsUser().fromJson(e)).toList() as M;
		}
		if(<DepositHistoryEntity>[] is M){
			return data.map<DepositHistoryEntity>((e) => DepositHistoryEntity().fromJson(e)).toList() as M;
		}
		if(<DepositHistoryDeposits>[] is M){
			return data.map<DepositHistoryDeposits>((e) => DepositHistoryDeposits().fromJson(e)).toList() as M;
		}
		if(<CourseListEntity>[] is M){
			return data.map<CourseListEntity>((e) => CourseListEntity().fromJson(e)).toList() as M;
		}
		if(<CourseListCourses>[] is M){
			return data.map<CourseListCourses>((e) => CourseListCourses().fromJson(e)).toList() as M;
		}
		if(<BankListEntity>[] is M){
			return data.map<BankListEntity>((e) => BankListEntity().fromJson(e)).toList() as M;
		}
		if(<BankListData>[] is M){
			return data.map<BankListData>((e) => BankListData().fromJson(e)).toList() as M;
		}
		if(<SignUpResponseEntity>[] is M){
			return data.map<SignUpResponseEntity>((e) => SignUpResponseEntity().fromJson(e)).toList() as M;
		}
		if(<InvestmentHistoryEntity>[] is M){
			return data.map<InvestmentHistoryEntity>((e) => InvestmentHistoryEntity().fromJson(e)).toList() as M;
		}
		if(<InvestmentHistoryInvestments>[] is M){
			return data.map<InvestmentHistoryInvestments>((e) => InvestmentHistoryInvestments().fromJson(e)).toList() as M;
		}
		if(<InvestmentHistoryInvestmentsPackage>[] is M){
			return data.map<InvestmentHistoryInvestmentsPackage>((e) => InvestmentHistoryInvestmentsPackage().fromJson(e)).toList() as M;
		}
		if(<NairaWithdrawalHistoryEntity>[] is M){
			return data.map<NairaWithdrawalHistoryEntity>((e) => NairaWithdrawalHistoryEntity().fromJson(e)).toList() as M;
		}
		if(<NairaWithdrawalHistoryWithdrawals>[] is M){
			return data.map<NairaWithdrawalHistoryWithdrawals>((e) => NairaWithdrawalHistoryWithdrawals().fromJson(e)).toList() as M;
		}
		if(<ReferralEntity>[] is M){
			return data.map<ReferralEntity>((e) => ReferralEntity().fromJson(e)).toList() as M;
		}
		if(<ReferralReferrals>[] is M){
			return data.map<ReferralReferrals>((e) => ReferralReferrals().fromJson(e)).toList() as M;
		}
		if(<ReferralReferralsUser>[] is M){
			return data.map<ReferralReferralsUser>((e) => ReferralReferralsUser().fromJson(e)).toList() as M;
		}
		if(<NotificationsEntity>[] is M){
			return data.map<NotificationsEntity>((e) => NotificationsEntity().fromJson(e)).toList() as M;
		}
		if(<NotificationsNotifications>[] is M){
			return data.map<NotificationsNotifications>((e) => NotificationsNotifications().fromJson(e)).toList() as M;
		}
		if(<NotificationsNotificationsUser>[] is M){
			return data.map<NotificationsNotificationsUser>((e) => NotificationsNotificationsUser().fromJson(e)).toList() as M;
		}
		if(<SubscribeResponseEntity>[] is M){
			return data.map<SubscribeResponseEntity>((e) => SubscribeResponseEntity().fromJson(e)).toList() as M;
		}
		if(<VerifyBankEntity>[] is M){
			return data.map<VerifyBankEntity>((e) => VerifyBankEntity().fromJson(e)).toList() as M;
		}
		if(<VerifyBankData>[] is M){
			return data.map<VerifyBankData>((e) => VerifyBankData().fromJson(e)).toList() as M;
		}
		if(<FundCoinEntity>[] is M){
			return data.map<FundCoinEntity>((e) => FundCoinEntity().fromJson(e)).toList() as M;
		}
		if(<FundCoinData>[] is M){
			return data.map<FundCoinData>((e) => FundCoinData().fromJson(e)).toList() as M;
		}
		if(<FundCoinProduct>[] is M){
			return data.map<FundCoinProduct>((e) => FundCoinProduct().fromJson(e)).toList() as M;
		}
		if(<AllAvailableCoinEntity>[] is M){
			return data.map<AllAvailableCoinEntity>((e) => AllAvailableCoinEntity().fromJson(e)).toList() as M;
		}
		if(<AllAvailableCoinProducts>[] is M){
			return data.map<AllAvailableCoinProducts>((e) => AllAvailableCoinProducts().fromJson(e)).toList() as M;
		}
		if(<InvestmentListEntity>[] is M){
			return data.map<InvestmentListEntity>((e) => InvestmentListEntity().fromJson(e)).toList() as M;
		}
		if(<InvestmentListPackages>[] is M){
			return data.map<InvestmentListPackages>((e) => InvestmentListPackages().fromJson(e)).toList() as M;
		}
		if(<CodeResponseEntity>[] is M){
			return data.map<CodeResponseEntity>((e) => CodeResponseEntity().fromJson(e)).toList() as M;
		}
		if(<WithdrawCoinEntity>[] is M){
			return data.map<WithdrawCoinEntity>((e) => WithdrawCoinEntity().fromJson(e)).toList() as M;
		}
		if(<SignInResponseEntity>[] is M){
			return data.map<SignInResponseEntity>((e) => SignInResponseEntity().fromJson(e)).toList() as M;
		}
		if(<SignInResponseUser>[] is M){
			return data.map<SignInResponseUser>((e) => SignInResponseUser().fromJson(e)).toList() as M;
		}
		if(<WalletBalanceEntity>[] is M){
			return data.map<WalletBalanceEntity>((e) => WalletBalanceEntity().fromJson(e)).toList() as M;
		}
		if(<WalletBalanceUser>[] is M){
			return data.map<WalletBalanceUser>((e) => WalletBalanceUser().fromJson(e)).toList() as M;
		}
		if(<WalletBalanceUserUserCoins>[] is M){
			return data.map<WalletBalanceUserUserCoins>((e) => WalletBalanceUserUserCoins().fromJson(e)).toList() as M;
		}
		if(<WalletBalanceUserUserCoinsCoinTypes>[] is M){
			return data.map<WalletBalanceUserUserCoinsCoinTypes>((e) => WalletBalanceUserUserCoinsCoinTypes().fromJson(e)).toList() as M;
		}
		if(<WithdrawNairaEntity>[] is M){
			return data.map<WithdrawNairaEntity>((e) => WithdrawNairaEntity().fromJson(e)).toList() as M;
		}

		throw Exception("not found");
	}

  static M fromJsonAsT<M>(json) {
		if (json is List) {
			return _getListChildType<M>(json);
		} else {
			return _fromJsonSingle<M>(json) as M;
		}
	}
}