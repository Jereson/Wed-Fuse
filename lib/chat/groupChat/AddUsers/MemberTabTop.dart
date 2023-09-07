
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../constants/colors.dart';
class MemberTabTop extends StatelessWidget {
  const MemberTabTop({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12.0,right: 12),
      child: Container(
        alignment: Alignment.topCenter,
        child: TabBar(
            indicatorColor: kPrimaryColor,

            labelStyle: const TextStyle(color: Colors.black),
            tabs: [
              Tab(
                child: Text(
                  "Members",
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 15.sp,
                      )),
                ),
              ),
              Tab(
                child: Text(
                  "Documents",
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 15.sp,
                      )),
                ),
              ),
            ]),
      ),
    );
  }
}
