// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_animation_transition/animations/bottom_to_top_transition.dart';
import 'package:page_animation_transition/page_animation_transition.dart';

import '../../../../widget/profile_widget/verificatio_appbar.dart';
import 'verification_id_Screen.dart';

class VerificationScreen extends StatelessWidget {
  const VerificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 233, 57, 57),
      appBar: verificationAppBar(),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 200,
                  child: Image(
                    image: AssetImage('assets/gif/verify.gif'),
                  ),
                ),
                SizedBox(height: 50),
                Text(
                  'Verify Your Identity',
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: Color.fromRGBO(255, 182, 183, 1),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Lorem ipsum color sit armel, consectetur peruza\n    just some dummy text but will be replaced\n by a short description asking theuser to verify',
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 100),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(PageAnimationTransition(
                          page: const VerificationIdScreen(),
                          pageAnimationType: BottomToTopTransition()));
                    },
                    child: CircleAvatar(
                      radius: 30,
                      backgroundColor: Color.fromRGBO(255, 182, 183, 1),
                      child: Icon(
                        Icons.arrow_forward_rounded,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
