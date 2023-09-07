

class UserModel {
  String? displayName;
  String? fullName;
  String? email;
  String? photoUrl;
  String? phoneNumber;
  String? userId;
  String? signUpMethod;
  String? authverified;
  String? createdAt;
  String? otp;
  String? countryCode;
  String? identityType;
  String? identityLink;
  String? country;
  String? city;
  String? religion;
  String? genoType;
  String? temperament;
  String? choice;
  String? bannerPic;
  bool? isVerified;
  bool? isOnline;
  int? age;
  int? lat;
  int? lng;
  int? balance;
  String? course;
  String? schoolName;
  String? marriageRadyness;
  String? aboutMe;
  String? love;
  int? storylineCount;
  List<dynamic>? images;
  List<dynamic>? interest;
  List<dynamic>? storylineUrls;

  UserModel({this.displayName, this.fullName, this.email, this.photoUrl, this.phoneNumber, this.userId, this.signUpMethod, this.authverified, this.createdAt, this.otp, this.countryCode, this.identityType, this.identityLink, this.country, this.city, this.religion, this.genoType, this.temperament, this.choice, this.bannerPic, this.isVerified, this.isOnline, this.age, this.lat, this.lng, this.balance, this.course, this.schoolName, this.marriageRadyness, this.aboutMe, this.love, this.storylineCount, this.images, this.interest, this.storylineUrls});

  UserModel.fromJson(Map<String, dynamic> json) {
    if(json["displayName"] is String) {
      displayName = json["displayName"];
    }
    if(json["fullName"] is String) {
      fullName = json["fullName"];
    }
    if(json["email"] is String) {
      email = json["email"];
    }
    if(json["photoUrl"] is String) {
      photoUrl = json["photoUrl"];
    }
    if(json["phoneNumber"] is String) {
      phoneNumber = json["phoneNumber"];
    }
    if(json["userId"] is String) {
      userId = json["userId"];
    }
    if(json["signUpMethod"] is String) {
      signUpMethod = json["signUpMethod"];
    }
    if(json["authverified"] is String) {
      authverified = json["authverified"];
    }
    if(json["createdAt"] is String) {
      createdAt = json["createdAt"];
    }
    if(json["otp"] is String) {
      otp = json["otp"];
    }
    if(json["countryCode"] is String) {
      countryCode = json["countryCode"];
    }
    if(json["identityType"] is String) {
      identityType = json["identityType"];
    }
    if(json["identityLink"] is String) {
      identityLink = json["identityLink"];
    }
    if(json["country"] is String) {
      country = json["country"];
    }
    if(json["city"] is String) {
      city = json["city"];
    }
    if(json["religion"] is String) {
      religion = json["religion"];
    }
    if(json["genoType"] is String) {
      genoType = json["genoType"];
    }
    if(json["temperament"] is String) {
      temperament = json["temperament"];
    }
    if(json["choice"] is String) {
      choice = json["choice"];
    }
    if(json["bannerPic"] is String) {
      bannerPic = json["bannerPic"];
    }
    if(json["isVerified"] is bool) {
      isVerified = json["isVerified"];
    }
    if(json["isOnline"] is bool) {
      isOnline = json["isOnline"];
    }
    if(json["age"] is int) {
      age = json["age"];
    }
    if(json["lat"] is int) {
      lat = json["lat"];
    }
    if(json["lng"] is int) {
      lng = json["lng"];
    }
    if(json["balance"] is int) {
      balance = json["balance"];
    }
    if(json["course"] is String) {
      course = json["course"];
    }
    if(json["schoolName"] is String) {
      schoolName = json["schoolName"];
    }
    if(json["marriageRadyness"] is String) {
      marriageRadyness = json["marriageRadyness"];
    }
    if(json["aboutMe"] is String) {
      aboutMe = json["aboutMe"];
    }
    if(json["love"] is String) {
      love = json["love"];
    }
    if(json["storylineCount"] is int) {
      storylineCount = json["storylineCount"];
    }
    if(json["images"] is List) {
      images = json["images"] ?? [];
    }
    if(json["interest"] is List) {
      interest = json["interest"] ?? [];
    }
    if(json["storylineUrls"] is List) {
      storylineUrls = json["storylineUrls"] ?? [];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["displayName"] = displayName;
    _data["fullName"] = fullName;
    _data["email"] = email;
    _data["photoUrl"] = photoUrl;
    _data["phoneNumber"] = phoneNumber;
    _data["userId"] = userId;
    _data["signUpMethod"] = signUpMethod;
    _data["authverified"] = authverified;
    _data["createdAt"] = createdAt;
    _data["otp"] = otp;
    _data["countryCode"] = countryCode;
    _data["identityType"] = identityType;
    _data["identityLink"] = identityLink;
    _data["country"] = country;
    _data["city"] = city;
    _data["religion"] = religion;
    _data["genoType"] = genoType;
    _data["temperament"] = temperament;
    _data["choice"] = choice;
    _data["bannerPic"] = bannerPic;
    _data["isVerified"] = isVerified;
    _data["isOnline"] = isOnline;
    _data["age"] = age;
    _data["lat"] = lat;
    _data["lng"] = lng;
    _data["balance"] = balance;
    _data["course"] = course;
    _data["schoolName"] = schoolName;
    _data["marriageRadyness"] = marriageRadyness;
    _data["aboutMe"] = aboutMe;
    _data["love"] = love;
    _data["storylineCount"] = storylineCount;
    if(images != null) {
      _data["images"] = images;
    }
    if(interest != null) {
      _data["interest"] = interest;
    }
    if(storylineUrls != null) {
      _data["storylineUrls"] = storylineUrls;
    }
    return _data;
  }
}