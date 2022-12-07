// To parse this JSON data, do
//
//     final noticeModel = noticeModelFromJson(jsonString);

import 'dart:convert';

NoticeModel noticeModelFromJson(String str) => NoticeModel.fromJson(json.decode(str));

String noticeModelToJson(NoticeModel data) => json.encode(data.toJson());

class NoticeModel {
  NoticeModel({
    this.id,
    this.type,
    this.title,
    this.subTitle,
    this.detail,
    this.link,
    this.createTime,
  });

  String? id;
  String? type;
  String? title;
  String? subTitle;
  String? detail;
  String? link;
  String? createTime;

  factory NoticeModel.fromJson(Map<String, dynamic> json) => NoticeModel(
    id: json["id"].toString(),
    type: json["type"].toString(),
    title: json["title"].toString(),
    subTitle: json["subTitle"].toString(),
    detail: json["detail"].toString(),
    link: json["link"].toString(),
    createTime: json["createTime"].toString(),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "type": type,
    "title": title,
    "subTitle": subTitle,
    "detail": detail,
    "link": link,
    "createTime": createTime,
  };
}
