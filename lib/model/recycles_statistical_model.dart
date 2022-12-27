// To parse this JSON data, do
//
//     final recyclesStatisticalModel = recyclesStatisticalModelFromJson(jsonString);

import 'dart:convert';

RecyclesStatisticalModel recyclesStatisticalModelFromJson(String str) => RecyclesStatisticalModel.fromJson(json.decode(str));

String recyclesStatisticalModelToJson(RecyclesStatisticalModel data) => json.encode(data.toJson());

class RecyclesStatisticalModel {
  RecyclesStatisticalModel({
    this.id,
    this.currentMonthWeight,
    this.accumulativeWeight,
    this.totalCount,
  });

  String? id;
  String? currentMonthWeight;
  String? accumulativeWeight;
  String? totalCount;

  factory RecyclesStatisticalModel.fromJson(Map<String, dynamic> json) => RecyclesStatisticalModel(
    id: json["id"].toString(),
    currentMonthWeight: json["currentMonthWeight"].toString(),
    accumulativeWeight: json["accumulativeWeight"].toString(),
    totalCount: json["totalCount"].toString(),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "currentMonthWeight": currentMonthWeight,
    "accumulativeWeight": accumulativeWeight,
    "totalCount": totalCount,
  };
}
