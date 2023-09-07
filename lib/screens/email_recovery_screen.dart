import 'package:flutter/material.dart';
import 'package:page_animation_transition/animations/bottom_to_top_transition.dart';
import 'package:page_animation_transition/page_animation_transition.dart';
import 'package:wedme1/getit.dart';
import 'package:wedme1/screens/bio_data_screen.dart';
import 'package:wedme1/screens/email_otp_screen.dart';
import 'package:wedme1/utils/base_view_builder.dart';
import 'package:wedme1/utils/form_utils.dart';
import 'package:wedme1/utils/styles.dart';
import 'package:wedme1/viewModel/auth_vm.dart';
import 'package:wedme1/widget/button_widget.dart';
import 'package:wedme1/widget/text_input.dart';
import 'package:sizer/sizer.dart';

class EmailRecoveryScreen extends StatefulWidget {
  const EmailRecoveryScreen({Key? key}) : super(key: key);

  @override
  State<EmailRecoveryScreen> createState() => _EmailRecoveryScreenState();
}

class _EmailRecoveryScreenState extends State<EmailRecoveryScreen> {
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Styles.whiteColor,
      body: BaseViewBuilder<AuthViewModel>(
          model: getIt(),
          builder: (aVm, _) {
            return Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.only(right: 37, left: 37),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    SizedBox(height: 2),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Recovery \nEmail",
                          style: Styles.headLineStyle2,
                        ),
                        SizedBox(height: 1),
                        Text(
                          'Your email will be used to help you recover your account if you forget your password',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w300),
                        ),
                        SizedBox(height: 2),
                        // CustomWidgets.textField("Email",
                        //     suffixIcon: Icons.email, hint: "abcd@example.com"),
                        TextFormField(
                          controller: aVm.recoveryEmailController,
                          decoration: noBorderTextInputDecoration.copyWith(
                              suffixIcon: Icon(Icons.email)),
                          validator: (val) {
                            if (val!.trim().isEmpty) {
                              return 'Email required';
                            } else if (!val.trim().contains('@') ||
                                !val.trim().contains('.com')) {
                              return 'Inavlid email';
                            }
                            return null;
                          },
                        ),

                        SizedBox(height: 2),
                        Center(
                          child: TextButton(
                            onPressed: () => {
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (context) {
                                return const BioDataScreen();
                              }))
                            },
                            child: Text(
                              "Skip",
                              style: TextStyle(
                                color: Styles.textColor,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    ProceedButtonWidget(
                      size: size,
                      text: 'Proceed',
                      press: () {
                        if (!formKey.currentState!.validate()) return;
                        aVm.sendEmail(context);
                        // Navigator.of(context).push(PageAnimationTransition(
                        //     page: const EmailOtpScreen(),
                        //     pageAnimationType: BottomToTopTransition()));
                      },
                    ),
                    SizedBox(height: 2),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
