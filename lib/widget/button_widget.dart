import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:sizer/sizer.dart';
import 'package:wedme1/constants/colors.dart';
import 'package:wedme1/screens/bio_data_screen.dart';
import 'package:wedme1/screens/check_email_screen.dart';
import 'package:wedme1/screens/email_recovery_screen.dart';
import 'package:wedme1/screens/Auth/screen/phone_auth_screen.dart';
import 'package:wedme1/screens/preference_screen.dart';
import 'package:wedme1/screens/Auth/screen/welcome_screen.dart';
import 'package:wedme1/utils/styles.dart';

Widget maleButton() {
  return SizedBox(
    height: kButtonHeight,
    width: kButtonWidth,
    child: Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          backgroundColor: Styles.redColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: () async {},
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: const <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  'Male',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontFamily: "Poppins",
                  ),
                  textAlign: TextAlign.center,
                ),
              )
            ],
          ),
        ),
      ),
    ),
  );
}

Widget femaleButton() {
  return SizedBox(
    height: kButtonHeight,
    width: kButtonWidth,
    child: Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          backgroundColor: kEditextColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: () async {},
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: const <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  'Female',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontFamily: "Poppins",
                  ),
                  textAlign: TextAlign.center,
                ),
              )
            ],
          ),
        ),
      ),
    ),
  );
}

Widget everyoneButton() {
  return SizedBox(
    height: kButtonHeight,
    width: kButtonWidth,
    child: Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          backgroundColor: kEditextColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: () async {},
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: const <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  'Everyone',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontFamily: "Poppins",
                  ),
                  textAlign: TextAlign.center,
                ),
              )
            ],
          ),
        ),
      ),
    ),
  );
}

Widget preferenceProceedButton(BuildContext context) {
  return SizedBox(
    height: kButtonHeight,
    width: kButtonWidth,
    child: Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          backgroundColor: Styles.redColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const WelcomeScreen()));
        },
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  'Proceed',
                  style: Styles.buttonTextStyle,
                  textAlign: TextAlign.center,
                ),
              )
            ],
          ),
        ),
      ),
    ),
  );
}

Widget loginButton(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 16.0),
    child: OutlinedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.white),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
      onPressed: () {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => const PhoneAuthScreen()));
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                'Login',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                  fontWeight: FontWeight.w600,
                  fontFamily: "Poppins",
                ),
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    ),
  );
}

Widget phoneNumberProceedButton(BuildContext context) {
  return SizedBox(
    height: kButtonHeight,
    width: kButtonWidth,
    child: Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          backgroundColor: Styles.redColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: () {
          // Navigator.of(context).push(PageAnimationTransition(
          //     page: PhoneOtpScreen(

          //     ),
          //     pageAnimationType: BottomToTopTransition()));
        },
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  'Proceed',
                  style: Styles.buttonTextStyle,
                  textAlign: TextAlign.center,
                ),
              )
            ],
          ),
        ),
      ),
    ),
  );
}

Widget verifyPhoneOtpButton(BuildContext context) {
  return SizedBox(
    height: kButtonHeight,
    width: kButtonWidth,
    child: Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          backgroundColor: Styles.redColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const EmailRecoveryScreen()));
        },
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  'Proceed',
                  style: Styles.buttonTextStyle,
                  textAlign: TextAlign.center,
                ),
              )
            ],
          ),
        ),
      ),
    ),
  );
}

Widget emailRecoveryButton(BuildContext context) {
  return SizedBox(
    height: kButtonHeight,
    width: kButtonWidth,
    child: Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          backgroundColor: Styles.redColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: () {
          // Navigator.push(context,
          //     MaterialPageRoute(builder: (context) => const EmailOtpScreen()));
        },
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  'Proceed',
                  style: Styles.buttonTextStyle,
                  textAlign: TextAlign.center,
                ),
              )
            ],
          ),
        ),
      ),
    ),
  );
}

