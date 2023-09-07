class LikeModel {
  int? age;
  bool? isVerified;
  String? city;
  int? lat;
  int? lng;
  String? photoUrl;
  String? uid;
  String? userName;

  LikeModel(
      {this.age,
      this.isVerified,
      this.city,
      this.lat,
      this.lng,
      this.photoUrl,
      this.uid,
      this.userName});

  LikeModel.fromJson(Map<String, dynamic> json) {
    if (json["age"] is int) {
      age = json["age"];
    }
    
     if (json["isVerified"] is bool) {
      isVerified = json["isVerified"];
    }
    if (json["city"] is String) {
      city = json["city"];
    }
    if (json["lat"] is int) {
      lat = json["lat"];
    }
    if (json["lng"] is int) {
      lng = json["lng"];
    }
    if (json["photoUrl"] is String) {
      photoUrl = json["photoUrl"];
    }
    if (json["uid"] is String) {
      uid = json["uid"];
    }
    if (json["userName"] is String) {
      userName = json["userName"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["age"] = age;
    _data["isVerified"] = isVerified;
    
    _data["city"] = city;
    _data["lat"] = lat;
    _data["lng"] = lng;
    _data["photoUrl"] = photoUrl;
    _data["uid"] = uid;
    _data["userName"] = userName;
    return _data;
  }
}
