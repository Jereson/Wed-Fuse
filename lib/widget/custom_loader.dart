import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:wedme1/constants/colors.dart';

class CustomLoader extends StatelessWidget {
  const CustomLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 90,
        width: 90,
        decoration: BoxDecoration(
            color: kPrimaryColor, borderRadius: BorderRadius.circular(10)),
        child: const 
        
        SpinKitRipple(
          color: Colors.white,
        ),
      ),
    );
  }
  //Center(child: Lottie.asset("assets/gif/loading.json")
}
