// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_animation_transition/animations/bottom_to_top_transition.dart';
import 'package:page_animation_transition/page_animation_transition.dart';

import '../../../widget/button_widget.dart';


class NarrowingScreen extends StatefulWidget {
  const NarrowingScreen({Key? key}) : super(key: key);

  @override
  State<NarrowingScreen> createState() => _NarrowingScreenState();
}

class _NarrowingScreenState extends State<NarrowingScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 60,
        centerTitle: true,
        title: Text(
          'Narrowing Settings',
          style: GoogleFonts.poppins(
            textStyle: TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.black,
              letterSpacing: -0.41,
              fontSize: 20,
            ),
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 20, bottom: 2),
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: CircleAvatar(
                radius: 15,
                backgroundColor: Color.fromARGB(255, 241, 43, 28),
                child: Icon(
                  Icons.arrow_back_rounded,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
      backgroundColor: Color.fromARGB(255, 250, 248, 248),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  tileColor: Colors.white,
                  leading: Text(
                    'Current Location',
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        letterSpacing: -0.4,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'WedMe will access to your location',
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      letterSpacing: -0.4,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(height: 30),
                ListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  tileColor: Colors.white,
                  leading: Text(
                    'Other Location',
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        letterSpacing: -0.4,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                SizedBox(
                  height: 60,
                  width: 390,
                  child: TextField(
                    decoration: InputDecoration(
                      filled: true,
                      hintText: 'Select Location',
                      hintStyle: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                      fillColor: Colors.white,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 60),
              child: ProceedButtonWidget(
                size: size,
                text: 'Proceed',
                press: () {
                  Navigator.of(context).push(PageAnimationTransition(
                      page: const Text('ndnd'),
                      pageAnimationType: BottomToTopTransition()));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
