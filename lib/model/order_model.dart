import 'dart:convert';

import 'package:app/model/address_model.dart';
import 'package:app/model/attachment_model.dart';
import 'package:app/model/user_info_model.dart';

OrderModel orderModelFromJson(String str) => OrderModel.fromJson(json.decode(str));

String orderModelToJson(OrderModel data) => json.encode(data.toJson());

class OrderModel {
  OrderModel({
    this.id,
    this.submitUserId,
    this.receiveUserId,
    this.orderType,
    this.status,
    this.tradingMoney,
    this.totalWeight,
    this.totalIntegral,
    this.addressId,
    this.appointmentBeginTime,
    this.appointmentEndTime,
    this.note,
    this.noteAttachmentIds,
    this.recycleOrderDetails,
    this.attachments,
    this.address,
    this.receiveUser,
    this.isDelete,
    this.createTime,
  });

  String? id;
  String? submitUserId;
  String? receiveUserId;
  String? orderType;
  String? status;
  String? tradingMoney;
  String? totalWeight;
  String? totalIntegral;
  String? addressId;
  String? appointmentBeginTime;
  String? appointmentEndTime;
  String? note;
  String? noteAttachmentIds;
  List<RecycleOrderDetail>? recycleOrderDetails;
  List<AttachmentModel>? attachments;
  AddressModel? address;
  UserInfoModel? receiveUser;
  String? isDelete;
  String? createTime;

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
    id: json["id"].toString(),
    submitUserId: json["submitUserId"].toString(),
    receiveUserId: json["receiveUserId"].toString(),
    orderType: json["orderType"].toString(),
    status: json["status"].toString(),
    tradingMoney: json["tradingMoney"].toString(),
    totalWeight: json["totalWeight"].toString(),
    totalIntegral: json["totalIntegral"].toString(),
    addressId: json["addressId"].toString(),
    appointmentBeginTime: json["appointmentBeginTime"].toString(),
    appointmentEndTime: json["appointmentEndTime"].toString(),
    note: json["note"].toString(),
    noteAttachmentIds: json["noteAttachmentIds"].toString(),
    recycleOrderDetails: List<RecycleOrderDetail>.from(json["recycleOrderDetails"].map((x) => RecycleOrderDetail.fromJson(x))),
    attachments: (json["attachments"] == null || json["attachments"] == "") ? [] : List<AttachmentModel>.from(json["attachments"].map((x) => AttachmentModel.fromJson(x))),
    address: (json["address"] == null || json["address"] == "") ? null : AddressModel.fromJson(json["address"]),
    receiveUser: (json["receiveUser"] == null || json["receiveUser"] == "") ? null :  UserInfoModel.fromJson(json["receiveUser"]),
    isDelete: json["isDelete"].toString(),
    createTime: json["createTime"].toString(),
  );


  Map<String, dynamic> toJson() => {
    "id": id,
    "submitUserId": submitUserId,
    "receiveUserId": receiveUserId,
    "orderType": orderType,
    "status": status,
    "tradingMoney": tradingMoney,
    "totalWeight": totalWeight,
    "totalIntegral": totalIntegral,
    "addressId": addressId,
    "appointmentBeginTime": appointmentBeginTime,
    "appointmentEndTime": appointmentEndTime,
    "note": note,
    "noteAttachmentIds": noteAttachmentIds,
    "recycleOrderDetails": List<RecycleOrderDetail>.from(recycleOrderDetails!.map((x) => x.toJson())),
    "attachments": List<AttachmentModel>.from(attachments!.map((x) => x.toJson())),
    "address": address!.toJson(),
    "receiveUser": receiveUser,
    "isDelete": isDelete,
    "createTime": createTime,
  };
}

class RecycleOrderDetail {
  RecycleOrderDetail({
    this.id,
    this.orderId,
    this.goodsId,
    this.recycleGoods,
    this.weight,
    this.isDelete,
    this.createTime,
  });

  String? id;
  String? orderId;
  String? goodsId;
  RecycleGoods? recycleGoods;
  String? weight;
  String? isDelete;
  String? createTime;

  factory RecycleOrderDetail.fromJson(Map<String, dynamic> json) => RecycleOrderDetail(
    id: json["id"].toString(),
    orderId: json["orderId"].toString(),
    goodsId: json["goodsId"].toString(),
    recycleGoods: RecycleGoods.fromJson(json["recycleGoods"]),
    weight: json["weight"].toString(),
    isDelete: json["isDelete"].toString(),
    createTime: json["createTime"].toString(),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "orderId": orderId,
    "goodsId": goodsId,
    "recycleGoods": recycleGoods!.toJson(),
    "weight": weight,
    "isDelete": isDelete,
    "createTime": createTime,
  };
}

class RecycleGoods {
  RecycleGoods({
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

  factory RecycleGoods.fromJson(Map<String, dynamic> json) => RecycleGoods(
    id: json["id"].toString(),
    typeId: json["typeId"].toString(),
    name: json["name"].toString(),
    describe: json["describe"].toString(),
    attachmentId: json["attachmentId"].toString(),
    integral: json["integral"].toString(),
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
