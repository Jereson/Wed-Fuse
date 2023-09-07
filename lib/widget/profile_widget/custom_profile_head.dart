import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomProfileHeadings extends StatelessWidget {
  String heading;
  CustomProfileHeadings({
    required this.heading,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      heading,
      style: GoogleFonts.poppins(
        textStyle: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
      ),
    );

    // Row(
    //   children: [
    //     Text(
    //       heading,
    //       style: GoogleFonts.poppins(
    //         textStyle: const TextStyle(
    //           fontWeight: FontWeight.w600,
    //           fontSize: 12,
    //         ),
    //       ),
    //     ),
    //     const SizedBox(width: 10),
    //     const Icon(
    //       Icons.emergency,
    //       color: Colors.red,
    //       size: 8,
    //     ),
    //   ],
    // );
  }
}
