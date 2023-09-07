// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wedme1/getit.dart';
import 'package:wedme1/utils/base_view_builder.dart';
import 'package:wedme1/viewModel/auth_vm.dart';

import '../../../widget/button_widget.dart';

class GenotypeScreen extends StatefulWidget {
  final customFunction;
  const GenotypeScreen({Key? key, required this.customFunction})
      : super(key: key);

  @override
  State<GenotypeScreen> createState() => _GenotypeScreenState();
}

class _GenotypeScreenState extends State<GenotypeScreen> {
  String childString = 'parent String';
  bool aa = false;
  bool ac = false;
  bool as = false;
  bool ss = false;

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return BaseViewBuilder<AuthViewModel>(
          model: getIt(),
          builder: (avm, _) {
            return Scaffold(
              appBar: AppBar(
                leadingWidth: 60,
                centerTitle: true,
                title: Text(
                  'Genotype',
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
                      'What is your Genotype',
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
                          childString = "AA";
                          aa = true;
                          ac = false;
                          as = false;
                          ss = false;
                        });
                        await avm
                            .updateField(context, {"genotype": childString});
                      },
                      child: Container(
                        margin: EdgeInsets.only(left: 20),
                        width: double.infinity,
                        decoration: BoxDecoration(),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'AA',
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: -0.4,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            SizedBox(width: 20),
                            Icon(
                              Icons.check,
                              color: aa ? Colors.red : Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    GestureDetector(
                      onTap: () async {
                        setState(() {
                          childString = "AC";
                          aa = false;
                          ac = true;
                          as = false;
                          ss = false;
                        });
                        await avm
                            .updateField(context, {"genotype": childString});
                      },
                      child: Container(
                        margin: EdgeInsets.only(left: 20),
                        width: double.infinity,
                        decoration: BoxDecoration(),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'AC',
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: -0.4,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            SizedBox(width: 20),
                            Icon(
                              Icons.check,
                              color: ac ? Colors.red : Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    GestureDetector(
                      onTap: () async {
                        setState(() {
                          childString = "AS";
                          aa = false;
                          ac = false;
                          as = true;
                          ss = false;
                        });
                        await avm
                            .updateField(context, {"genotype": childString});
                      },
                      child: Container(
                        margin: EdgeInsets.only(left: 20),
                        width: double.infinity,
                        decoration: BoxDecoration(),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'AS',
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: -0.4,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            SizedBox(width: 20),
                            Icon(
                              Icons.check,
                              color: as ? Colors.red : Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    GestureDetector(
                      onTap: () async {
                        setState(() {
                          childString = "SS";
                          aa = false;
                          ac = false;
                          as = false;
                          ss = true;
                        });
                        await avm
                            .updateField(context, {"genotype": childString});
                      },
                      child: Container(
                        margin: EdgeInsets.only(left: 20),
                        width: double.infinity,
                        decoration: BoxDecoration(),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'SS',
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: -0.4,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            SizedBox(width: 20),
                            Icon(
                              Icons.check,
                              color: ss ? Colors.red : Colors.white,
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
                    ),
                  ],
                ),
              ),
            );
          });
    });
  }
}
