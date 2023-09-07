import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:wedme1/models/country_model.dart';

class ChatRoomItems extends StatelessWidget {
  const ChatRoomItems({super.key, this.country, this.isSelected});

  final Country? country;
  final bool? isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 26, bottom: 8),
      width: double.infinity,
      decoration: const BoxDecoration(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            country!.name!,
            style: GoogleFonts.poppins(
              textStyle: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w400,
                letterSpacing: -0.4,
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(width: 20),
          Icon(
            Icons.check,
            color: country!.selected! ? Colors.red : Colors.white,
          ),
        ],
      ),
    );
  }
}
