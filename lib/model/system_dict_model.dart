// To parse this JSON data, do
//
//     final systemDictModel = systemDictModelFromJson(jsonString);

import 'dart:convert';

SystemDictModel systemDictModelFromJson(String str) => SystemDictModel.fromJson(json.decode(str));

String systemDictModelToJson(SystemDictModel data) => json.encode(data.toJson());

class SystemDictModel {
  SystemDictModel({
    this.id,
    this.dictCode,
    this.dictName,
    this.dictDescribe,
    this.createBy,
    this.createTime,
  });

  String? id;
  String? dictCode;
  String? dictName;
  String? dictDescribe;
  String? createBy;
  String? createTime;

  factory SystemDictModel.fromJson(Map<String, dynamic> json) => SystemDictModel(
    id: json["id"].toString().toString(),
    dictCode: json["dictCode"].toString().toString(),
    dictName: json["dictName"].toString().toString(),
    dictDescribe: json["dictDescribe"].toString().toString(),
    createBy: json["createBy"].toString().toString(),
    createTime: json["createTime"].toString().toString(),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "dictCode": dictCode,
    "dictName": dictName,
    "dictDescribe": dictDescribe,
    "createBy": createBy,
    "createTime": createTime,
  };
}
