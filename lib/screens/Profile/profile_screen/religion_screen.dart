// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wedme1/getit.dart';

import '../../../utils/base_view_builder.dart';
import '../../../viewModel/auth_vm.dart';
import '../../../widget/button_widget.dart';
import '../../../widget/settings_category_text_containers.dart';

class ReligionScreen extends StatefulWidget {
  final Function customFunction;
  const ReligionScreen({Key? key, required this.customFunction})
      : super(key: key);

  @override
  State<ReligionScreen> createState() => _ReligionScreenState();
}

class _ReligionScreenState extends State<ReligionScreen> {
  String childString = 'parent String';
  bool atheist = true;
  bool budist = false;
  bool christian = false;
  bool hedonist = false;
  bool muslim = false;
  bool traditionalist = false;
  bool dontspecify = false;

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
                'Religion',
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
                    'Kindly specify your religion to help find you a match that fits your preferences',
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        letterSpacing: -0.4,
                        color: Colors.black,
                      ),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 40),
                  GestureDetector(
                    onTap: () async {
                      setState(() {
                        childString = "Atheist";
                        atheist = false;
                        budist = true;
                        christian = false;
                        hedonist = false;
                        muslim = false;
                        traditionalist = false;
                        dontspecify = false;
                      });

                      await avm.updateField(context, {"religion": childString});
                    },
                    child: settingstextcontainers(
                        category: atheist, text: "Atheist"),
                  ),
                  SizedBox(height: 20),
                  GestureDetector(
                    onTap: () async {
                      setState(() {
                        childString = "budist";
                        atheist = false;
                        budist = true;
                        christian = false;
                        hedonist = false;
                        muslim = false;
                        traditionalist = false;
                        dontspecify = false;
                      });
                      await avm.updateField(context, {"religion": childString});
                    },
                    child: settingstextcontainers(
                        category: budist, text: "Budist"),
                  ),
                  SizedBox(height: 20),
                  GestureDetector(
                    onTap: () async {
                      setState(() {
                        childString = "christian";
                        atheist = false;
                        budist = false;
                        christian = true;
                        hedonist = false;
                        muslim = false;
                        traditionalist = false;
                        dontspecify = false;
                      });
                      await avm.updateField(context, {"religion": childString});
                    },
                    child: settingstextcontainers(
                        category: christian, text: "Christian"),
                  ),
                  SizedBox(height: 20),
                  GestureDetector(
                    onTap: () async {
                      setState(() {
                        childString = "hedonist";
                        atheist = false;
                        budist = false;
                        christian = false;
                        hedonist = true;
                        muslim = false;
                        traditionalist = false;
                        dontspecify = false;
                      });
                      await avm.updateField(context, {"religion": childString});
                    },
                    child: settingstextcontainers(
                        category: hedonist, text: "Hedonist"),
                  ),
                  SizedBox(height: 20),
                  GestureDetector(
                    onTap: () async {
                      setState(() {
                        childString = "muslim";
                        atheist = false;
                        budist = false;
                        christian = false;
                        hedonist = false;
                        muslim = true;
                        traditionalist = false;
                        dontspecify = false;
                      });
                      await avm.updateField(context, {"religion": childString});
                    },
                    child: settingstextcontainers(
                        category: muslim, text: "Muslim"),
                  ),
                  SizedBox(height: 20),
                  GestureDetector(
                    onTap: () async {
                      setState(() {
                        childString = "traditionalist";
                        atheist = false;
                        budist = false;
                        christian = false;
                        hedonist = false;
                        muslim = false;
                        traditionalist = true;
                        dontspecify = false;
                      });
                      await avm.updateField(context, {"religion": childString});
                    },
                    child: settingstextcontainers(
                        category: traditionalist, text: "Traditionalist"),
                  ),
                  SizedBox(height: 20),
                  GestureDetector(
                    onTap: () async {
                      setState(() {
                        childString = "dontspecify";
                        atheist = false;
                        budist = false;
                        christian = false;
                        hedonist = false;
                        muslim = false;
                        traditionalist = false;
                        dontspecify = true;
                      });
                      await avm.updateField(context, {"religion": childString});
                    },
                    child: settingstextcontainers(
                        category: dontspecify, text: "Don't Specify"),
                  ),
                  SizedBox(height: 20),
                  editprofilebutton(
                    width: 230,
                    text: 'Save',
                    press: () async {
                      widget.customFunction(childString);
                      await avm.updateField(context, {"religion": childString});
                      // Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }
}
