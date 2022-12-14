// To parse this JSON data, do
//
//     final recycleGoodsModel = recycleGoodsModelFromJson(jsonString);

import 'dart:convert';

import 'package:app/model/attachment_model.dart';

RecycleGoodsModel recycleGoodsModelFromJson(String str) => RecycleGoodsModel.fromJson(json.decode(str));

String recycleGoodsModelToJson(RecycleGoodsModel data) => json.encode(data.toJson());

class RecycleGoodsModel {
  RecycleGoodsModel({
    this.id,
    this.name,
    this.describe,
    this.status,
    this.recycleGoods,
    this.createTime,
  });

  String? id;
  String? name;
  String? describe;
  String? status;
  List<RecycleGood>? recycleGoods;
  String? createTime;

  factory RecycleGoodsModel.fromJson(Map<String, dynamic> json) => RecycleGoodsModel(
    id: json["id"].toString(),
    name: json["name"].toString(),
    describe: json["describe"].toString(),
    status: json["status"].toString(),
    recycleGoods: List<RecycleGood>.from(json["recycleGoods"].map((x) => RecycleGood.fromJson(x))),
    createTime: json["createTime"].toString(),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "describe": describe,
    "status": status,
    "recycleGoods": List<dynamic>.from(recycleGoods!.map((x) => x.toJson())),
    "createTime": createTime
  };
}

class RecycleGood {
  RecycleGood({
    this.id,
    this.typeId,
    this.name,
    this.describe,
    this.attachmentId,
    this.integral,
    this.userPrice,
    this.driverPrice,
    this.recycleCenterPrice,
    this.attachment,
    this.status,
    this.createTime,
  });

  String? id;
  String? typeId;
  String? name;
  String? describe;
  String? attachmentId;
  String? integral;
  String? userPrice;
  String? driverPrice;
  String? recycleCenterPrice;
  AttachmentModel? attachment;
  String? status;
  String? createTime;

  factory RecycleGood.fromJson(Map<String, dynamic> json) => RecycleGood(
    id: json["id"].toString(),
    typeId: json["typeId"].toString(),
    name: json["name"].toString(),
    describe: json["describe"].toString(),
    attachmentId: json["attachmentId"].toString(),
    integral: json["integral"].toDouble().toString(),
    userPrice: json["userPrice"].toDouble().toString(),
    driverPrice: json["driverPrice"].toDouble().toString(),
    recycleCenterPrice: json["recycleCenterPrice"].toDouble().toString(),
    attachment: AttachmentModel.fromJson(json["attachment"]),
    status: json["status"].toString(),
    createTime: json["createTime"].toString(),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "typeId": typeId,
    "name": name,
    "describe": describe,
    "attachmentId": attachmentId,
    "integral": integral,
    "userPrice": userPrice,
    "driverPrice": driverPrice,
    "recycleCenterPrice": recycleCenterPrice,
    "attachment": attachment!.toJson(),
    "status": status,
    "createTime": createTime,
  };
}
