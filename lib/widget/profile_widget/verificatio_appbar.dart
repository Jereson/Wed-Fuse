// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flag/flag.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

AppBar  verificationAppBar() {
  return AppBar(
    backgroundColor: Colors.transparent,
    elevation: 0,
    centerTitle: false,
    title: Row(
      children: [
        // Icon(
        //   Icons.arrow_back_ios,
        //   color: Colors.white,
        // ),
        Text(
          'Back',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
    actions: [
      Padding(
        padding: const EdgeInsets.only(right: 20, top: 20, bottom: 20),
        child: Row(
          children: [
            Flag.fromCode(
              FlagsCode.US,
              height: 100,
              width: 25,
              fit: BoxFit.cover,
            ),
            SizedBox(width: 5),
            Text(
              'En',
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}
