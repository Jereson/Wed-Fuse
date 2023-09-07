class ChatModel {
  String? messageContent;
  String? messageType;
  String? contentType;

  ChatModel({this.messageContent, this.messageType, this.contentType});

  static List<ChatModel> messages = [
    ChatModel(
        messageContent: "my fear of stairs is escalating",
        contentType: "text",
        messageType: "sender"),
    ChatModel(
        messageContent: "cheerful cowboy make jolly ranges",
        contentType: "text",
        messageType: "receiver"),
    ChatModel(
        messageContent: "my fear of stairs is escalating",
        contentType: "text",
        messageType: "sender"),
    ChatModel(
        messageContent: "my fear of stairs is escalating",
        contentType: "text",
        messageType: "sender"),
    ChatModel(
        messageContent: "cheerful cowboy make jolly ranges",
        contentType: "audio",
        messageType: "sender"),
    ChatModel(
        messageContent: "cheerful cowboy make jolly ranges",
        contentType: "audio",
        messageType: "receiver"),
    ChatModel(
        messageContent: "my fear of stairs is escalating",
        contentType: "text",
        messageType: "sender"),
    ChatModel(
        messageContent: "my fear of stairs is escalating",
        contentType: "text",
        messageType: "receiver"),
    ChatModel(
        messageContent: "cheerful cowboy make jolly ranges",
        contentType: "audio",
        messageType: "receiver"),
    ChatModel(
        messageContent: "cheerful cowboy make jolly ranges",
        contentType: "audio",
        messageType: "sender"),
    ChatModel(
        messageContent: "my fear of stairs is escalating",
        contentType: "text",
        messageType: "receiver"),
    ChatModel(
        messageContent: "cheerful cowboy make jolly ranges",
        contentType: "text",
        messageType: "receiver"),
    ChatModel(
        messageContent: "my fear of stairs is escalating",
        contentType: "text",
        messageType: "sender"),
  ];
}
