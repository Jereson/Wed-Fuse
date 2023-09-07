// To parse this JSON data, do
//
//     final chooseAccountClass = chooseAccountClassFromJson(jsonString);

import 'dart:convert';

ChooseAccountClass chooseAccountClassFromJson(String str) => ChooseAccountClass.fromJson(json.decode(str));

String chooseAccountClassToJson(ChooseAccountClass data) => json.encode(data.toJson());

class ChooseAccountClass {
  String bankName;
  String accountNumber;
  String accountName;
  String id;
  String userId;

  ChooseAccountClass({
    required this.bankName,
    required this.accountNumber,
    required this.accountName,
    required this.id,
    required this.userId,
  });

  factory ChooseAccountClass.fromJson(Map<String, dynamic> json) => ChooseAccountClass(
    bankName: json["bankName"],
    accountNumber: json["accountNumber"],
    accountName: json["accountName"],
    id: json["id"],
    userId: json["userId"],
  );

  Map<String, dynamic> toJson() => {
    "bankName": bankName,
    "accountNumber": accountNumber,
    "accountName": accountName,
    "id": id,
    "userId": userId,
  };
}
