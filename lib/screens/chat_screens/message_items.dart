import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:wedme1/constants/colors.dart';
import 'package:wedme1/models/message_model.dart';

class MessageItem extends StatelessWidget {
  const MessageItem({Key? key, this.messageModel}) : super(key: key);
  final MessageModel? messageModel;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(
        top: 2,
        left: 8,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 4, right: 1),
            child: CircleAvatar(
              radius: 26,
              backgroundImage: AssetImage(messageModel!.userImage!),
              child:
                  Stack(
                      children: const [
                        Positioned(
                          bottom: -8,
                          left: -6,
                          child: CircleAvatar(
                            radius: 14,
                            backgroundColor: Colors.transparent,
                            child: ImageIcon(
                              AssetImage("assets/icons/online_icon.png"),
                              color: Colors.green,
                            ),
                          ),
                        ),
                      ],
                    )
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: size.width / 4),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  messageModel!.userName!,
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                      fontSize: 14.sp,
                    ),
                  ),
                  textAlign: TextAlign.center,
                ),
                Text(
                  messageModel!.message!,
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      fontWeight: FontWeight.w200,
                      color: Colors.red,
                      fontSize: 10.sp,
                    ),
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              right: 2,
            ),
            child: Column(
              children: [
                Text(
                  messageModel!.timeAgo!,
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      fontWeight: FontWeight.w200,
                      color: kPrimaryColor,
                      fontSize: 10.sp,
                    ),
                  ),
                  textAlign: TextAlign.center,
                ),
                switchWidget(messageModel!.delivered!,
                    messageModel!.messageCount.toString()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget switchWidget(bool isDelivered, String messageCount) {
  if (isDelivered) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Image.asset(
          "assets/icons/correct_icon.png",
          color: kPrimaryColor,
          height: 8,
          width: 8,
        ),
        Image.asset(
          "assets/icons/correct_icon.png",
          color: kPrimaryColor,
          height: 8,
          width: 8,
        )
      ],
    );
  } else {
    return CircleAvatar(
      radius: 8,
      backgroundColor: Colors.red,
      child: Text(
        messageCount,
        style: GoogleFonts.poppins(
          textStyle: TextStyle(
            fontWeight: FontWeight.w200,
            color: Colors.white,
            fontSize: 10.sp,
          ),
        ),
      ),
    );
  }
}
