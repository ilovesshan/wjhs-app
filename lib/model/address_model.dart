class AddressModel {
  AddressModel({
    this.id,
    this.userName,
    this.phone,
    this.area,
    this.city,
    this.province,
    this.detailAddress,
    this.longitude,
    this.latitude,
    this.isDefault,
    this.isDelete,
    this.createTime,
  });

  String? id;
  String? userName;
  String? phone;
  String? area;
  String? city;
  String? province;
  String? detailAddress;
  String? longitude;
  String? latitude;
  String? isDefault;
  String? isDelete;
  String? createTime;

  factory AddressModel.fromJson(Map<String, dynamic> json) => AddressModel(
    id: json["id"],
    userName: json["userName"],
    phone: json["phone"],
    area: json["area"],
    city: json["city"],
    province: json["province"],
    detailAddress: json["detailAddress"],
    longitude: json["longitude"],
    latitude: json["latitude"],
    isDefault: json["isDefault"],
    isDelete: json["isDelete"],
    createTime: json["createTime"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "userName": userName,
    "phone": phone,
    "area": area,
    "city": city,
    "province": province,
    "detailAddress": detailAddress,
    "longitude": longitude,
    "latitude": latitude,
    "isDefault": isDefault,
    "isDelete": isDelete,
    "createTime": createTime,
  };
}