// To parse this JSON data, do
//
//     final userAuthModel = userAuthModelFromJson(jsonString);

import 'dart:convert';

UserAuthModel userAuthModelFromJson(String str) => UserAuthModel.fromJson(json.decode(str));

String userAuthModelToJson(UserAuthModel data) => json.encode(data.toJson());

class UserAuthModel {
  UserAuthModel({
    this.id,
    this.username,
    this.token,
  });

  String? id;
  String? username;
  String? token;

  factory UserAuthModel.fromJson(Map<String, dynamic> json) => UserAuthModel(
    id: json["id"].toString(),
    username: json["username"].toString(),
    token: json["token"].toString(),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "username": username,
    "token": token,
  };
}
