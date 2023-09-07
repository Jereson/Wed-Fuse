// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:wedme1/getit.dart';
import 'package:wedme1/utils/base_view_builder.dart';
import 'package:wedme1/viewModel/auth_vm.dart';
import 'package:wedme1/widget/settings_category_text_containers.dart';

import '../../../widget/button_widget.dart';

class TemperamentScreen extends StatefulWidget {
  final customFunction;
  const TemperamentScreen({Key? key, required this.customFunction})
      : super(key: key);

  @override
  State<TemperamentScreen> createState() => _TemperamentScreenState();
}

class _TemperamentScreenState extends State<TemperamentScreen> {
  String childString = 'parent String';
  bool relaxed = false;
  bool extrovert = false;
  bool introvert = false;
  bool ambivert = false;
  bool playful = false;

  @override
  Widget build(BuildContext context) {
    return BaseViewBuilder<AuthViewModel>(
        model: getIt(),
        builder: (avm, _) {
          return Scaffold(
            appBar: AppBar(
              leadingWidth: 60,
              centerTitle: true,
              title: Text(
                'Temperament',
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                    letterSpacing: -0.41,
                    fontSize: 20,
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
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
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
            ),
            backgroundColor: Color.fromARGB(255, 250, 248, 248),
            body: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 50),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "what's your mood like",
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        letterSpacing: -0.4,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(height: 50),
                  GestureDetector(
                    onTap: () async {
                      setState(() {
                        childString = "relaxed";
                        relaxed = true;
                        extrovert = false;
                        introvert = false;
                        ambivert = false;
                        playful = false;
                      });
                      await avm
                          .updateField(context, {"temperament": childString});
                    },
                    child: settingstextcontainers(
                        category: relaxed, text: "Relaxed"),
                  ),
                  SizedBox(height: 20),
                  GestureDetector(
                    onTap: () async {
                      setState(() {
                        childString = "extrovert";
                        relaxed = false;
                        extrovert = true;
                        introvert = false;
                        ambivert = false;
                        playful = false;
                      });
                      await avm
                          .updateField(context, {"temperament": childString});
                    },
                    child: settingstextcontainers(
                        category: extrovert, text: "Extrovert"),
                  ),
                  SizedBox(height: 20),
                  GestureDetector(
                    onTap: () async {
                      setState(() {
                        childString = "introvert";
                        relaxed = false;
                        extrovert = false;
                        introvert = true;
                        ambivert = false;
                        playful = false;
                      });
                      await avm
                          .updateField(context, {"temperament": childString});
                    },
                    child: settingstextcontainers(
                        category: introvert, text: "Introvert"),
                  ),
                  SizedBox(height: 20),
                  GestureDetector(
                    onTap: () async {
                      setState(() {
                        childString = "ambivert";
                        relaxed = false;
                        extrovert = false;
                        introvert = false;
                        ambivert = true;
                        playful = false;
                      });
                      await avm
                          .updateField(context, {"temperament": childString});
                    },
                    child: settingstextcontainers(
                        category: ambivert, text: "Ambivert"),
                  ),
                  SizedBox(height: 20),
                  GestureDetector(
                    onTap: () async {
                      setState(() {
                        childString = "playful";
                        relaxed = false;
                        extrovert = false;
                        introvert = false;
                        ambivert = false;
                        playful = true;
                      });
                      await avm
                          .updateField(context, {"temperament": childString});
                    },
                    child: settingstextcontainers(
                        category: playful, text: "Playful"),
                  ),
                  SizedBox(height: 20),
                  editprofilebutton(
                    width: 230,
                    text: 'Save',
                    press: () {
                      widget.customFunction(childString);
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }
}
