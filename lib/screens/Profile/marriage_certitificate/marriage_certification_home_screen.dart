import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wedme1/getit.dart';
import 'package:wedme1/screens/Profile/marriage_certitificate/chose_templet_screen.dart';
import 'package:wedme1/screens/Profile/marriage_certitificate/marriage_invite_screen.dart';
import 'package:wedme1/viewModel/marriage_vm.dart';
import 'package:wedme1/widget/app_bar_widget.dart';
import 'package:wedme1/widget/button_widget.dart';

class MariageCertificateHomeScreen extends StatelessWidget {
  const MariageCertificateHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: simpleAppBar(context),
      body: StreamBuilder<QuerySnapshot>(
          stream: getIt
              .get<MarriageViewModel>()
              .marriageCollection
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .collection('myMarriageCert')
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: Text('Waiting'));
            }
            // if (snapshot.hasError) {
            //   return Center(child: Text(snapshot.error.toString()));
            // }

            return Center(
              child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Image.asset(
                          'assets/images/love1.jpg',
                        ),
                      ),
                      Text(
                        'Create Stunning Wedding Invitaion',
                        style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                            fontSize: 17,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                          'Choose from multiple inivitation templetes that suits you and send them accoss to your friends',
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                              fontSize: 15,
                            ),
                          )),
                      const SizedBox(height: 40),
                      ProceedButtonWidget(
                          size: MediaQuery.of(context).size,
                          text: 'Create Invite',
                          press: () {
                            if (snapshot.data!.docs.isNotEmpty) {
                              if (snapshot.data!.docs.first['status'] == 0) {
                                AwesomeDialog(
                                  context: context,
                                  dialogType: DialogType.info,
                                  animType: AnimType.rightSlide,
                                  title: 'Pending',
                                  desc:
                                      'Sorry, you have a pending created marriage certificate',
                                  btnCancelOnPress: () {},
                                  btnOkOnPress: () {
                                    Navigator.of(context).pop();
                                  },
                                ).show();
                              } else {
                                getIt.get<MarriageViewModel>().setCertParseData(
                                    snapshot.data!.docs.first['userId'],
                                    snapshot.data!.docs.first['template']);
                                  //TODO:: Send the user to the

                                Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (context) {
                                  return const MarriageInviteScreen(
                                      isCreatingNewInvit: false);
                                }));
                              }
                            } else {
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (context) {
                                return const ChooseTempletScreen();
                              }));
                            }
                          })
                    ],
                  )),
            );
          }),
    );
  }
}
