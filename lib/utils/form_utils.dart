import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final borderTextInputDecoration = InputDecoration(
  filled: true,
  fillColor: const Color(0xFFF3F8FF),
  focusedBorder: const OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(5)),
    borderSide: BorderSide(width: 1, color: Color(0xFF9E9E9E)),
  ),
  contentPadding: const EdgeInsets.all(12),
  enabledBorder: const OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(5)),
    borderSide: BorderSide(width: 1, color: Color(0xFF9E9E9E)),
  ),
  border: const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(5)),
      borderSide: BorderSide(width: 1, color: Color(0xFF9E9E9E))),
  hintStyle: TextStyle(fontSize: 16, color: Colors.black.withOpacity(0.2)),
);

final noBorderTextInputDecoration = InputDecoration(
  filled: true,
  fillColor: const Color(0xFFF2F2F2),
  focusedBorder: const OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(5)),
    borderSide: BorderSide.none,
  ),
  contentPadding: const EdgeInsets.all(12),
  enabledBorder: const OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(5)),
    borderSide: BorderSide.none,
  ),
  border: const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(5)),
      borderSide: BorderSide.none),
  hintStyle: TextStyle(fontSize: 16, color: Colors.black.withOpacity(0.2)),
);

final profileInputDecoration = InputDecoration(
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
);

final profileFieldStyle = GoogleFonts.poppins(
  textStyle: const TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 14,
    color: Colors.black,
  ),
);
