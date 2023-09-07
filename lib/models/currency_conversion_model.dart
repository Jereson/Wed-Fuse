
class CurrencyConversionModel {
  bool? success;
  Query? query;
  Info? info;
  String? date;
  double? result;

  CurrencyConversionModel({this.success, this.query, this.info, this.date, this.result});

  CurrencyConversionModel.fromJson(Map<String, dynamic> json) {
    if(json["success"] is bool) {
      success = json["success"];
    }
    if(json["query"] is Map) {
      query = json["query"] == null ? null : Query.fromJson(json["query"]);
    }
    if(json["info"] is Map) {
      info = json["info"] == null ? null : Info.fromJson(json["info"]);
    }
    if(json["date"] is String) {
      date = json["date"];
    }
    if(json["result"] is double) {
      result = json["result"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["success"] = success;
    if(query != null) {
      _data["query"] = query?.toJson();
    }
    if(info != null) {
      _data["info"] = info?.toJson();
    }
    _data["date"] = date;
    _data["result"] = result;
    return _data;
  }
}

class Info {
  int? timestamp;
  double? rate;

  Info({this.timestamp, this.rate});

  Info.fromJson(Map<String, dynamic> json) {
    if(json["timestamp"] is int) {
      timestamp = json["timestamp"];
    }
    if(json["rate"] is double) {
      rate = json["rate"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["timestamp"] = timestamp;
    _data["rate"] = rate;
    return _data;
  }
}

class Query {
  String? from;
  String? to;
  num? amount;

  Query({this.from, this.to, this.amount});

  Query.fromJson(Map<String, dynamic> json) {
    if(json["from"] is String) {
      from = json["from"];
    }
    if(json["to"] is String) {
      to = json["to"];
    }
    if(json["amount"] is num ) {
      amount = json["amount"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["from"] = from;
    _data["to"] = to;
    _data["amount"] = amount;
    return _data;
  }
}