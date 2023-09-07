// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddJobsScreen extends StatefulWidget {
  const AddJobsScreen({Key? key}) : super(key: key);

  @override
  State<AddJobsScreen> createState() => _AddJobsScreenState();
}

class _AddJobsScreenState extends State<AddJobsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 60,
        centerTitle: true,
        title: Text(
          'Jobs',
          style: GoogleFonts.poppins(
            textStyle: TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.black,
              letterSpacing: -0.41,
              fontSize: 18,
            ),
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 20, bottom: 2),
            child: CircleAvatar(
              radius: 15,
              backgroundColor: Color.fromARGB(255, 241, 43, 28),
              child: Icon(
                Icons.arrow_back_rounded,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
      backgroundColor: Color.fromARGB(255, 250, 248, 248),
      body: Padding(
        padding: EdgeInsets.only(left: 20, right: 20, top: 46),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Select your jobs here. This will help us find some one with thesame job as you.',
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                    fontSize: 16,
                    letterSpacing: -0.17,
                  ),
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              SizedBox(
                height: 60,
                width: 390,
                child: TextField(
                  decoration: InputDecoration(
                    filled: true,
                    hintText: 'Company',
                    hintStyle: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        letterSpacing: -0.17,
                      ),
                    ),
                    fillColor: Colors.white,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
