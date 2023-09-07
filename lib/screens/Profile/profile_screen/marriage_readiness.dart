// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wedme1/getit.dart';
import 'package:wedme1/utils/base_view_builder.dart';
import 'package:wedme1/viewModel/auth_vm.dart';

import '../../../widget/settings_category_text_containers.dart';

class MarriageReadinessScreen extends StatefulWidget {
  final customFunction;
  const MarriageReadinessScreen({Key? key, required this.customFunction})
      : super(key: key);

  @override
  State<MarriageReadinessScreen> createState() =>
      _MarriageReadinessScreenState();
}

class _MarriageReadinessScreenState extends State<MarriageReadinessScreen> {
  String childString = 'parent String';
  bool state = false;
  bool months = false;
  bool days = false;
  bool weeks = false;
  bool years = false;

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
                'Marriage Readiness',
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      "This indicates how ready you are to get married",
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          letterSpacing: -0.4,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 50),
                  Text(
                    'Select how ready you are',
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        letterSpacing: -0.4,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  GestureDetector(
                    onTap: () async {
                      setState(() {
                        days = true;
                        months = false;
                        weeks = false;
                        years = false;
                        childString = "As soon as possible";
                      });
                      await avm.updateField(
                          context, {"marriageRadyness": childString});
                    },
                    child: settingstextcontainers(
                        category: days, text: "As soon as possible"),
                  ),
                  SizedBox(height: 20),
                  GestureDetector(
                    onTap: () async {
                      setState(() {
                        days = false;
                        months = true;
                        weeks = false;
                        years = false;
                        childString = "Few months";
                      });
                      await avm.updateField(
                          context, {"marriageRadyness": childString});
                    },
                    child: settingstextcontainers(
                        category: months, text: "Few months"),
                  ),
                  SizedBox(height: 20),
                  GestureDetector(
                    onTap: () async{
                      setState(() {
                        days = false;
                        months = false;
                        weeks = true;
                        years = false;
                        childString = "few years";
                      });
                       await avm.updateField(context, {"marriageRadyness": childString});
                    },
                    child: settingstextcontainers(
                        category: weeks, text: "few years"),
                  ),
                  SizedBox(height: 20),
                  GestureDetector(
                    onTap: () async {
                      setState(() {
                        days = false;
                        months = false;
                        weeks = false;
                        years = true;
                        childString = "Not Interested";
                      });
                       await avm.updateField(context, {"marriageRadyness": childString});
                    },
                    child: settingstextcontainers(
                        category: years, text: "Not Interested"),
                  ),
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Make visible on profile screen',
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            letterSpacing: -0.4,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Switch(
                        value: state,
                        onChanged: (bool value) {
                          setState(() {
                            state = value;
                          });
                        },
                        activeColor: Color.fromRGBO(237, 34, 39, 1),
                        inactiveTrackColor: Color.fromRGBO(217, 217, 217, 1),
                        thumbColor: MaterialStateColor.resolveWith(
                          (states) => Color.fromRGBO(237, 34, 39, 1),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }
}
