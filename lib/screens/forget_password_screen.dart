import 'package:flutter/material.dart';
import 'package:page_animation_transition/animations/bottom_to_top_transition.dart';
import 'package:page_animation_transition/page_animation_transition.dart';
import 'package:sizer/sizer.dart';
import 'package:wedme1/screens/check_email_screen.dart';
import 'package:wedme1/widget/button_widget.dart';

import '../constants/colors.dart';
import '../utils/styles.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      backgroundColor: Styles.whiteColor,
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.only(left: 20, right: 20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(
                  height: kMarginTop,
                ),
                Text(
                  "Forgot",
                  style: Styles.headLineStyle2,
                ),

                Text(
                  'Password',
                  style: Styles.headLineStyle2,
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  'Kindly input your Email address and follow the steps  that will be sent acrosss to you',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w300),
                ),
                const SizedBox(
                  height: 12,
                ),
                Text(
                  'Email',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w300),
                ),
                //TextFieldScreen
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: kEditextColor,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  margin: const EdgeInsets.only(top: 8),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: TextField(
                          keyboardType: TextInputType.text,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: "abcd@gmail.com",
                            hintStyle: TextStyle(color: Colors.grey),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 8, horizontal: 8),
                            isDense: true,
                          ),
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Icon(
                          Icons.email,
                          color: Styles.textColor,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 120.0,
                ),

                ProceedButtonWidget(
                  size: size,
                  text: 'Proceed',
                  press: () {
                    Navigator.of(context).push(PageAnimationTransition(
                        page: const CheckEmailScreen(),
                        pageAnimationType: BottomToTopTransition()));
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
