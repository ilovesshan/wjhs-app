class AttachmentModel {
  AttachmentModel({
    this.id,
    this.url,
    this.createByUserId,
    this.createByUserName,
    this.createByUserType,
    this.createTime,
  });

  String? id;
  String? url;
  String? createByUserId;
  String? createByUserName;
  String? createByUserType;
  String? createTime;

  factory AttachmentModel.fromJson(Map<String, dynamic> json) => AttachmentModel(
    id: json["id"].toString(),
    url: json["url"].toString(),
    createByUserId: json["createByUserId"].toString(),
    createByUserName: json["createByUserName"].toString(),
    createByUserType: json["createByUserType"].toString(),
    createTime: json["createTime"].toString(),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "url": url,
    "createByUserId": createByUserId,
    "createByUserName": createByUserName,
    "createByUserType": createByUserType,
    "createTime": createTime,
  };
}