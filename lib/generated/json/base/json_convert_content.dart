// ignore_for_file: non_constant_identifier_names
// ignore_for_file: camel_case_types
// ignore_for_file: prefer_single_quotes

// This file is automatically generated. DO NOT EDIT, all your changes would be lost.
import 'package:pay_buy_max/models/wallet/user_entity.dart';
import 'package:pay_buy_max/generated/json/user_entity_helper.dart';
import 'package:pay_buy_max/models/wallet/fund_wallet_entity.dart';
import 'package:pay_buy_max/generated/json/fund_wallet_entity_helper.dart';
import 'package:pay_buy_max/models/learn/course_list_entity.dart';
import 'package:pay_buy_max/generated/json/course_list_entity_helper.dart';
import 'package:pay_buy_max/models/auth/sign_up_response_entity.dart';
import 'package:pay_buy_max/generated/json/sign_up_response_entity_helper.dart';
import 'package:pay_buy_max/models/wallet/subscribe_response_entity.dart';
import 'package:pay_buy_max/generated/json/subscribe_response_entity_helper.dart';
import 'package:pay_buy_max/models/wallet/fund_coin_entity.dart';
import 'package:pay_buy_max/generated/json/fund_coin_entity_helper.dart';
import 'package:pay_buy_max/models/wallet/all_available_coin_entity.dart';
import 'package:pay_buy_max/generated/json/all_available_coin_entity_helper.dart';
import 'package:pay_buy_max/models/invest/investment_list_entity.dart';
import 'package:pay_buy_max/generated/json/investment_list_entity_helper.dart';
import 'package:pay_buy_max/models/wallet/code_response_entity.dart';
import 'package:pay_buy_max/generated/json/code_response_entity_helper.dart';
import 'package:pay_buy_max/models/auth/sign_in_response_entity.dart';
import 'package:pay_buy_max/generated/json/sign_in_response_entity_helper.dart';
import 'package:pay_buy_max/models/wallet/wallet_balance_entity.dart';
import 'package:pay_buy_max/generated/json/wallet_balance_entity_helper.dart';

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
			case FundWalletEntity:
				return fundWalletEntityFromJson(data as FundWalletEntity, json) as T;
			case CourseListEntity:
				return courseListEntityFromJson(data as CourseListEntity, json) as T;
			case CourseListCourses:
				return courseListCoursesFromJson(data as CourseListCourses, json) as T;
			case SignUpResponseEntity:
				return signUpResponseEntityFromJson(data as SignUpResponseEntity, json) as T;
			case SubscribeResponseEntity:
				return subscribeResponseEntityFromJson(data as SubscribeResponseEntity, json) as T;
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
				return walletBalanceUserUserCoinsCoinTypesFromJson(data as WalletBalanceUserUserCoinsCoinTypes, json) as T;    }
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
			case FundWalletEntity:
				return fundWalletEntityToJson(data as FundWalletEntity);
			case CourseListEntity:
				return courseListEntityToJson(data as CourseListEntity);
			case CourseListCourses:
				return courseListCoursesToJson(data as CourseListCourses);
			case SignUpResponseEntity:
				return signUpResponseEntityToJson(data as SignUpResponseEntity);
			case SubscribeResponseEntity:
				return subscribeResponseEntityToJson(data as SubscribeResponseEntity);
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
		if(type == (FundWalletEntity).toString()){
			return FundWalletEntity().fromJson(json);
		}
		if(type == (CourseListEntity).toString()){
			return CourseListEntity().fromJson(json);
		}
		if(type == (CourseListCourses).toString()){
			return CourseListCourses().fromJson(json);
		}
		if(type == (SignUpResponseEntity).toString()){
			return SignUpResponseEntity().fromJson(json);
		}
		if(type == (SubscribeResponseEntity).toString()){
			return SubscribeResponseEntity().fromJson(json);
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
		if(<FundWalletEntity>[] is M){
			return data.map<FundWalletEntity>((e) => FundWalletEntity().fromJson(e)).toList() as M;
		}
		if(<CourseListEntity>[] is M){
			return data.map<CourseListEntity>((e) => CourseListEntity().fromJson(e)).toList() as M;
		}
		if(<CourseListCourses>[] is M){
			return data.map<CourseListCourses>((e) => CourseListCourses().fromJson(e)).toList() as M;
		}
		if(<SignUpResponseEntity>[] is M){
			return data.map<SignUpResponseEntity>((e) => SignUpResponseEntity().fromJson(e)).toList() as M;
		}
		if(<SubscribeResponseEntity>[] is M){
			return data.map<SubscribeResponseEntity>((e) => SubscribeResponseEntity().fromJson(e)).toList() as M;
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