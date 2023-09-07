import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:wedme1/constants/colors.dart';
import 'package:wedme1/getit.dart';
import 'package:wedme1/screens/chat_screens/chat_room.dart';
import 'package:wedme1/screens/chat_screens/group_screen.dart';
import 'package:wedme1/screens/chat_screens/message_list.dart';
import 'package:wedme1/utils/base_view_builder.dart';
import 'package:wedme1/viewModel/profile_vm.dart';
import 'package:wedme1/widget/app_bar_widget.dart';

import '../../chat/groupChat.dart';
import '../../chat/groupChat/gropChatNew.dart';
class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<GlobalKey> _pageKeys = [    GlobalKey(),    GlobalKey(),    GlobalKey(),  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: BaseViewBuilder<ProfileViewModel>(
        model: getIt(),
        builder: (pVm, _) {
          return WillPopScope(
            onWillPop: () async {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const ChatScreen()),
                      (route) => false);
              return true;
            },
            child: Scaffold(
              appBar: CustomAppbar.matchScreenAppBar(
                  context,
                  size: size,
                  photoUrl: pVm.cachedUserDetail!.photoUrl!),
              backgroundColor: Colors.white,
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: DefaultTabController(
                      length: 3,
                      initialIndex: 0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Container(
                            alignment: Alignment.topCenter,
                            child: TabBar(
                                isScrollable: true,
                                indicatorColor: kPrimaryColor,
                                labelStyle:
                                const TextStyle(color: Colors.black),
                                // onTap: (index) {
                                //   if (index == 1) {
                                //     Navigator.of(context).push(
                                //       MaterialPageRoute(
                                //         builder: (context) => ChatRoom(
                                //           key: _pageKeys[index],
                                //         ),
                                //       ),
                                //     );
                                //   } else {
                                //     Navigator.of(context).push(
                                //       MaterialPageRoute(
                                //         builder: (context) => MessageList(
                                //           key: _pageKeys[index],
                                //         ),
                                //       ),
                                //     );
                                //   }
                                // },
                                tabs: [
                                  Tab(
                                    child: Text(
                                      "MESSAGES",
                                      style: GoogleFonts.poppins(
                                          textStyle: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 14.sp,
                                          )),
                                    ),
                                  ),
                                  Tab(
                                    child: Text(
                                      "CHAT ROOM",
                                      style: GoogleFonts.poppins(
                                          textStyle: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 14.sp,
                                          )),
                                    ),
                                  ),
                                  Tab(
                                    child: Text(
                                      "GROUP",
                                      style: GoogleFonts.poppins(
                                          textStyle: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 14.sp,
                                          )),
                                    ),
                                  )
                                ]),
                          ),
                          Expanded(
                            child: TabBarView(
                                physics: const BouncingScrollPhysics(),
                                dragStartBehavior: DragStartBehavior.down,
                                children: [
                                  MessageList(
                                    key: _pageKeys[0],
                                  ),
                                  ChatRoom(
                                    key: _pageKeys[1],
                                  ),
                                  GroupChatNew(
                                    key: _pageKeys[2],
                                  )
                                ]),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
