/// 用户信息实体类
// To parse this JSON data, do
//
//     final userInfoModel = userInfoModelFromJson(jsonString);

import 'dart:convert';

UserInfoModel userInfoModelFromJson(String str) => UserInfoModel.fromJson(json.decode(str));

String userInfoModelToJson(UserInfoModel data) => json.encode(data.toJson());

class UserInfoModel {
  UserInfoModel({
    this.id,
    this.username,
    this.userType,
    this.gender,
    this.attachmentId,
    this.nickName,
    this.phone,
    this.isDelete,
    this.lastVisitTime,
    this.createTime,
    this.updateTime,
  });

  String? id;
  String? username;
  String? userType;
  String? gender;
  String? attachmentId;
  String? nickName;
  String? phone;
  String? isDelete;
  String? lastVisitTime;
  String? createTime;
  String? updateTime;

  factory UserInfoModel.fromJson(Map<String, dynamic> json) => UserInfoModel(
    id: json["id"].toString(),
    username: json["username"].toString(),
    userType: json["userType"].toString(),
    gender: json["gender"].toString(),
    attachmentId: json["attachmentId"].toString(),
    nickName: json["nickName"].toString(),
    phone: json["phone"].toString(),
    isDelete: json["isDelete"].toString(),
    lastVisitTime: json["lastVisitTime"].toString(),
    createTime: json["createTime"].toString(),
    updateTime: json["updateTime"].toString(),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "username": username,
    "userType": userType,
    "gender": gender,
    "attachmentId": attachmentId,
    "nickName": nickName,
    "phone": phone,
    "isDelete": isDelete,
    "lastVisitTime": lastVisitTime,
    "createTime": createTime,
    "updateTime": updateTime,
  };
}
