// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wedme1/widget/profile_widget/verificatio_appbar.dart';

class ProcessingVerificationScreen extends StatelessWidget {
  const ProcessingVerificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: verificationAppBar(),
      backgroundColor: Color.fromARGB(255, 233, 57, 57),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 200, right: 20, left: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: double.infinity,
              height: 250,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/shield.png'),
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    left: 20,
                    right: 20,
                    top: 20,
                    bottom: 20,
                    child: Image.asset('assets/images/shieldchild.png'),
                  ),
                ],
              ),
            ),
            SizedBox(height: 5),
            Center(
              child: Text(
                'Verification in Progress',
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    color: Color.fromRGBO(255, 182, 183, 1),
                    fontWeight: FontWeight.w600,
                    fontSize: 24,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
