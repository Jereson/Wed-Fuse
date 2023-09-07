import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddCityCustomContainer extends StatelessWidget {
  String leadingtext;
  Widget trailingwidget;
  AddCityCustomContainer(
      {required this.leadingtext, required this.trailingwidget});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              leadingtext,
              style: GoogleFonts.poppins(
                textStyle: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          Padding(
              padding: const EdgeInsets.only(right: 10), child: trailingwidget),
        ],
      ),
    );
  }
}
