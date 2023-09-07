// import 'package:flutter/material.dart';
// import 'package:page_animation_transition/animations/bottom_to_top_transition.dart';
// import 'package:page_animation_transition/page_animation_transition.dart';
// import 'package:pinput/pinput.dart';
// import 'package:wedme1/constants/colors.dart';
// import 'package:wedme1/screens/bio_data_screen.dart';
// import 'package:wedme1/utils/styles.dart';
// import 'package:sizer/sizer.dart';
// import 'package:wedme1/widget/button_widget.dart';

// class EmailOtpScreen extends StatelessWidget {
//   const EmailOtpScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;

//     const defaultPinTheme = PinTheme(
//       width: 56,
//       height: 56,
//       textStyle: TextStyle(
//           fontSize: 20,
//           color: Color.fromRGBO(30, 60, 87, 1),
//           fontWeight: FontWeight.w600),
//       decoration: BoxDecoration(
//         border: Border(bottom: BorderSide(color: kPrimaryColor, width: 0.9)),
//         // borderRadius: BorderRadius.circular(20),
//       ),
//     );

//     final focusedPinTheme = defaultPinTheme.copyDecorationWith(
//       border: Border.all(color: const Color.fromRGBO(114, 178, 238, 1)),
//       borderRadius: BorderRadius.circular(8),
//     );

//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       backgroundColor: Styles.whiteColor,
//       body: Padding(
//         padding: const EdgeInsets.only(right: 37, left: 37),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             SizedBox(height: 2.h),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   "Confirm \nCode",
//                   style: Styles.headLineStyle2,
//                 ),
//                 SizedBox(height: 1.h),
//                 Padding(
//                   padding: EdgeInsets.only(left: 1.0.w),
//                   child: RichText(
//                     text: TextSpan(
//                         // style: DefaultTextStyle.of(context).style,
//                         children: <TextSpan>[
//                           TextSpan(
//                             text:
//                                 "Kindly input the verification code that was sent to ",
//                             style: TextStyle(
//                                 color: Colors.black,
//                                 fontSize: 14.sp,
//                                 fontWeight: FontWeight.w300),
//                           ),
//                           TextSpan(
//                             text: " abcd@gmail.com",
//                             style: TextStyle(
//                                 color: Styles.redColor,
//                                 fontSize: 14.sp,
//                                 fontWeight: FontWeight.w300),
//                           ),
//                         ]),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 2.h,
//                 ),
//                 Pinput(
//                   defaultPinTheme: defaultPinTheme,
//                   focusedPinTheme: focusedPinTheme,
//                   validator: (s) {
//                     return s == '2222' ? null : 'Pin is incorrect';
//                   },
//                   pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
//                   showCursor: true,
//                   onCompleted: (pin) => print(pin),
//                 ),
//               ],
//             ),
//             SizedBox(
//               height: 3.h,
//             ),
//             ProceedButtonWidget(
//               size: size,
//               text: 'Proceed',
//               press: () {
//                 Navigator.of(context).push(PageAnimationTransition(
//                     page: const BioDataScreen(),
//                     pageAnimationType: BottomToTopTransition()));
//               },
//             ),
//             SizedBox(height: 2.h),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:pinput/pinput.dart' as pin;
import 'package:wedme1/constants/colors.dart';
import 'package:wedme1/getit.dart';
import 'package:wedme1/utils/base_view_builder.dart';
import 'package:wedme1/utils/styles.dart';
import 'package:wedme1/viewModel/auth_vm.dart';

import 'package:wedme1/widget/button_widget.dart';

class EmailOtpScreen extends StatefulWidget {

  const EmailOtpScreen({Key? key, }) : super(key: key);

  @override
  State<EmailOtpScreen> createState() => _EmailOtpScreenState();
}

class _EmailOtpScreenState extends State<EmailOtpScreen> {
  final formKey = GlobalKey<FormState>();
  final otpController = TextEditingController();
  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
    super.initState();
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: BaseViewBuilder<AuthViewModel>(
          model: getIt(),
          builder: (aVm, _) {
            return Padding(
              padding: const EdgeInsets.only(left: 37, right: 37),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(height: 2),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Verification \nCode",
                        style: Styles.headLineStyle2,
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 1.0),
                        child: RichText(
                          text: TextSpan(
                              // style: DefaultTextStyle.of(context).style,
                              children: <TextSpan>[
                                TextSpan(
                                  text:
                                      "Kindly input the verification code that was sent to ",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                                TextSpan(
                                  text: aVm.recoveryEmailController.text,
                                  style: TextStyle(
                                      color: Styles.redColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w300),
                                ),
                              ]),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      PinCodeTextField(
                        appContext: context,
                        hintStyle: TextStyle(
                            fontSize: 20,
                            color: Color.fromRGBO(30, 60, 87, 1),
                            fontWeight: FontWeight.w600),
                        length: 6,
                        obscureText: false,
                        animationType: AnimationType.fade,
                        controller: otpController,
                        keyboardType: TextInputType.phone,
                        pinTheme: PinTheme(
                            shape: PinCodeFieldShape.underline,
                            borderRadius: BorderRadius.circular(5),
                            fieldHeight: 50,
                            fieldWidth: 40,
                            borderWidth: 1,
                            activeColor: kPrimaryColor,
                            activeFillColor: kPrimaryColor.withOpacity(0.1),
                            inactiveFillColor: Colors.white,
                            selectedFillColor: Colors.white,
                            selectedColor: kPrimaryColor),
                        animationDuration: Duration(milliseconds: 300),
                        enableActiveFill: true,
                        onCompleted: (v) {
                          print("Completed");

                          aVm.updateRecoveryEmail(context, otpController.text);
                        },
                        onChanged: (value) {
                          print(value);
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'OTP required';
                          } else if (value.length < 6) {
                            return 'Invalid opt';
                          }
                          return null;
                        },
                        beforeTextPaste: (text) {
                          print("Allowing to paste $text");
                          //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                          //but you can show anything you want here, like your pop up saying wrong paste format or etc
                          return true;
                        },
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  ProceedButtonWidget(
                      size: size,
                      text: 'Proceed',
                      press: () {
                        if (!formKey.currentState!.validate()) return;
                        // widget.isPhoneAuth
                        //     ? aVm.verifyAuthOTP(context)
                        //     : aVm.updatePhoneNumber(context);

                        aVm.updateRecoveryEmail(context, otpController.text);
                      }

                      //  Navigator.of(context).push(MaterialPageRoute(
                      //     builder: (context) => const EmailRecoveryScreen()))

                      ),
                  const SizedBox(height: 2),
                ],
              ),
            );
          }),
    );
  }
}




// AIndW9A-FwyK59bB1iWYWosfHYBHmrH0bvKauQgXIPYPOuOQ-tgh4cwAIzoaM-YpX8zvWNXr4gdD_S8ug2EcMwnd_G8tqHjtVg4Syli33HwuLiXWyFjR01DP3Vgcmj02RhPidub_Slv_xtTd5i5VTq-fV3_SM9kYAvy_zB5_fKuVKQdd4Q6LEzXP7J72m5n36jK7dKvDHbbXtJg4nNOOTjjgPyHcW8NxxSlyDtie--KtNKD727AahQQ
