class LiveModel {
  String? senderId;
  String? senderName;
  String? senderImg;
  String? liveUrl;

  LiveModel({
    this.senderId,
    this.senderName,
    this.senderImg,
    this.liveUrl,
  });

  static List<LiveModel> liveModelData = [
    LiveModel(
        senderName: "Jessica", senderImg: "assets/images/h1.png", liveUrl: ""),
    LiveModel(
        senderName: "Ruth", senderImg: "assets/images/h2.png", liveUrl: ""),
    LiveModel(
        senderName: "Jessica", senderImg: "assets/images/h3.png", liveUrl: ""),
    LiveModel(
        senderName: "Ruth", senderImg: "assets/images/h4.png", liveUrl: ""),
    LiveModel(
        senderName: "Wike", senderImg: "assets/images/h2.png", liveUrl: ""),
    LiveModel(
      senderName: "Ruth",
      senderImg: "assets/images/h1.png",
      liveUrl: "",
    ),
    LiveModel(
        senderName: "Ralph", senderImg: "assets/images/h3.png", liveUrl: ""),
    LiveModel(
        senderName: "Jessica",
        senderImg: "assets/images/rectangle_image_bg.png",
        liveUrl: ""),
    LiveModel(
        senderName: "Ruth",
        senderImg: "assets/images/rectangle_image_bg.png",
        liveUrl: ""),
    LiveModel(
        senderName: "Wike",
        senderImg: "assets/images/rectangle_image_bg.png",
        liveUrl: ""),
    LiveModel(
      senderName: "Ruth",
      senderImg: "assets/images/rectangle_image_bg.png",
      liveUrl: "",
    ),
  ];
}
