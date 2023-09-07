// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wedme1/getit.dart';
import 'package:wedme1/utils/base_view_builder.dart';
import 'package:wedme1/viewModel/auth_vm.dart';

import '../../../widget/button_widget.dart';
import '../../../widget/settings_category_text_containers.dart';

class ChoiceScreen extends StatefulWidget {
  final customFunction;
  const ChoiceScreen({Key? key, required this.customFunction})
      : super(key: key);

  @override
  State<ChoiceScreen> createState() => _ChoiceScreenState();
}

class _ChoiceScreenState extends State<ChoiceScreen> {
  String childString = 'parent String';
  bool somethingcasual = false;
  bool somethingserious = false;
  bool marriage = false;
  bool justdating = false;
  bool friendship = false;

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
                'What are you looking for',
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
                    "Your relationship interests will help us find the right",
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        letterSpacing: -0.4,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Text(
                    "fit for you",
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
                        childString = "somethingcasual";
                        somethingcasual = true;
                        somethingserious = false;
                        marriage = false;
                        justdating = false;
                        friendship = false;
                      });
                      await avm.updateField(context, {"choice": childString});
                    },
                    child: settingstextcontainers(
                        category: somethingcasual, text: "Something Casual"),
                  ),
                  SizedBox(height: 20),
                  GestureDetector(
                    onTap: () async {
                      setState(() {
                        childString = "somethingserious";
                        somethingcasual = false;
                        somethingserious = true;
                        marriage = false;
                        justdating = false;
                        friendship = false;
                      });
                      await avm.updateField(context, {"choice": childString});
                    },
                    child: settingstextcontainers(
                        category: somethingserious, text: "Something Serious"),
                  ),
                  SizedBox(height: 20),
                  GestureDetector(
                    onTap: () async {
                      setState(() {
                        childString = "marriage";
                        somethingcasual = false;
                        somethingserious = false;
                        marriage = true;
                        justdating = false;
                        friendship = false;
                      });
                      await avm.updateField(context, {"choice": childString});
                    },
                    child: settingstextcontainers(
                        category: marriage, text: "Marriage"),
                  ),
                  SizedBox(height: 20),
                  GestureDetector(
                    onTap: () async {
                      setState(() {
                        childString = "justdating";
                        somethingcasual = false;
                        somethingserious = false;
                        marriage = false;
                        justdating = true;
                        friendship = false;
                      });
                      await avm.updateField(context, {"choice": childString});
                    },
                    child: settingstextcontainers(
                        category: justdating, text: "Just Dating"),
                  ),
                  SizedBox(height: 20),
                  GestureDetector(
                    onTap: () async {
                      setState(() {
                        childString = "friendship";
                        somethingcasual = false;
                        somethingserious = false;
                        marriage = false;
                        justdating = false;
                        friendship = true;
                      });
                      await avm.updateField(context, {"choice": childString});
                    },
                    child: settingstextcontainers(
                        category: friendship, text: "Friendship"),
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
