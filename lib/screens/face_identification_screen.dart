import "package:flutter/material.dart";
import 'package:page_animation_transition/animations/bottom_to_top_transition.dart';
import 'package:page_animation_transition/page_animation_transition.dart';
import 'package:sizer/sizer.dart';

import '../utils/styles.dart';
import '../widget/button_widget.dart';
import 'congratulation_screen.dart';

class FaceIdentification extends StatefulWidget {
  const FaceIdentification({Key? key}) : super(key: key);

  @override
  State<FaceIdentification> createState() => _FaceIdentificationState();
}

class _FaceIdentificationState extends State<FaceIdentification> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          color: Colors.black,
          icon: const Icon(Icons.arrow_back_ios),
          iconSize: 20.0,
          onPressed: (() {
            //  Navigator.pop(context);
          }),
        ),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(right: 37, left: 37),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: 2.h,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Hold Still",
                  style: Styles.headLineStyle2,
                ),
                const SizedBox(
                  height: 4,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 1.0.w),
                  child: Text(
                      'please hold still and look directly into the camera.',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w300)),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Stack(
                      children: const [
                        Padding(
                          padding: EdgeInsets.only(right: 8),
                          child: SizedBox(
                            height: 220,
                            width: 133,
                            child: Image(
                              image:
                                  AssetImage("assets/gif/face_detection.gif"),
                            ),
                          ),
                        ),
                        // Positioned(
                        //     right: -12,
                        //     bottom: -10,
                        //     child: IconButton(
                        //         onPressed: () {},
                        //         icon: const Icon(
                        //           Icons.cancel,
                        //         )))
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 2.h,
                ),
              ],
            ),
            ProceedButtonWidget(
              size: size,
              text: 'Proceed',
              press: () {
                Navigator.of(context).push(PageAnimationTransition(
                    page: const CongratulationScreen(),
                    pageAnimationType: BottomToTopTransition()));
              },
            ),
            SizedBox(height: 0.2.h),
          ],
        ),
      ),
    );
  }
}
