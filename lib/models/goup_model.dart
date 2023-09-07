class GroupModel {
  String? name;
  String? groupIcon;
  String? description;
  int? messageCount;

  GroupModel({this.name, this.groupIcon, this.description, this.messageCount});

  static List<GroupModel> groupList = [
    GroupModel(
        name: "Wedding Group",
        groupIcon: "assets/images/h2.png",
        description: "why did you do that",
        messageCount: 2)
  ];
}
