// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:wedme1/getit.dart';
import 'package:wedme1/utils/base_view_builder.dart';
import 'package:wedme1/viewModel/auth_vm.dart';

import '../../../widget/button_widget.dart';
import '../../../widget/settings_category_text_containers.dart';

class InterestedInScreen extends StatefulWidget {
  final customFunction;
  const InterestedInScreen({Key? key, required this.customFunction})
      : super(key: key);

  @override
  State<InterestedInScreen> createState() => _InterestedInScreenState();
}

class _InterestedInScreenState extends State<InterestedInScreen> {
  String childString = 'parent String';
  bool men = false;
  bool women = false;

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
                'Interested In',
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
                    "Kindly select who you would like to see on your feed",
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
                        men = true;
                        women = false;
                        childString = "Men";
                      });
                      await avm.updateField(context, {
                        "interest": [childString]
                      });
                    },
                    child: settingstextcontainers(category: men, text: "Men"),
                  ),
                  SizedBox(height: 20),
                  GestureDetector(
                    onTap: () async {
                      setState(() {
                        men = false;
                        women = true;
                        childString = "Women";
                      });
                      await avm.updateField(context, {
                        "interest": [childString]
                      });
                    },
                    child:
                        settingstextcontainers(category: women, text: "Women"),
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
