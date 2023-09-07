import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextFields extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables

  // final TextEditingController controller;
  final int maxlines;
  final int minlines;

  final String? initialValue;
  final void Function(String)? onFieldSubmitted;
  final void Function()? onEditingComplete;
  final void Function(String)? onChanged;

  const CustomTextFields({
    Key? key,
    this.maxlines = 1,
    this.minlines = 1,
    // required this.controller,
    this.initialValue,
    this.onFieldSubmitted, this.onEditingComplete, this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      // width: 390,
      child: TextFormField(
        initialValue: initialValue,
        onFieldSubmitted: onFieldSubmitted,
        onEditingComplete: onEditingComplete,
        onChanged: onChanged,
        style: GoogleFonts.poppins(
          textStyle: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 14,
            color: Colors.black,
          ),
        ),
        minLines: minlines,
        maxLines: maxlines,
        // controller: controller,
        decoration: InputDecoration(
          helperStyle: GoogleFonts.poppins(
            textStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
          ),
          filled: true,
          fillColor: Colors.white,
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
