
class StorylineModel {
  String? id;
  String? image;
  int? viewCount;

  StorylineModel({this.id, this.image, this.viewCount});

  StorylineModel.fromJson(Map<String, dynamic> json) {
    if(json["id"] is String) {
      id = json["id"];
    }
    if(json["image"] is String) {
      image = json["image"];
    }
    if(json["viewCount"] is int) {
      viewCount = json["viewCount"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["image"] = image;
    _data["viewCount"] = viewCount;
    return _data;
  }
}