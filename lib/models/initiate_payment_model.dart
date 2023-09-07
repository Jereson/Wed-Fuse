
class InitiatePaymentModel {
  String? status;
  String? message;
  Data? data;

  InitiatePaymentModel({this.status, this.message, this.data});

  InitiatePaymentModel.fromJson(Map<String, dynamic> json) {
    if(json["status"] is String) {
      status = json["status"];
    }
    if(json["message"] is String) {
      message = json["message"];
    }
    if(json["data"] is Map) {
      data = json["data"] == null ? null : Data.fromJson(json["data"]);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["status"] = status;
    _data["message"] = message;
    if(data != null) {
      _data["data"] = data?.toJson();
    }
    return _data;
  }
}

class Data {
  String? link;

  Data({this.link});

  Data.fromJson(Map<String, dynamic> json) {
    if(json["link"] is String) {
      link = json["link"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["link"] = link;
    return _data;
  }
}