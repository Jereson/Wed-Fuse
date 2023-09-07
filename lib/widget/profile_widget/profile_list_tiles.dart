import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileListTiles extends StatelessWidget {
  final VoidCallback? callback;
  final String? leadingText;
 const ProfileListTiles({Key? key, required this.leadingText,required this.callback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: callback,
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        leading: Text(
          leadingText!,
          style: GoogleFonts.poppins(
            textStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
        ),
        tileColor: const Color.fromARGB(255, 226, 178, 194),
        trailing: const Icon(Icons.arrow_forward_ios, color: Colors.black),
      ),
    );
  }
}
