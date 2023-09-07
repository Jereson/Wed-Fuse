import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:wedme1/constants/colors.dart';
import 'package:wedme1/screens/preliminary/progress_loading_screen.dart';

import '../utils/styles.dart';
import '../widget/button_widget.dart';

class CongratulationScreen extends StatefulWidget {
  const CongratulationScreen({Key? key}) : super(key: key);

  @override
  State<CongratulationScreen> createState() => _CongratulationScreenState();
}

class _CongratulationScreenState extends State<CongratulationScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kPrimaryWhite,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.only(
          right: 37,
          left: 37,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/logo-fav-color.png',
              ),
              Text(
                'Congrats',
                style: TextStyle(
                    fontSize: 28.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontFamily: Styles.fontFamily),
                textAlign: TextAlign.center,
              ),
              Text(
                'You have successfully created and account let find you a match',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w300),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 18.h,
              ),
              ProceedButtonWidget(
                size: size,
                text: 'Proceed',
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ProgressLoadingScreen()),
                  );

                },
              ),
              SizedBox(height: 0.2.h),
            ],
          ),
        ),
      )),
    );
  }
}
