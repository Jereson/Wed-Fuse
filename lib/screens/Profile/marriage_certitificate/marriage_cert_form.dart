import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wedme1/constants/colors.dart';
import 'package:wedme1/getit.dart';
import 'package:wedme1/screens/Profile/marriage_certitificate/marriage_invite_screen.dart';
import 'package:wedme1/utils/base_view_builder.dart';
import 'package:wedme1/utils/flushbar_widget.dart';
import 'package:wedme1/utils/form_utils.dart';
import 'package:wedme1/utils/styles.dart';
import 'package:wedme1/viewModel/marriage_vm.dart';
import 'package:wedme1/widget/app_bar_widget.dart';
import 'package:wedme1/widget/button_widget.dart';

class MarriageCerttificateFormScreen extends StatefulWidget {
  const MarriageCerttificateFormScreen({Key? key}) : super(key: key);

  @override
  State<MarriageCerttificateFormScreen> createState() =>
      _MarriageCerttificateFormScreenState();
}

class _MarriageCerttificateFormScreenState
    extends State<MarriageCerttificateFormScreen> {
  final formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: simpleAppBar(context),
      body: BaseViewBuilder<MarriageViewModel>(
          model: getIt(),
          builder: (mVm, _) {
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(20),
              child: Form(
                key: formkey,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text('Input the necessary information below',
                            style: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                                fontSize: 15,
                              ),
                            )),
                      ),
                      const SizedBox(height: 30),
                      Text("Bride's name", style: stBlack40013),
                      const SizedBox(height: 4),
                      TextFormField(
                        controller: mVm.brideNameController,
                        cursorColor: Colors.black,
                        decoration: borderTextInputDecoration.copyWith(
                            hintText: 'example Stella'),
                        validator: (val) {
                          if (val!.isEmpty) {
                            return 'Field is required';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      Text("Groom's name", style: stBlack40013),
                      const SizedBox(height: 4),
                      TextFormField(
                        controller: mVm.groomNameController,
                        cursorColor: Colors.black,
                        decoration: borderTextInputDecoration.copyWith(
                            hintText: 'example Mark'),
                        validator: (val) {
                          if (val!.isEmpty) {
                            return 'Field is required';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      Text("Date", style: stBlack40013),
                      const SizedBox(height: 4),
                      GestureDetector(
                        onTap: () {
                          mVm.selectDate(context);
                        },
                        child: Container(
                          padding: const EdgeInsets.only(left: 10),
                          alignment: Alignment.centerLeft,
                          height: 47,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Color(0xFFF2F2F2),
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: Color(0xFF7B7B7B))),
                          child: Text(mVm.date ?? 'example 11/02/23',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black.withOpacity(
                                      mVm.date == null ? 0.2 : 1))),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text("Location", style: stBlack40013),
                      const SizedBox(height: 4),
                      TextFormField(
                        controller: mVm.locationController,
                        cursorColor: Colors.black,
                        decoration: borderTextInputDecoration,
                        validator: (val) {
                          if (val!.isEmpty) {
                            return 'Field is required';
                          }
                          return null;
                        },
                        maxLines: 2,
                      ),
                      const SizedBox(height: 20),
                      Text("Tag Person", style: stBlack40013),
                      const SizedBox(height: 4),
                      TextFormField(
                        controller: mVm.tagController,
                        cursorColor: Colors.black,
                        decoration: borderTextInputDecoration,
                        // validator: (val) {
                        //   if (val!.isEmpty) {
                        //     return 'Field is required';
                        //   }
                        //   return null;
                        // },
                      ),
                      const SizedBox(height: 20),
                      Center(
                        child: DottedBorder(
                            color: kPrimaryColor,
                            child: GestureDetector(
                              onTap: () {
                                mVm.pickCertification();
                              },
                              child: Container(
                                alignment: Alignment.center,
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(
                                    color: kPrimaryColor.withOpacity(0.1)),
                                child: mVm.certificatFile != null
                                    ? Image.file(
                                        mVm.certificatFile!,
                                        fit: BoxFit.cover,
                                      )
                                    : const Text(
                                        'Court Certificate',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(color: Colors.black45),
                                      ),
                              ),
                            )),
                      ),
                      const SizedBox(height: 30),
                      ProceedButtonWidget(
                          size: size,
                          text: 'Create Invite',
                          press: () {
                            if (!formkey.currentState!.validate()) {
                              return;
                            } else if (mVm.date == null) {
                              flushbar(
                                  context: context,
                                  title: 'Date Required',
                                  message: 'Please select date',
                                  isSuccess: false);
                              return;
                            } else if (mVm.certificatFile == null) {
                              flushbar(
                                  context: context,
                                  title: 'Certication Required',
                                  message:
                                      'Please select marriage certicate from your photo',
                                  isSuccess: false);
                              return;
                            } else {
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (context) {
                                return const MarriageInviteScreen();
                              }));
                            }
                          })
                    ]),
              ),
            );
          }),
    );
  }
}
