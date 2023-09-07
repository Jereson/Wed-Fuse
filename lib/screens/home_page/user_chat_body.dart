import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/state_manager.dart';
import 'package:sizer/sizer.dart';
import 'package:wedme1/constants/colors.dart';
import 'package:wedme1/getit.dart';
import 'package:wedme1/models/chat_model.dart';
import 'package:wedme1/utils/base_view_builder.dart';
import 'package:wedme1/viewModel/user_reaction.dart';

class UserChatBody extends StatefulWidget {
  final String? recieverId;
  final String? recieverPhoto;
  const UserChatBody({Key? key, this.recieverId, this.recieverPhoto})
      : super(key: key);

  @override
  State<UserChatBody> createState() => _UserChatBodyState();
}

class _UserChatBodyState extends State<UserChatBody> {
  final messages = ChatModel.messages;

  @override
  Widget build(BuildContext context) {
    return BaseViewBuilder<UserReactionVm>(
        model: getIt(),
        initState: (init) {
          init.getChatID(widget.recieverId!);
        },
        builder: (uVm, _) {
          return uVm.userChatId == null
              ? Center(
                  child: CupertinoActivityIndicator(),
                )
              : StreamBuilder<QuerySnapshot>(
                  stream: uVm.getChatById(uVm.userChatId!),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: Text('Laoding..'),
                      );
                    }
                    if (snapshot.hasError) {
                      return Center(
                        child: Text(snapshot.error.toString()),
                      );
                    }
                    final chatData = snapshot.data!.docs;
                    final uid = uVm.firebaseInstance.currentUser!.uid;
                    // print(chatData.length);

                    return Stack(
                      children: <Widget>[
                        snapshot.data!.docs.isEmpty
                            ? const Center(
                                child: Text('Start chat'),
                              )
                            : ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                itemCount: snapshot.data!.docs.length,
                                shrinkWrap: true,
                                padding:
                                    const EdgeInsets.only(top: 10, bottom: 10),
                                itemBuilder: (context, index) {
                                  return "chatData[index]['chatType']" == "text"
                                      ? Container(
                                          padding: const EdgeInsets.only(
                                              left: 14,
                                              right: 14,
                                              top: 10,
                                              bottom: 10),
                                          child: Align(
                                            alignment:
                                                " chatData[0][index]['sender'] " ==
                                                        uid
                                                    ? Alignment.topRight
                                                    : Alignment.topLeft,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    const BorderRadius.only(
                                                        topLeft:
                                                            Radius.circular(50),
                                                        topRight:
                                                            Radius.circular(0),
                                                        bottomLeft:
                                                            Radius.circular(50),
                                                        bottomRight:
                                                            Radius.circular(
                                                                40)),
                                                color:
                                                    "chatData[0][index]['sender']" ==
                                                            uid
                                                        ? Colors.black
                                                        : Colors.grey.shade200,
                                              ),
                                              padding: const EdgeInsets.all(16),
                                              child: Text(
                                                messages[index].messageContent!,
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  color:
                                                      "chatData[0][index] ['sender'] " ==
                                                              uid
                                                          ? Colors.white
                                                          : Colors.black,
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      : Container();
                                  // : Align(
                                  //     alignment: (messages[index].messageType == "receiver"
                                  //         ? Alignment.topLeft
                                  //         : Alignment.topRight),
                                  //     child: Container(
                                  //         decoration: const BoxDecoration(
                                  //           borderRadius: BorderRadius.only(
                                  //               topLeft: Radius.circular(50),
                                  //               topRight: Radius.circular(0),
                                  //               bottomLeft: Radius.circular(50),
                                  //               bottomRight: Radius.circular(40)),
                                  //         ),
                                  //         // padding: const EdgeInsets.all(16),
                                  //         child: ((messages[index].messageType == "receiver"))
                                  //             ? Image.asset("assets/images/audio_in.png")
                                  //             : Image.asset("assets/images/audio_out.png")),
                                  //   );
                                },
                              ),
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Container(
                            padding:
                                const EdgeInsets.only(left: 10, bottom: 10),
                            // height: 60,
                            width: double.infinity,
                            color: Colors.white,
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: Container(
                                    // height: 7.h,
                                    decoration: BoxDecoration(
                                      color: kEditextColor,
                                      border: Border.all(
                                        color: kEditextColor,
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: TextField(
                                      controller: uVm.chatController,
                                      decoration: const InputDecoration(
                                          prefixIcon: ImageIcon(AssetImage(
                                              "assets/icons/emoji_face.png")),
                                          suffixIcon: ImageIcon(
                                            AssetImage(
                                                "assets/icons/audio_icon.png"),
                                            color: Colors.black,
                                          ),
                                          hintText: "Write message...",
                                          hintStyle: TextStyle(
                                              color: Color(0xFF360001)),
                                          border: InputBorder.none),
                                      maxLines: null,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                FloatingActionButton(
                                  onPressed: () {
                                    uVm.chatUser(
                                        receiverId: widget.recieverId,
                                        message: uVm.chatController.text,
                                        chatId: uVm.userChatId,
                                        receiverPhotoUlr: widget.recieverPhoto,
                                        chatType: 'text');
                                  },
                                  backgroundColor: kPrimaryColor,
                                  elevation: 0,
                                  child: const Icon(
                                    Icons.send,
                                    color: Colors.white,
                                    size: 18,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  });
        });
  }
}
