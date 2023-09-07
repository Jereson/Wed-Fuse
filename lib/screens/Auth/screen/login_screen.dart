import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_animation_transition/animations/bottom_to_top_transition.dart';
import 'package:page_animation_transition/page_animation_transition.dart';
import 'package:sizer/sizer.dart';
import 'package:wedme1/constants/colors.dart';
import 'package:wedme1/getit.dart';
import 'package:wedme1/screens/Auth/screen/phone_auth_screen.dart';
import 'package:wedme1/screens/Auth/screen/phone_number_login.dart';
import 'package:wedme1/screens/Auth/screen/welcome_screen.dart';
import 'package:wedme1/utils/base_view_builder.dart';
import 'package:wedme1/utils/styles.dart';
import 'package:wedme1/viewModel/auth_vm.dart';
import 'package:wedme1/widget/auth_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage("assets/images/onboarding-bg.gif"))),
      child: Scaffold(
          backgroundColor: kGradientLight.withOpacity(0.5),
          body: SafeArea(
            child: BaseViewBuilder<AuthViewModel>(
                model: getIt(),
                builder: (aVm, _) {
                  return Center(
                    child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: SizedBox(
                          height: size.height,
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              SizedBox(height: size.height / 10),
                              Image.asset(
                                'assets/images/logo-white-bg.png',
                                height: 30,
                              ),
                              SizedBox(
                                height: size.height / 10,
                              ),
                              Column(
                                children: [
                                  Text(
                                    // 'Welcome back, ${user.fullName}',
                                    'Welcome back',
                                    style: Styles.headLineStyle5,
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 2),
                                  Text('By clicking Login you agree to our ',
                                      style: GoogleFonts.poppins(
                                          textStyle: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w300,
                                        fontSize: 14,
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
                                                  fontSize: 14,
                                                  decoration: TextDecoration
                                                      .underline)),
                                          children: [
                                            const WidgetSpan(
                                                alignment: PlaceholderAlignment
                                                    .baseline,
                                                baseline:
                                                    TextBaseline.alphabetic,
                                                child: SizedBox(
                                                  width: 4,
                                                )),
                                            TextSpan(
                                              text: 'and',
                                              style: GoogleFonts.poppins(
                                                  textStyle: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 14,
                                                      decoration:
                                                          TextDecoration.none)),
                                            ),
                                            const WidgetSpan(
                                                alignment: PlaceholderAlignment
                                                    .baseline,
                                                baseline:
                                                    TextBaseline.alphabetic,
                                                child: SizedBox(
                                                  width: 4,
                                                )),
                                            TextSpan(
                                              text: 'privacy policy',
                                              style: GoogleFonts.poppins(
                                                  textStyle: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 14,
                                                      decoration: TextDecoration
                                                          .underline)),
                                            )
                                          ])),
                                  const SizedBox(height: 28),
                                  CustomAuthButton(
                                    width: size.width * 0.8,
                                    title: "Login with Google",
                                    authType: 'google',
                                    callback: () {
                                      aVm.loginWithGoogle(context);
                                    },
                                  ),
                                  const SizedBox(height: 15),
                                  CustomAuthButton(
                                    width: size.width * 0.8,
                                    title: "Login with Facebook",
                                    authType: 'facebook',
                                    callback: () {
                                      aVm.signInWithFacebook(context);
                                    },
                                  ),
                                  const SizedBox(height: 15),
                                  CustomAuthButton(
                                    width: size.width * 0.8,
                                    title: "Login with Phone",
                                    authType: 'phone',
                                    callback: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(builder: (context) {
                                        return const PhoneNumberLoginScreen();
                                      }));
                                    },
                                  ),
                                  // buttonWidget(
                                  //     size: size,
                                  //     text: "Login",
                                  //     press: () async{

                                  //       _serviceEnabled = await location.serviceEnabled();
                                  //       if (!_serviceEnabled!) {
                                  //         _serviceEnabled = await location.requestService();
                                  //         if (!_serviceEnabled!) {
                                  //           return;
                                  //         }
                                  //       }
                                  //       _permissionGranted = await location.hasPermission();
                                  //       if (_permissionGranted == PermissionStatus.denied) {
                                  //         _permissionGranted = await location.requestPermission();
                                  //         if (_permissionGranted != PermissionStatus.granted) {
                                  //           return;
                                  //         }
                                  //       }
                                  //       _locationData = await location.getLocation();
                                  //       setState(() {
                                  //         lat = _locationData!.latitude!;
                                  //         long = _locationData!.longitude!;
                                  //       });
                                  //       save();
                                  //       Navigator.push(
                                  //         context,
                                  //         MaterialPageRoute(builder: (context) => const ProgressLoadingScreen()),
                                  //       );

                                  //     }),
                                  const SizedBox(height: 20),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Don't have an account? ",
                                        style: Styles.textStyle
                                            .copyWith(color: Colors.white),
                                      ),
                                      GestureDetector(
                                        onTap: (() {
                                          Navigator.of(context).push(
                                              PageAnimationTransition(
                                                  page: const WelcomeScreen(),
                                                  pageAnimationType:
                                                      BottomToTopTransition()));
                                        }),
                                        child: Text(
                                          "Sign Up",
                                          style: Styles.textStyle.copyWith(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(height: 1.h)
                                ],
                              ),
                            ],
                          ),
                        )),
                  );
                }),
          )),
    );
  }
}
