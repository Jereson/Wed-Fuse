class MessageModel {
  String? userId;
  String? userName;
  bool? isOnline;
  String? userImage;
  String? timeAgo;
  String? message;
  int? messageCount;
  bool? delivered;

  MessageModel(
      {this.userId,
      this.userName,
      this.isOnline,
      this.userImage,
      this.timeAgo,
      this.message,
      this.messageCount,
      this.delivered});

  static List<MessageModel> messageList = [
    MessageModel(
      userId: "1",
      userName: "Theresa Webb",
      isOnline: false,
      userImage: 'assets/images/image_one.png',
      timeAgo: "15:20",
      message: "why did you do that?",
      messageCount: 2,
      delivered: true,
    ),
    MessageModel(
      userId: "2",
      userName: "Kerna Navida",
      isOnline: false,
      userImage: 'assets/images/image_two.png',
      timeAgo: "15:13",
      message: "why did you do that?",
      messageCount: 2,
      delivered: true,
    ),
    MessageModel(
      userId: "3",
      userName: "Linda Webb",
      isOnline: false,
      userImage: 'assets/images/image_three.png',
      timeAgo: "15:30",
      message: "why did you do that?",
      messageCount: 2,
      delivered: false,
    ),
    MessageModel(
      userId: "4",
      userName: "Shoam Henry",
      isOnline: true,
      userImage: 'assets/images/image_four.png',
      timeAgo: "15:30",
      message: "why did you do that?",
      messageCount: 2,
      delivered: false,
    ),
    MessageModel(
      userId: "5",
      userName: "Lola",
      isOnline: true,
      userImage: 'assets/images/image_one.png',
      timeAgo: "15:30",
      message: "why did you do that?",
      messageCount: 2,
      delivered: true,
    ),
    MessageModel(
      userId: "6",
      userName: "Merian",
      isOnline: true,
      userImage: "assets/images/rectangle_image_bg.png",
      timeAgo: "15:30",
      message: "why did you do that?",
      messageCount: 2,
      delivered: false,
    ),
    MessageModel(
      userId: "7",
      userName: "Theresa Webb",
      isOnline: false,
      userImage: 'assets/images/image_one.png',
      timeAgo: "15:20",
      message: "why did you do that?",
      messageCount: 2,
      delivered: true,
    ),
    MessageModel(
      userId: "8",
      userName: "Kerna Navida",
      isOnline: false,
      userImage: 'assets/images/image_two.png',
      timeAgo: "15:13",
      message: "why did you do that?",
      messageCount: 2,
      delivered: true,
    ),
    MessageModel(
      userId: "9",
      userName: "Theresa Webb",
      isOnline: false,
      userImage: 'assets/images/image_one.png',
      timeAgo: "15:20",
      message: "why did you do that?",
      messageCount: 2,
      delivered: true,
    ),
    MessageModel(
      userId: "10",
      userName: "Kerna Navida",
      isOnline: false,
      userImage: 'assets/images/image_two.png',
      timeAgo: "15:13",
      message: "why did you do that?",
      messageCount: 2,
      delivered: true,
    ),
  ];
}
