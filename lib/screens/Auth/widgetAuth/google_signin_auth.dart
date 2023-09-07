import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sizer/sizer.dart';
import 'package:wedme1/constants/colors.dart';

import '../../../constants/loader.dart';
import '../Controller/googleController.dart';

class GoogleSignInButton extends ConsumerWidget {
  const GoogleSignInButton({Key? key}) : super(key: key);

  // void signInWihGoogle( BuildContext context, WidgetRef ref){
  //   ref.read(authControllerProvider.notifier).signInWithGoogle(context);
  // }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final isloading = ref.watch(authControllerProvider);
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0, left: 24, right: 24),
      child: OutlinedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.white),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40),
            ),
          ),
        ),
        onPressed: () => {
          // signInWihGoogle(context, ref)
        },
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: 
          // isloading
          //     ? const loader()
          //     :
               Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Image(
                      image: AssetImage(
                        "assets/icons/google_icon.png",
                      ),
                      height: 30.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        'Sign Up with Google',
                        style: TextStyle(
                          fontSize: 15.sp,
                          color: kPrimaryBlack,
                          fontWeight: FontWeight.w300,
                          fontFamily: "Poppins",
                        ),
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                ),
        ),
      ),
    );
  }
}
