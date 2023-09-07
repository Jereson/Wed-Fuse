// To parse this JSON data, do
//
//     final transHis = transHisFromJson(jsonString);

import 'dart:convert';

TransHis transHisFromJson(String str) => TransHis.fromJson(json.decode(str));

String transHisToJson(TransHis data) => json.encode(data.toJson());

class TransHis {
  String? title;
  String? time;
  String? price;
  String? id;
  String? userId;
  String? amount;
  String? friendId;
  String? type;
  String? status;
  String? createAt;

  TransHis({
     this.title,
     this.time,
     this.price,
     this.id,
     this.userId,
     this.amount,
     this.friendId,
     this.type,
     this.status,
     this.createAt,
  });

  factory TransHis.fromJson(Map<String, dynamic> json) => TransHis(
    title: json["title"],
    time: json["time"],
    price: json["price"],
    id: json["id"],
    userId: json["userId"],
    amount: json["amount"],
    friendId: json["friendId"],
    type: json["type"],
    status: json["status"],
    createAt: json["createAt"],
  );


  Map<String, dynamic> toJson() => {
    "title": title,
    "time": time,
    "price": price,
    "id": id,
    "userId": userId,
    "amount": amount,
    "friendId": friendId,
    "type": type,
    "status": status,
    "createAt": createAt,
  };
}
