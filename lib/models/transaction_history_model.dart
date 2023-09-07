
class TransactionHistoryModel {
  String? id;
  String? coin;
  String? amount;
  String? userId;
  String? friendId;
  String? type;
  String? status;
  String? creatdAt;

  TransactionHistoryModel({this.id, this.coin, this.amount, this.userId, this.friendId, this.type, this.status, this.creatdAt});

  TransactionHistoryModel.fromJson(Map<String, dynamic> json) {
    if(json["id"] is String) {
      id = json["id"];
    }
    if(json["coin"] is String) {
      coin = json["coin"];
    }
    if(json["amount"] is String) {
      amount = json["amount"];
    }
    if(json["userId"] is String) {
      userId = json["userId"];
    }
    if(json["friendId"] is String) {
      friendId = json["friendId"];
    }
    if(json["type"] is String) {
      type = json["type"];
    }
    if(json["status"] is String) {
      status = json["status"];
    }
    if(json["creatdAt"] is String) {
      creatdAt = json["creatdAt"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["coin"] = coin;
    _data["amount"] = amount;
    _data["userId"] = userId;
    _data["friendId"] = friendId;
    _data["type"] = type;
    _data["status"] = status;
    _data["creatdAt"] = creatdAt;
    return _data;
  }
}