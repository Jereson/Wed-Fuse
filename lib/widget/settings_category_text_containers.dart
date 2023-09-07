import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class settingstextcontainers extends StatelessWidget {
  const settingstextcontainers({required this.category, required this.text});

  final bool category;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10),
      width: double.infinity,
      decoration: const BoxDecoration(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text,
            style: GoogleFonts.poppins(
              textStyle: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w500,
                letterSpacing: -0.4,
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(width: 20),
          Icon(
            Icons.check,
            color: category ? Colors.red : Colors.white,
          ),
        ],
      ),
    );
  }
}
