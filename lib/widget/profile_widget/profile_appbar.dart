import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomProfileAppbar {
  static PreferredSize appBar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(60),
      child: Padding(
        padding: const EdgeInsets.only(
          right: 18,
          left: 20,
          top: 60,
        ),
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const CircleAvatar(
                      radius: 18,
                      backgroundColor: Color.fromARGB(255, 241, 43, 28),
                      child: Icon(
                        Icons.arrow_back_rounded,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      child: Text(
                        'Profile',
                        style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                    const Icon(
                      Icons.settings,
                      size: 35,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
