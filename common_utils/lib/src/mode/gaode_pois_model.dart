// To parse this JSON data, do
//
//     final gaodePoisModel = gaodePoisModelFromJson(jsonString);

import 'dart:convert';

GaodePoisModel gaodePoisModelFromJson(String str) => GaodePoisModel.fromJson(json.decode(str));

String gaodePoisModelToJson(GaodePoisModel data) => json.encode(data.toJson());

class GaodePoisModel {
  GaodePoisModel({
    this.id,
    this.direction,
    this.businessarea,
    this.address,
    this.poiweight,
    this.name,
    this.location,
    this.distance,
    this.tel,
    this.type,
  });

  String? id;
  String? direction;
  String? businessarea;
  String? address;
  String? poiweight;
  String? name;
  String? location;
  String? distance;
  String? tel;
  String? type;

  factory GaodePoisModel.fromJson(Map<String, dynamic> json) => GaodePoisModel(
    id: json["id"].toString(),
    direction: json["direction"].toString(),
    businessarea: json["businessarea"].toString(),
    address: json["address"].toString(),
    poiweight: json["poiweight"].toString(),
    name: json["name"].toString(),
    location: json["location"].toString(),
    distance: json["distance"].toString(),
    tel: json["tel"].toString(),
    type: json["type"].toString(),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "direction": direction,
    "businessarea": businessarea,
    "address": address,
    "poiweight": poiweight,
    "name": name,
    "location": location,
    "distance": distance,
    "tel": tel,
    "type": type,
  };
}
