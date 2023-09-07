import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomProfileListTile extends StatelessWidget {
  Function() onTouch;
  String leadingText;
  CustomProfileListTile({required this.leadingText, required this.onTouch});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTouch,
      child: ListTile(
        trailing: const Icon(
          Icons.arrow_forward_ios,
          color: Colors.black,
          size: 20,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        tileColor: Colors.white,
        leading: Text(
          leadingText,
          style: GoogleFonts.poppins(
            textStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
