class DiscoverModel {
  String? senderId;
  String? senderImg;
  String? senderName;
  String? timestamp;
  String? contentType;
  String? imgContent;
  String? textContent;
  String? timeAgo;
  String? distance;
  int? likesCount;

  DiscoverModel({
    this.senderId,
    this.senderImg,
    this.senderName,
    this.timestamp,
    this.contentType,
    this.imgContent,
    this.textContent,
    this.timeAgo,
    this.distance,
    this.likesCount,
  });

  static List<DiscoverModel> timeLineData = [
    DiscoverModel(
        senderImg: 'assets/images/rectangle_image_bg.png',
        senderName: 'Ralph Edwards',
        timestamp: 'February 29, 2012',
        contentType: "textonly",
        textContent:
            'Moving to canada was such a hassle, but i finall did it and i am back to onterio. it quite cold here so i will advise to always put on a sweater just in case it gets ugly',
        imgContent: '',
        timeAgo: '@12:01 pm',
        distance: '2km away',
        likesCount: 10),
    DiscoverModel(
        senderImg: 'assets/images/rectangle_image_bg.png',
        senderName: 'Ralph Edwards',
        timestamp: 'February 29, 2012',
        contentType: "image",
        textContent:
            'Moving to canada was such a hassle, but i finall did it and i am back to onterio. it quite cold here so i will advise to always put on a sweater just in case it gets ugly',
        imgContent: 'assets/images/rect_img.png',
        timeAgo: '@12:01 pm',
        distance: '2km away',
        likesCount: 10),
    DiscoverModel(
        senderImg: 'assets/images/rectangle_image_bg.png',
        senderName: 'Ralph Edwards',
        timestamp: 'February 29, 2012',
        contentType: "image",
        textContent:
            'Moving to canada was such a hassle, but i finall did it and i am back to onterio. it quite cold here so i will advise to always put on a sweater just in case it gets ugly',
        imgContent: 'assets/images/rect_img.png',
        timeAgo: '@12:01 pm',
        distance: '2km away',
        likesCount: 10),
  ];
}
