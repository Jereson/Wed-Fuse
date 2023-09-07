class UserModel {
  String? name;
  List<String>? image;
  int? age;
  List<String>? interest;
  List<String>? storylineUrls;
  int? storylineSeenCount;
  String? location;
  String? distance;
  String? course;
  String? schoolName;
  String? marriageReadyNess;
  String? aboutMe;
  String? love;

  UserModel(
      {this.name,
      this.image,
      this.age,
      this.love,
      this.course,
      this.distance,
      this.schoolName,
      this.aboutMe,
      this.marriageReadyNess,
      this.storylineUrls,
      this.interest,
      this.storylineSeenCount,
      this.location});

  static List<UserModel> userList = [
    UserModel(
        name: "Joy",
        image: [
          "assets/images/h1.png",
          "assets/images/h2.png",
        ],
        age: 24,
        interest: ["Football", "Sky diving", "Netflix", "Hiking", "Swimming"],
        storylineUrls: [
          "assets/images/image_one.png",
          "assets/images/image_two.png",
          "assets/images/image_three.png",
          "assets/images/image_four.png",
          "assets/images/image_six.png",
          "assets/images/image_four.png",
        ],
        storylineSeenCount: 200,
        love: "Looking for Something Serious",
        course: "Lawyer",
        distance: "31 miles away",
        schoolName: "Danita University Uk",
        marriageReadyNess: "2 Years",
        aboutMe:
            "Poligraf. Kogisk. Prora. Antikrati. Benade.  All. Serade. Telegram Meganetik. Pseudov. Epint. Pojurad. Bygänade. Vagybel Cirkuläekonomi",
        location: "Port Harcourt"),
    UserModel(
        name: "Glory",
        image: ["assets/images/h2.png", "assets/images/h3.png"],
        age: 21,
        interest: ["Football", "Sky diving", "Netflix", "Hiking", "Swimming"],
        storylineUrls: [
          "assets/images/image_one.png",
          "assets/images/image_two.png",
          "assets/images/image_three.png",
          "assets/images/image_four.png",
          "assets/images/image_six.png",
          "assets/images/image_four.png",
        ],
        storylineSeenCount: 100,
        love: "Looking for Something Serious",
        distance: "12 miles away",
        course: "Lawyer",
        schoolName: "Danita University Uk",
        marriageReadyNess: "2 Years",
        aboutMe:
            "Poligraf. Kogisk. Prora. Antikrati. Benade.  All. Serade. Telegram Meganetik. Pseudov. Epint. Pojurad. Bygänade. Vagybel Cirkuläekonomi",
        location: "Lagos"),
    UserModel(
        name: "Jane",
        image: ["assets/images/h3.png", "assets/images/h4.png"],
        age: 22,
        interest: ["Football", "Sky diving", "Netflix", "Hiking", "Swimming"],
        storylineUrls: [
          "assets/images/image_one.png",
          "assets/images/image_two.png",
          "assets/images/image_three.png",
          "assets/images/image_four.png",
          "assets/images/image_six.png",
          "assets/images/image_four.png",
        ],
        storylineSeenCount: 300,
        love: "Looking for Something Serious",
        course: "Lawyer",
        distance: "81 miles away",
        schoolName: "Danita University Uk",
        marriageReadyNess: "2 Years",
        aboutMe:
            "Poligraf. Kogisk. Prora. Antikrati. Benade.  All. Serade. Telegram Meganetik. Pseudov. Epint. Pojurad. Bygänade. Vagybel Cirkuläekonomi",
        location: "Abuja"),
    UserModel(
        name: "Duke",
        image: ["assets/images/h4.png", "assets/images/h1.png"],
        age: 20,
        interest: ["Football", "Sky diving", "Netflix", "Hiking", "Swimming"],
        storylineUrls: [
          "assets/images/image_one.png",
          "assets/images/image_two.png",
          "assets/images/image_three.png",
          "assets/images/image_four.png",
          "assets/images/image_six.png",
          "assets/images/image_four.png",
        ],
        storylineSeenCount: 300,
        love: "Looking for Something serious",
        distance: "12 miles away",
        course: "Lawyer",
        schoolName: "Danita University Uk",
        marriageReadyNess: "2 Years",
        aboutMe:
            "Poligraf. Kogisk. Prora. Antikrati. Benade.  All. Serade. Telegram Meganetik. Pseudov. Epint. Pojurad. Bygänade. Vagybel Cirkuläekonomi",
        location: "Abuja"),
    UserModel(
        name: "Sam",
        image: ["assets/images/h2.png", "assets/images/h3.png"],
        age: 19,
        interest: ["Football", "Sky diving", "Netflix", "Hiking", "Swimming"],
        storylineUrls: [
          "assets/images/image_one.png",
          "assets/images/image_two.png",
          "assets/images/image_three.png",
          "assets/images/image_four.png",
          "assets/images/image_six.png",
          "assets/images/image_four.png",
        ],
        storylineSeenCount: 300,
        love: "Looking for Something Serious",
        distance: "16 miles away",
        course: "Lawyer",
        schoolName: "Danita University Uk",
        marriageReadyNess: "2 Years",
        aboutMe:
            "Poligraf. Kogisk. Prora. Antikrati. Benade.  All. Serade. Telegram Meganetik. Pseudov. Epint. Pojurad. Bygänade. Vagybel Cirkuläekonomi",
        location: "Abuja"),
    UserModel(
        name: "Peace",
        image: ["assets/images/h3.png", "assets/images/h4.png"],
        age: 24,
        interest: ["Football", "Sky diving", "Netflix", "Hiking", "Swimming"],
        storylineUrls: [
          "assets/images/image_one.png",
          "assets/images/image_two.png",
          "assets/images/image_three.png",
          "assets/images/image_four.png",
          "assets/images/image_six.png",
          "assets/images/image_four.png",
        ],
        storylineSeenCount: 300,
        love: "Looking for Something Serious",
        course: "Lawyer",
        distance: "21 miles away",
        schoolName: "Danita University Uk",
        marriageReadyNess: "2 Years",
        aboutMe:
            "Poligraf. Kogisk. Prora. Antikrati. Benade.  All. Serade. Telegram Meganetik. Pseudov. Epint. Pojurad. Bygänade. Vagybel Cirkuläekonomi",
        location: "Lagos"),
  ];
}
