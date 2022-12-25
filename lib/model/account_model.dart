// To parse this JSON data, do
//
//     final accountModel = accountModelFromJson(jsonString);

import 'dart:convert';

AccountModel accountModelFromJson(String str) => AccountModel.fromJson(json.decode(str));

String accountModelToJson(AccountModel data) => json.encode(data.toJson());

class AccountModel {
  AccountModel({
    this.id,
    this.userType,
    this.userId,
    this.balance,
    this.isDelete,
    this.accountRecords,
    this.createTime,
  });

  String? id;
  String? userType;
  String? userId;
  String? balance;
  String? isDelete;
  List<AccountRecord>? accountRecords;
  String? createTime;

  factory AccountModel.fromJson(Map<String, dynamic> json) => AccountModel(
    id: json["id"].toString(),
    userType: json["userType"].toString(),
    userId: json["userId"].toString(),
    balance: json["balance"].toDouble().toString(),
    isDelete: json["isDelete"].toString(),
    accountRecords:(json["accountRecords"] == null || json["accountRecords"] == "") ? [] :  List<AccountRecord>.from(json["accountRecords"].map((x) => AccountRecord.fromJson(x))),
    createTime: json["createTime"].toString(),
  );


  Map<String, dynamic> toJson() => {
    "id": id,
    "userType": userType,
    "userId": userId,
    "balance": balance,
    "isDelete": isDelete,
    "accountRecords": List<AccountRecord>.from(accountRecords!.map((x) => x.toJson())),
    "createTime": createTime,
  };
}

class AccountRecord {
  AccountRecord({
    this.id,
    this.userTypeFrom,
    this.userTypeTo,
    this.userIdFrom,
    this.userIdTo,
    this.payStatus,
    this.tradingId,
    this.tradingMoney,
    this.tradingType,
    this.tradingNote,
    this.isDelete,
    this.createTime,
  });

  String? id;
  String? userTypeFrom;
  String? userTypeTo;
  String? userIdFrom;
  String? userIdTo;
  String? payStatus;
  String? tradingId;
  String? tradingMoney;
  String? tradingType;
  String? tradingNote;
  String? isDelete;
  String? createTime;

  factory AccountRecord.fromJson(Map<String, dynamic> json) => AccountRecord(
    id: json["id"].toString(),
    userTypeFrom: json["userTypeFrom"].toString(),
    userTypeTo: json["userTypeTo"].toString(),
    userIdFrom: json["userIdFrom"].toString(),
    userIdTo: json["userIdTo"].toString(),
    payStatus: json["payStatus"].toString(),
    tradingId: json["tradingId"] == null ? null : json["tradingId"].toString(),
    tradingMoney: json["tradingMoney"].toDouble().toString(),
    tradingType: json["tradingType"].toString(),
    tradingNote: json["tradingNote"] == null ? null : json["tradingNote"].toString(),
    isDelete: json["isDelete"].toString(),
    createTime: json["createTime"].toString(),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "userTypeFrom": userTypeFrom,
    "userTypeTo": userTypeTo,
    "userIdFrom": userIdFrom,
    "userIdTo": userIdTo,
    "payStatus": payStatus,
    "tradingId": tradingId == null ? null : tradingId,
    "tradingMoney": tradingMoney,
    "tradingType": tradingType,
    "tradingNote": tradingNote == null ? null : tradingNote,
    "isDelete": isDelete,
    "createTime": createTime,
  };
}