Widget verifyEmailOtpButton(BuildContext context) {
  return SizedBox(
    height: kButtonHeight,
    width: kButtonWidth,
    child: Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          backgroundColor: Styles.redColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const BioDataScreen()));
        },
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  'Proceed',
                  style: Styles.buttonTextStyle,
                  textAlign: TextAlign.center,
                ),
              )
            ],
          ),
        ),
      ),
    ),
  );
}

Widget bioDataButton(BuildContext context) {
  return SizedBox(
    height: kButtonHeight,
    width: kButtonWidth,
    child: Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          backgroundColor: Styles.redColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const PreferenceScreen()));
        },
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  'Proceed',
                  style: Styles.buttonTextStyle,
                  textAlign: TextAlign.center,
                ),
              )
            ],
          ),
        ),
      ),
    ),
  );
}

Widget verifyEmailButton(BuildContext context) {
  return SizedBox(
    height: 60.0,
    width: 302.0,
    child: Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          backgroundColor: Styles.redColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const WelcomeScreen()));
        },
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  'Open email app',
                  style: Styles.buttonTextStyle,
                  textAlign: TextAlign.center,
                ),
              )
            ],
          ),
        ),
      ),
    ),
  );
}

Widget forgotPasswordButton(BuildContext context) {
  return SizedBox(
    height: kButtonHeight,
    width: kButtonWidth,
    child: Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          backgroundColor: Styles.redColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const CheckEmailScreen()));
        },
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  'Proceed',
                  style: Styles.buttonTextStyle,
                  textAlign: TextAlign.center,
                ),
              )
            ],
          ),
        ),
      ),
    ),
  );
}

class ChoosePhotoButtonWidget extends StatelessWidget {
  const ChoosePhotoButtonWidget({
    Key? key,
    required this.size,
    required this.text,
    required this.press,
  }) : super(key: key);
  final double size;
  final String text;
  final Function() press;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTap: press,
      child: Container(
        margin: const EdgeInsets.only(left: 37, right: 37),
        width: size,
        height: 45,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Text(
            text,
            style: Styles.buttonTextStyle
                .copyWith(color: Colors.white, fontSize: 14.sp),
          ),
        ),
      ),
    );
  }
}

class ProceedButtonWidget extends StatelessWidget {
  const ProceedButtonWidget({
    Key? key,
    required this.size,
    required this.text,
    required this.press,
    this.color = kPrimaryBlack
  }) : super(key: key);

  final Size size;
  final String text;
  final Color color;
  final Function() press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        padding: const EdgeInsets.only(left: 37, right: 37),
        width: size.width,
        height: 50,
        decoration:  BoxDecoration(
          color: color,
          borderRadius: const BorderRadius.horizontal(
            right: Radius.circular(10),
            left: Radius.circular(10),
          ),
        ),
        child: Center(
          child: Text(
            text,
            style: Styles.buttonTextStyle.copyWith(color: kPrimaryWhite),
          ),
        ),
      ),
    );
  }
}

class MilesButtonWidget extends StatelessWidget {
  const MilesButtonWidget(
      {Key? key, required this.size, required this.text, required this.press})
      : super(key: key);

  final Size size;
  final String text;
  final Function() press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 24, right: 14),
      child: GestureDetector(
        onTap: press,
        child: Container(
          width: size.width,
          height: 30,
          decoration: BoxDecoration(
            color: kPrimaryColor,
            borderRadius: BorderRadius.circular(50),
            // borderRadius: BorderRadius.horizontal(
            //   right: Radius.circular(10),
            //   left: Radius.circular(10),
            // ),
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Text(text,
                  style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                  ))),
            ),
          ),
        ),
      ),
    );
  }
}

class editprofilebutton extends StatelessWidget {
  const editprofilebutton(
      {Key? key, required this.width, required this.text, required this.press})
      : super(key: key);

  final double width;
  final String text;
  final Function() press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 24, right: 24),
      child: GestureDetector(
        onTap: press,
        child: Container(
          width: width,
          height: 42,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 14.0,
                fontFamily: "Poppins",
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
