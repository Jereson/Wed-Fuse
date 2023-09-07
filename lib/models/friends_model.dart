
class FriendsModel {
  String? id;
  List<dynamic>? member;
  String? senderId;
  String? senderName;
  String? senderPhoto;
  String? senderPhone;
  String? receiverId;
  String? receiverName;
  String? receiverPhoto;
  String? receiverPhone;
  String? status;
  String? date;

  FriendsModel({this.id, this.member, this.senderId, this.senderName, this.senderPhoto, this.senderPhone, this.receiverId, this.receiverName, this.receiverPhoto, this.receiverPhone, this.status, this.date});

  FriendsModel.fromJson(Map<String, dynamic> json) {
    if(json["id"] is String) {
      id = json["id"];
    }
    if(json["member"] is List) {
      member = json["member"] ?? [];
    }
    if(json["senderId"] is String) {
      senderId = json["senderId"];
    }
    if(json["senderName"] is String) {
      senderName = json["senderName"];
    }
    if(json["senderPhoto"] is String) {
      senderPhoto = json["senderPhoto"];
    }
    if(json["senderPhone"] is String) {
      senderPhone = json["senderPhone"];
    }
    if(json["receiverId"] is String) {
      receiverId = json["receiverId"];
    }
    if(json["receiverName"] is String) {
      receiverName = json["receiverName"];
    }
    if(json["receiverPhoto"] is String) {
      receiverPhoto = json["receiverPhoto"];
    }
    if(json["receiverPhone"] is String) {
      receiverPhone = json["receiverPhone"];
    }
    if(json["status"] is String) {
      status = json["status"];
    }
    if(json["date"] is String) {
      date = json["date"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    if(member != null) {
      _data["member"] = member;
    }
    _data["senderId"] = senderId;
    _data["senderName"] = senderName;
    _data["senderPhoto"] = senderPhoto;
    _data["senderPhone"] = senderPhone;
    _data["receiverId"] = receiverId;
    _data["receiverName"] = receiverName;
    _data["receiverPhoto"] = receiverPhoto;
    _data["receiverPhone"] = receiverPhone;
    _data["status"] = status;
    _data["date"] = date;
    return _data;
  }
}