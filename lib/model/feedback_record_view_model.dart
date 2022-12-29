// To parse this JSON data, do
//
//     final feedbackRecordModel = feedbackRecordModelFromJson(jsonString);

import 'dart:convert';

import 'package:app/model/attachment_model.dart';

FeedbackRecordModel feedbackRecordModelFromJson(String str) => FeedbackRecordModel.fromJson(json.decode(str));

String feedbackRecordModelToJson(FeedbackRecordModel data) => json.encode(data.toJson());

class FeedbackRecordModel {
  FeedbackRecordModel({
    this.id,
    this.userId,
    this.userType,
    this.feedbackTitle,
    this.feedbackDetail,
    this.attachmentId,
    this.isSolve,
    this.attachment,
    this.isDelete,
    this.createTime,
  });

  String? id;
  String? userId;
  String? userType;
  String? feedbackTitle;
  String? feedbackDetail;
  String? attachmentId;
  String? isSolve;
  AttachmentModel? attachment;
  String? isDelete;
  String? createTime;

  factory FeedbackRecordModel.fromJson(Map<String, dynamic> json) => FeedbackRecordModel(
    id: json["id"].toString(),
    userId: json["userId"].toString(),
    userType: json["userType"].toString(),
    feedbackTitle: json["feedbackTitle"].toString(),
    feedbackDetail: json["feedbackDetail"].toString(),
    attachmentId: json["attachmentId"].toString(),
    isSolve: json["isSolve"].toString(),
    attachment: (json["attachment"]=="" || json["attachment"] == null) ? null : AttachmentModel.fromJson(json["attachment"]),
    isDelete: json["isDelete"].toString(),
    createTime: json["createTime"].toString(),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "userId": userId,
    "userType": userType,
    "feedbackTitle": feedbackTitle,
    "feedbackDetail": feedbackDetail,
    "attachmentId": attachmentId,
    "isSolve": isSolve,
    "attachment": attachment,
    "isDelete": isDelete,
    "createTime": createTime,
  };
}
