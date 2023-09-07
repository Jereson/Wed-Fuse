import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationModel {
  String? id;
  String? message;
  String? senderId;
  String? status;
  String? type;
  String? userId;
  String? userName;
  String? date;
  String? image;

  NotificationModel(
      {this.id,
      this.message,
      this.senderId,
      this.status,
      this.type,
      this.userId,
      this.userName,
      this.date, this.image});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    if (json["id"] is String) {
      id = json["id"];
    }
    if (json["message"] is String) {
      message = json["message"];
    }
    if (json["senderId"] is String) {
      senderId = json["senderId"];
    }
    if (json["status"] is String) {
      status = json["status"];
    }
    if (json["type"] is String) {
      type = json["type"];
    }
    if (json["userId"] is String) {
      userId = json["userId"];
    }
    if (json["userName"] is String) {
      userName = json["userName"];
    }
    if (json["date"] is String) {
      date = json["date"];
    }
     if (json["image"] is String) {
      image = json["image"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["message"] = message;
    _data["senderId"] = senderId;
    _data["status"] = status;
    _data["type"] = type;
    _data["userId"] = userId;
    _data["userName"] = userName;
    _data["date"] = date;
    _data["image"] = image;
    return _data;
  }
}
