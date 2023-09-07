import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_animation_transition/animations/bottom_to_top_transition.dart';
import 'package:page_animation_transition/page_animation_transition.dart';
import 'package:sizer/sizer.dart';

import 'package:wedme1/constants/colors.dart';
import 'package:wedme1/getit.dart';
import 'package:wedme1/screens/Auth/screen/login_screen.dart';
import 'package:wedme1/screens/Auth/screen/phone_auth_screen.dart';
import 'package:wedme1/utils/base_view_builder.dart';
import 'package:wedme1/viewModel/auth_vm.dart';
import 'package:wedme1/widget/auth_button.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BaseViewBuilder<AuthViewModel>(
        model: getIt(),
        // initState: (init) {
        //   init.dummyAddUser();
        // },
        builder: (aVm, _) {
          return Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage("assets/images/onboarding-bg.gif"))),
            child: Scaffold(
              backgroundColor: kGradientLight.withOpacity(0.5),
              body: SafeArea(
                child: Center(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: SizedBox(
                      height: size.height,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(height: 1),
                          Image.asset(
                            'assets/images/logo-white-bg.png',
                            height: 30,
                          ),
                          SizedBox(height: size.height / 10),
                          Text(
                            'Find Your Soulmate',
                            style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 26,
                            )),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 2),
                          Text('By clicking Login you agree to our ',
                              style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w300,
                                fontSize: 13,
                              ))),
                          const SizedBox(height: 4),
                          RichText(
                              overflow: TextOverflow.clip,
                              textAlign: TextAlign.center,
                              textDirection: TextDirection.rtl,
                              maxLines: 1,
                              textScaleFactor: 1,
                              text: TextSpan(
                                  text: 'Terms and Conditions',
                                  style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 13,
                                          decoration:
                                              TextDecoration.underline)),
                                  children: [
                                    const WidgetSpan(
                                        alignment:
                                            PlaceholderAlignment.baseline,
                                        baseline: TextBaseline.alphabetic,
                                        child: SizedBox(
                                          width: 4,
                                        )),
                                    TextSpan(
                                      text: 'and',
                                      style: GoogleFonts.poppins(
                                          textStyle: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 13,
                                              decoration: TextDecoration.none)),
                                    ),
                                    const WidgetSpan(
                                        alignment:
                                            PlaceholderAlignment.baseline,
                                        baseline: TextBaseline.alphabetic,
                                        child: SizedBox(
                                          width: 4,
                                        )),
                                    TextSpan(
                                      text: 'privacy policy',
                                      style: GoogleFonts.poppins(
                                          textStyle: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 13,
                                              decoration:
                                                  TextDecoration.underline)),
                                    )
                                  ])),
                          const SizedBox(height: 20),
                          CustomAuthButton(
                            width: size.width * 0.8,
                            title: "Sign Up with Google",
                            authType: 'google',
                            callback: () {
                              aVm.signUpWithGoogle(context);
                              // Navigator.of(context)
                              //     .push(MaterialPageRoute(builder: (context) {
                              //   return const PhoneAuthScreen();
                              // }));
                            },
                          ),
                          const SizedBox(height: 15),
                          CustomAuthButton(
                            width: size.width * 0.8,
                            title: "Sign Up with Facebook",
                            authType: 'facebook',
                            callback: () {
                              aVm.signUpWithFacebook(context);
                              // Navigator.of(context)
                              //     .push(MaterialPageRoute(builder: (context) {
                              //   return const PhoneAuthScreen();
                              // }));
                            },
                          ),
                          const SizedBox(height: 15),
                          CustomAuthButton(
                            width: size.width * 0.8,
                            title: "Sign Up with Phone Number",
                            authType: 'phone',
                            callback: () {
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (context) {
                                return const PhoneAuthScreen();
                              }));
                            },
                          ),
                          const SizedBox(height: 20),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                  PageAnimationTransition(
                                      page: const LoginScreen(),
                                      pageAnimationType:
                                          BottomToTopTransition()));
                            },
                            child: Text(
                              'Login to wedfuse',
                              style: TextStyle(
                                fontSize: 15,
                                color: kPrimaryWhite,
                                fontWeight: FontWeight.w600,
                                fontFamily: "Poppins",
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const SizedBox(height: 30)
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
}
