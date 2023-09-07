import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:wedme1/screens/chat_screens/video_call.dart';
import 'package:wedme1/screens/chat_screens/voice_call.dart';
import 'package:wedme1/screens/home_page/user_chat_body.dart';

import '../../constants/colors.dart';

class UserChatScreen extends StatefulWidget {
 final String? userId;
final  String? userName;
 final String? userPhotoUrl;

  const UserChatScreen({Key? key, required this.userId, required this.userName, required this.userPhotoUrl}) : super(key: key);

  @override
  State<UserChatScreen> createState() => _UserChatScreenState();
}

class _UserChatScreenState extends State<UserChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          // automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          flexibleSpace: SafeArea(
            child: Container(
              padding: const EdgeInsets.only(right: 4, top: 6),
              child: Padding(
                padding: const EdgeInsets.only(right: 8, left: 4),
                child: Column(
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 2, left: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Icon(
                                Icons.arrow_back_ios,
                              ),
                              CircleAvatar(
                                radius: 20,
                                backgroundColor: kPrimaryColor,
                                backgroundImage: NetworkImage(widget.userPhotoUrl!),
                                //  const 
                                // AssetImage(
                                //     'assets/images/rectangle_image_bg.png'),
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
                              Text(
                                widget.userName!,
                                style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14.sp,
                                )),
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
                                    //             const VoiceCallScreen())));
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
        body:  UserChatBody(recieverId : widget.userId,));
  }
}
