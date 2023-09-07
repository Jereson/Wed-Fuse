class UsersDetailModel {
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
  List<dynamic>? bannerPic;
  List<dynamic>? altBannerPic;
  bool? isVerified;
  bool? isOnline;
  num? age;
  String? birthDay;
  String? birthMonth;
  String? birthYear;
  num? lat;
  num? lng;
  num? balance;
  String? course;
  String? schoolName;
  String? marriageRadyness;
  String? aboutMe;
  String? love;
  String? preference;
  int? storylineCount;
  String? job;
  List<dynamic>? images;
  List<dynamic>? interest;
  List<dynamic>? dislike;
  List<dynamic>? inviteList;
  List<dynamic>? friends;
  String? latestChat;
  String? state;
  String? interestedIn;
  String? fcbToken;
  num? coinBalance;
  String? subscriptionDuration;
  String? subsctiotionStartDate;
  String? subscriptionDueDate;
  String? subscriptionAmont;
  String? subscriptionType;
  String? currencyType;

  UsersDetailModel(
      {this.displayName,
      this.fullName,
      this.email,
      this.photoUrl,
      this.phoneNumber,
      this.userId,
      this.signUpMethod,
      this.authverified,
      this.createdAt,
      this.otp,
      this.countryCode,
      this.identityType,
      this.identityLink,
      this.country,
      this.city,
      this.religion,
      this.genoType,
      this.temperament,
      this.choice,
      this.bannerPic,
      this.altBannerPic,
      this.isVerified,
      this.isOnline,
      this.age,
      this.birthDay,
      this.birthMonth,
      this.birthYear,
      this.lat,
      this.lng,
      this.balance,
      this.course,
      this.schoolName,
      this.marriageRadyness,
      this.aboutMe,
      this.love,
      this.preference,
      this.storylineCount,
      this.job,
      this.images,
      this.interest,
      this.dislike,
      this.inviteList,
      this.friends,
      this.latestChat,
      this.state,
      this.interestedIn,
      this.fcbToken,
      this.coinBalance,
      this.subscriptionDuration,
      this.subsctiotionStartDate,
      this.subscriptionDueDate,
      this.subscriptionAmont,
      this.subscriptionType,
      this.currencyType});

  UsersDetailModel.fromJson(Map<String, dynamic> json) {
    if (json["displayName"] is String) {
      displayName = json["displayName"];
    }
    if (json["fullName"] is String) {
      fullName = json["fullName"];
    }
    if (json["email"] is String) {
      email = json["email"];
    }
    if (json["photoUrl"] is String) {
      photoUrl = json["photoUrl"];
    }
    if (json["phoneNumber"] is String) {
      phoneNumber = json["phoneNumber"];
    }
    if (json["userId"] is String) {
      userId = json["userId"];
    }
    if (json["signUpMethod"] is String) {
      signUpMethod = json["signUpMethod"];
    }
    if (json["authverified"] is String) {
      authverified = json["authverified"];
    }
    if (json["createdAt"] is String) {
      createdAt = json["createdAt"];
    }
    if (json["otp"] is String) {
      otp = json["otp"];
    }
    if (json["countryCode"] is String) {
      countryCode = json["countryCode"];
    }
    if (json["identityType"] is String) {
      identityType = json["identityType"];
    }
    if (json["identityLink"] is String) {
      identityLink = json["identityLink"];
    }
    if (json["country"] is String) {
      country = json["country"];
    }
    if (json["city"] is String) {
      city = json["city"];
    }
    if (json["religion"] is String) {
      religion = json["religion"];
    }
    if (json["genoType"] is String) {
      genoType = json["genoType"];
    }
    if (json["temperament"] is String) {
      temperament = json["temperament"];
    }
    if (json["choice"] is String) {
      choice = json["choice"];
    }
    if (json["bannerPic"] is List) {
      bannerPic = json["bannerPic"] ?? [];
    }
    if (json["altBannerPic"] is List) {
      altBannerPic = json["altBannerPic"] ?? [];
    }

    if (json["isVerified"] is bool) {
      isVerified = json["isVerified"];
    }
    if (json["isOnline"] is bool) {
      isOnline = json["isOnline"];
    }
    if (json["age"] is num) {
      age = json["age"];
    }
    if (json["birthDay"] is String) {
      birthDay = json["birthDay"];
    }
    if (json["birthMonth"] is String) {
      birthMonth = json["birthMonth"];
    }
    if (json["birthYear"] is String) {
      birthYear = json["birthYear"];
    }
    if (json["lat"] is num) {
      lat = json["lat"];
    }
    if (json["lng"] is num) {
      lng = json["lng"];
    }
    if (json["balance"] is num) {
      balance = json["balance"];
    }
    if (json["course"] is String) {
      course = json["course"];
    }
    if (json["schoolName"] is String) {
      schoolName = json["schoolName"];
    }
    if (json["marriageRadyness"] is String) {
      marriageRadyness = json["marriageRadyness"];
    }
    if (json["aboutMe"] is String) {
      aboutMe = json["aboutMe"];
    }
    if (json["love"] is String) {
      love = json["love"];
    }
    if (json["preference"] is String) {
      preference = json["preference"];
    }
    if (json["storylineCount"] is int) {
      storylineCount = json["storylineCount"];
    }
    if (json["job"] is String) {
      job = json["job"];
    }
    if (json["images"] is List) {
      images = json["images"] ?? [];
    }
    if (json["interest"] is List) {
      interest = json["interest"] ?? [];
    }
    if (json["dislike"] is List) {
      dislike = json["dislike"] ?? [];
    }
    if (json["inviteList"] is List) {
      inviteList = json["inviteList"] ?? [];
    }

    if (json["friends"] is List) {
      friends = json["friends"] ?? [];
    }

    if (json["LatestChat"] is String) {
      latestChat = json["LatestChat"];
    }
    if (json["state"] is String) {
      state = json["state"];
    }
    if (json["interestedIn"] is String) {
      interestedIn = json["interestedIn"];
    }
    if (json["fcbToken"] is String) {
      fcbToken = json["fcbToken"];
    }
    if (json["coinBalance"] is num) {
      coinBalance = json["coinBalance"];
    }

     if (json["subscriptionDuration"] is String) {
      subscriptionDuration = json["subscriptionDuration"];
    }
     if (json["subsctiotionStartDate"] is String) {
      subsctiotionStartDate = json["subsctiotionStartDate"];
    }
     if (json["subscriptionDueDate"] is String) {
      subscriptionDueDate = json["subscriptionDueDate"];
    }
     if (json["subscriptionAmont"] is String) {
      subscriptionAmont = json["subscriptionAmont"];
    }
     if (json["subscriptionType"] is String) {
      subscriptionType = json["subscriptionType"];
    }
     if (json["currencyType"] is String) {
      currencyType = json["currencyType"];
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
    _data["altBannerPic"] = altBannerPic;
    _data["isVerified"] = isVerified;
    _data["isOnline"] = isOnline;
    _data["age"] = age;
    _data["birthDay"] = birthDay;
    _data["birthMonth"] = birthMonth;
    _data["birthYear"] = birthYear;
    _data["lat"] = lat;
    _data["lng"] = lng;
    _data["balance"] = balance;
    _data["course"] = course;
    _data["schoolName"] = schoolName;
    _data["marriageRadyness"] = marriageRadyness;
    _data["aboutMe"] = aboutMe;
    _data["love"] = love;
    _data["preference"] = preference;
    _data["storylineCount"] = storylineCount;
    _data["job"] = job;
    _data["state"] = state;
    _data["LatestChat"] = latestChat;
    _data["interestedIn"] = interestedIn;
    _data["fcbToken"] = fcbToken;
    _data["coinBalance"] = coinBalance;

    _data["subscriptionDuration"] = subscriptionDuration;
    _data["subsctiotionStartDate"] = subsctiotionStartDate;
    _data["subscriptionDueDate"] = subscriptionDueDate;
    _data["subscriptionAmont"] = subscriptionAmont;
    _data["subscriptionType"] = subscriptionType;
    _data["currencyType"] = currencyType;


    if (images != null) {
      _data["images"] = images;
    }
    if (interest != null) {
      _data["interest"] = interest;
    }
    if (dislike != null) {
      _data["dislike"] = dislike;
    }
    if (inviteList != null) {
      _data["inviteList"] = inviteList;
    }
    if (friends != null) {
      _data["friends"] = friends;
    }
    return _data;
  }
}
