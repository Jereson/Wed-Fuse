// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:open_mail_app/open_mail_app.dart';
import 'package:page_animation_transition/animations/bottom_to_top_transition.dart';
import 'package:page_animation_transition/page_animation_transition.dart';
import 'package:sizer/sizer.dart';
import 'package:wedme1/screens/preliminary/progress_loading_screen.dart';
import 'package:wedme1/utils/styles.dart';
import 'package:wedme1/widget/button_widget.dart';

class CheckEmailScreen extends StatefulWidget {
  const CheckEmailScreen({Key? key}) : super(key: key);

  @override
  State<CheckEmailScreen> createState() => _CheckEmailScreenState();
}

class _CheckEmailScreenState extends State<CheckEmailScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Styles.whiteColor,
        body: Padding(
          padding: const EdgeInsets.only(left: 37, right: 37),
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 80,
                ),
                SizedBox(
                  height: 146,
                  width: 146,
                  child: CircleAvatar(
                    backgroundImage:
                        const AssetImage("assets/icons/circle_red.png"),
                    child: Image.asset(
                      "assets/icons/email_chat.png",
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Text(
                  "Check your mail",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w400),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  "we sent a password recovery instruction to your email.",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 8.h,
                ),
                ProceedButtonWidget(
                  size: size,
                  text: 'Open email app',
                  press: () async {
                    var result = await OpenMailApp.openMailApp();

                    // If no mail apps found, show error
                    if (!result.didOpen && !result.canOpen) {
                      showNoMailAppsDialog(context);
                      // iOS: if multiple mail apps found, show dialog to select.
                      // There is no native intent/default app system in iOS so
                      // you have to do it yourself.
                    } else if (!result.didOpen && result.canOpen) {
                      showDialog(
                        context: context,
                        builder: (_) {
                          return MailAppPickerDialog(
                            mailApps: result.options,
                          );
                        },
                      );
                    }
                  },
                ),
                const SizedBox(
                  height: 12,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(PageAnimationTransition(
                        page: const ProgressLoadingScreen(),
                        pageAnimationType: BottomToTopTransition()));
                  },
                  child: Text(
                    "Skip i'll confirm later on",
                    style: GoogleFonts.poppins(
                        fontSize: 14.sp, fontWeight: FontWeight.w400),
                  ),
                )
              ],
            ),
          ),
        ));
  }

  void showNoMailAppsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Open Mail App"),
          content: const Text("No mail apps installed"),
          actions: <Widget>[
            TextButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }
}
