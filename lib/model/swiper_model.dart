// To parse this JSON data, do
//
//     final swiperModel = swiperModelFromJson(jsonString);

import 'dart:convert';

import 'package:app/model/attachment_model.dart';

SwiperModel swiperModelFromJson(String str) => SwiperModel.fromJson(json.decode(str));

String swiperModelToJson(SwiperModel data) => json.encode(data.toJson());

class SwiperModel {
  SwiperModel({
    this.id,
    this.type,
    this.attachmentId,
    this.title,
    this.subTitle,
    this.detail,
    this.link,
    this.attachment,
    this.createTime,
  });

  String? id;
  String? type;
  String? attachmentId;
  String? title;
  String? subTitle;
  String? detail;
  String? link;
  AttachmentModel? attachment;
  String? createTime;

  factory SwiperModel.fromJson(Map<String, dynamic> json) => SwiperModel(
    id: json["id"].toString(),
    type: json["type"].toString(),
    attachmentId: json["attachmentId"].toString(),
    title: json["title"].toString(),
    subTitle: json["subTitle"].toString(),
    detail: json["detail"].toString(),
    link: json["link"].toString(),
    attachment: AttachmentModel.fromJson(json["attachment"]),
    createTime: json["createTime"].toString(),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "type": type,
    "attachmentId": attachmentId,
    "title": title,
    "subTitle": subTitle,
    "detail": detail,
    "link": link,
    "attachment": attachment?.toJson(),
    "createTime": createTime,
  };
}
