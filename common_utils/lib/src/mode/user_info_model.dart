/// 用户信息实体类
class UserInfoModel {
  UserInfoModel({
    this.id,
    this.account,
    this.name,
    this.workno,
    this.sex,
    this.mobile,
    this.orgId,
    this.staffId,
    this.birthday,
    this.seq,
    this.remark,
    this.state,
    this.isonline,
    this.deleted,
    this.signature,
    this.orgCode,
    this.orgName,
    this.factoryCode,
    this.role,
    this.lastLoginTime,
    this.inctime,
    this.leavedate,
    this.factoryName,
    this.penglishname,
    this.trueFactory,
    this.easAccount,
    this.outkind,
    this.legalPsonCode,
  });

  String? id;
  String? account;
  String? name;
  String? workno;
  String? sex;
  String? mobile;
  String? orgId;
  String? staffId;
  String? birthday;
  String? seq;
  String? remark;
  int? state;
  int? isonline;
  int? deleted;
  String? signature;
  String? orgCode;
  String? orgName;
  String? factoryCode;
  String? role;
  dynamic? lastLoginTime;
  dynamic? inctime;
  dynamic? leavedate;
  String? factoryName;
  String? penglishname;
  String? trueFactory;
  dynamic? easAccount;
  dynamic? outkind;
  String? legalPsonCode;

  factory UserInfoModel.fromJson(Map<String, dynamic> json) => UserInfoModel(
    id: json["id"],
    account: json["account"],
    name: json["name"],
    workno: json["workno"],
    sex: json["sex"],
    mobile: json["mobile"],
    orgId: json["orgId"],
    staffId: json["staffId"],
    birthday: json["birthday"],
    seq: json["seq"].toString(),
    remark: json["remark"],
    state: json["state"],
    isonline: json["isonline"],
    deleted: json["deleted"],
    signature: json["signature"],
    orgCode: json["orgCode"],
    orgName: json["orgName"],
    factoryCode: json["factoryCode"],
    role: json["role"],
    lastLoginTime: json["lastLoginTime"],
    inctime: json["inctime"],
    leavedate: json["leavedate"],
    factoryName: json["factoryName"],
    penglishname: json["penglishname"],
    trueFactory: json["trueFactory"],
    easAccount: json["easAccount"],
    outkind: json["outkind"],
    legalPsonCode: json["legalPsonCode"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "account": account,
    "name": name,
    "workno": workno,
    "sex": sex,
    "mobile": mobile,
    "orgId": orgId,
    "staffId": staffId,
    "birthday": birthday,
    "seq": seq.toString(),
    "remark": remark,
    "state": state,
    "isonline": isonline,
    "deleted": deleted,
    "signature": signature,
    "orgCode": orgCode,
    "orgName": orgName,
    "factoryCode": factoryCode,
    "role": role,
    "lastLoginTime": lastLoginTime,
    "inctime": inctime,
    "leavedate": leavedate,
    "factoryName": factoryName,
    "penglishname": penglishname,
    "trueFactory": trueFactory,
    "easAccount": easAccount,
    "outkind": outkind,
    "legalPsonCode": legalPsonCode,
  };
}