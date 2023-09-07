import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../Call/ZegCall/GroupAudioCall.dart';
import '../../Call/ZegCall/GroupVideoCall.dart';
import '../../getit.dart';
import '../../utils/base_view_builder.dart';
import '../../viewModel/profile_vm.dart';
import '/screens/chat_screens/video_call.dart';
import '/screens/chat_screens/voice_call.dart';
import '../../constants/colors.dart';
import 'AddUsers/GroupChat.dart';
import 'groupConversationBody.dart';

class GroupConversationScreen extends StatefulWidget {
  const GroupConversationScreen({
    Key? key,
    required this.profilePix,
    required this.userNameD,
    required this.online,
    required this.idChat,
    required this.groupId,
    required this.ide,
    required this.chatId, required this.callId,
  }) : super(key: key);
  final String profilePix;
  final String userNameD;
  final String idChat;
  final String callId;
  final String online;
  final String groupId;
  final String chatId;
  final String ide;

  @override
  State<GroupConversationScreen> createState() =>
      _GroupConversationScreenState();
}

class _GroupConversationScreenState extends State<GroupConversationScreen> {
  _GroupConversationScreenState();

  @override
  Widget build(BuildContext context) {
    return BaseViewBuilder<ProfileViewModel>(
        model: getIt(),
        builder: (pVm, _) {
        return Scaffold(
            appBar: AppBar(
              elevation: 0,
              automaticallyImplyLeading: false,
              backgroundColor: Colors.white,
              flexibleSpace: SafeArea(
                child: Container(
                  padding: const EdgeInsets.only(right: 4, top: 6),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                              onPressed: () {
                                FirebaseFirestore.instance
                                    .collection("groupChat")
                                    .doc(widget.idChat)
                                    .update({"count": 0});
                                Navigator.of(context).pop();
                              },
                              icon: const Icon(
                                Icons.arrow_back_ios,
                              )),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ChatGroupAdd(
                                      groupImg: widget.profilePix,
                                      groupName: widget.userNameD,
                                      groupId: widget.groupId, userId: widget.ide,
                                    ),
                                  ));
                            },
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 20,
                                  backgroundImage:
                                      NetworkImage(widget.profilePix),
                                  child: widget.online == "online"
                                      ? Stack(
                                          children: const [
                                            Positioned(
                                              bottom: -10,
                                              right: -12,
                                              child: CircleAvatar(
                                                  radius: 18,
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  child: Image(
                                                      image: AssetImage(
                                                          "assets/icons/online_icon.png"))),
                                            ),
                                          ],
                                        )
                                      : Container(),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  child: Text(
                                    widget.userNameD,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14.sp,
                                    )),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 30,
                            height: 30,
                            decoration: const BoxDecoration(
                                color: kPrimaryColor,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10),
                                )),
                            margin: const EdgeInsets.all(10),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: ((context) =>
                                         GroupAudioCallPage(username: pVm.cachedUserDetail!.displayName!, chatId: pVm.cachedUserDetail!.displayName!, callId: widget.callId,))));
                              },
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(80),
                                  child: const Image(
                                      image: AssetImage(
                                          "assets/icons/phone_icon.png"))),
                            ),
                          ),
                          Container(
                            width: 30,
                            height: 30,
                            decoration: const BoxDecoration(
                                color: kPrimaryColor,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10),
                                )),
                            margin: const EdgeInsets.all(10),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: ((context) =>
                                        GroupVideoCallPage(username: pVm.cachedUserDetail!.displayName!, chatId: pVm.cachedUserDetail!.displayName!, callId: widget.callId,))));

                              },
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(80),
                                  child: const Image(
                                      image: AssetImage(
                                          "assets/icons/video_call_icon.png"))),
                            ),
                          ),
                          const Icon(Icons.more_vert),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            backgroundColor: Colors.white,
            body: GroupConversationBody(
              // chatRoomId: widget.chatId,
              idj: widget.ide,
              fullName: '',
              count: 1,
              photoUrl: '',
              userId: '',
              state: '',
              currentUserID: '',
              currentFullName: '',
              currentPhotoUrl: '',
              docID: '', chatRoomId: widget.idChat,
            ));
      }
    );
  }
}
