import 'package:flutter/material.dart';
import 'package:wedme1/constants/colors.dart';

class CustomAuthButton extends StatelessWidget {
  final String? title;
  final double? width;
  final String? authType;
  final VoidCallback? callback;
  const CustomAuthButton(
      {Key? key,
      required this.title,
      this.width,
      this.authType,
      required this.callback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 24, right: 24),
      child: GestureDetector(
        onTap: callback,
        child: Container(
          alignment: Alignment.center,
          width: width ?? double.infinity,
          height: 54,
          decoration: BoxDecoration(
            color: kPrimaryWhite,
            borderRadius: BorderRadius.circular(50),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              authType == 'phone'
                  ? const Offstage()
                  : Image.asset(
                      authType == 'facebook'
                          ? "assets/icons/fb_icon.png"
                          : "assets/icons/google_icon.png",
                      height: 30,
                    ),
              const SizedBox(width: 10),
              Text(
                title!,
                style: const TextStyle(
                  fontSize: 15,
                  fontFamily: "Poppins",
                  color: kPrimaryBlack,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
