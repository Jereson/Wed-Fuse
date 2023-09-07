import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileBottomSheetText extends StatelessWidget {
  String texts;
  ProfileBottomSheetText({Key? key, required this.texts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      texts,
      style: GoogleFonts.poppins(
        textStyle: const TextStyle(
          fontSize: 16,
          color: Color.fromARGB(255, 104, 101, 101),
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
