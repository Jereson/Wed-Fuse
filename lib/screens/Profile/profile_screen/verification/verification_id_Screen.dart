// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_animation_transition/animations/bottom_to_top_transition.dart';
import 'package:page_animation_transition/page_animation_transition.dart';
import 'package:wedme1/getit.dart';
import 'package:wedme1/utils/base_view_builder.dart';
import 'package:wedme1/utils/flushbar_widget.dart';
import 'package:wedme1/viewModel/profile_vm.dart';

import '../../../../widget/profile_widget/verificatio_appbar.dart';
import 'processing_verificationscreen.dart';

class VerificationIdScreen extends StatefulWidget {
  const VerificationIdScreen({Key? key}) : super(key: key);

  @override
  State<VerificationIdScreen> createState() => _VerificationIdScreenState();
}

class _VerificationIdScreenState extends State<VerificationIdScreen> {
  @override
  Widget build(BuildContext context) {
    return BaseViewBuilder<ProfileViewModel>(
        model: getIt(),
        builder: (pVm, _) {
          return Scaffold(
            backgroundColor: Color.fromARGB(255, 233, 57, 57),
            appBar: verificationAppBar(),
            body: ListView(
              padding: const EdgeInsets.only(left: 15, right: 15),
              children: [
                Column(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Verify Your Identity',
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                              color: Color.fromRGBO(255, 182, 183, 1),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.only(right: 20.0),
                          child: Text(
                            'In order to complete your registration, please upload a copy of identity with a closer photo below',
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 15),
                        Text(
                          'Choose your identity',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Color.fromARGB(255, 151, 148, 148),
                          ),
                        ),
                        SizedBox(height: 4),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              children: [
                                Radio<int>(
                                  fillColor: MaterialStateColor.resolveWith(
                                      (states) => Colors.white),
                                  value: 0,
                                  groupValue: pVm.selectedValue,
                                  onChanged: (value) {
                                    pVm.setIdType('NIN', value!);
                                    // setState(() {
                                    //   selectedValue = value;
                                    // });
                                  },
                                ),
                                Text(
                                  'NIN',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 12),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Radio<int>(
                                  fillColor: MaterialStateColor.resolveWith(
                                      (states) => Colors.white),
                                  value: 1,
                                  groupValue: pVm.selectedValue,
                                  onChanged: (value) {
                                    pVm.setIdType('PASSPORT', value!);
                                    // setState(() {
                                    //   selectedValue = value;
                                    // });
                                  },
                                ),
                                Text(
                                  'PASSPORT',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 12),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Radio<int>(
                                  fillColor: MaterialStateColor.resolveWith(
                                      (states) => Colors.white),
                                  value: 2,
                                  groupValue: pVm.selectedValue,
                                  onChanged: (value) {
                                    pVm.setIdType('DRIVING', value!);
                                    // setState(() {
                                    //   selectedValue = value;
                                    // });
                                  },
                                ),
                                Text(
                                  'DRIVING',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 12),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 30),
                    GestureDetector(
                      onTap: () {
                        // print('here');
                        pVm.pickAndUploadIdentity(context);
                      },
                      child: Container(
                        padding: const EdgeInsets.only(left: 8, right: 8),
                        width: double.infinity,
                        height: 150,
                        child: DottedBorder(
                          dashPattern: [10],
                          strokeWidth: 2,
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8, top: 15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Upload Your Identity',
                                  style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w600,
                                      color: Color.fromRGBO(255, 182, 183, 1),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  'We only accept,\nNIN, PASSPORT, DRIVING LICENCE',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: Color.fromARGB(255, 204, 197, 197),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Center(
                  child: Text(
                    'For a faster verification, do well\n       to take sharp picture',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Color.fromARGB(255, 221, 215, 215),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 30, top: 50),
                  child: GestureDetector(
                    onTap: () {
                      print('here2');
                      if (pVm.isIdUploaded) {
                        Navigator.of(context).push(PageAnimationTransition(
                            page: const ProcessingVerificationScreen(),
                            pageAnimationType: BottomToTopTransition()));
                      } else {
                        flushbar(
                            context: context,
                            title: 'Required',
                            message: 'Please upload your identity to procceed',
                            isSuccess: false);
                      }
                    },
                    child: CircleAvatar(
                      radius: 30,
                      backgroundColor: Color.fromRGBO(255, 182, 183, 1),
                      child: Icon(
                        Icons.arrow_forward_rounded,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
