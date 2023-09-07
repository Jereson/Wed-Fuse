import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:wedme1/screens/chat_screens/conversation_body.dart';
import 'package:wedme1/screens/chat_screens/video_call.dart';
import 'package:wedme1/screens/chat_screens/voice_call.dart';

import '../../constants/colors.dart';
import '../../constants/error.dart';
import '../../constants/loader.dart';
import '../Auth/Controller/googleController.dart';
import 'BottomChatfield.dart';
import 'converversationBody.dart';

class ConversationScreen1 extends ConsumerWidget {
  const ConversationScreen1({Key? key, required this.uid}) : super(key: key);

  final String uid;

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final bool isGroupChat = false;
    return ref.watch(getUserDataProvider(uid)).when(data: (user) =>Scaffold(
        appBar: AppBar(
          leading:    IconButton(
            onPressed: () { Navigator.pop(context); },
            icon: Icon( Icons.arrow_back_ios, color: Colors.black,),
          ),
          elevation: 0,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          flexibleSpace: SafeArea(
            child: Container(
              padding: const EdgeInsets.only(right: 4, top: 6),
              child: Padding(
                padding: const EdgeInsets.only(right: 8, left: 40),
                child: Column(
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 2, left: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                          
                              CircleAvatar(
                                radius: 20,
                                backgroundImage:  NetworkImage(
                                    user.photoUrl!),
                                child: Stack(
                                  children: const [
                                    Positioned(
                                      bottom: -10,
                                      right: -12,
                                      child: CircleAvatar(
                                          radius: 18,
                                          backgroundColor: Colors.transparent,
                                          child: Image(
                                              image: AssetImage(
                                                  "assets/icons/online_icon.png"))),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 1.w,
                              ),
                              SizedBox(
                                width: 150,
                                child: Text(
                                  user.fullName!,
                                  style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14.sp,
                                      )),
                                  softWrap: true,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              SizedBox(
                                width: 1.w,
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
                                    // Navigator.of(context).push(
                                    //     MaterialPageRoute(
                                    //         builder: ((context) =>
                                    //         const VoiceCallScreen())));
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
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: ((context) =>
                                            const VideoCallScreen())));
                                  },
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(80),
                                      child: const Image(
                                          image: AssetImage(
                                              "assets/icons/video_call_icon.png"))),
                                ),
                              ),
                              SizedBox(
                                width: 2.w,
                              ),
                              const Icon(Icons.more_vert),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),

        backgroundColor: Colors.white,
        body:  Column(
          children: [
            Expanded(
              child: ChatList(
                recieverUserId: uid,
                isGroupChat: isGroupChat,
              ),
            ),
            BottomChatField(
              recieverUserId: uid,
              isGroupChat: isGroupChat,
            ),
          ],
        ),),
        error: (error, stackTrace) => ErrorText(error: error.toString()),
        loading: () => const loader(),
    );
  }
}
