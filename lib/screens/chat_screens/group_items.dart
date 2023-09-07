import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:wedme1/models/goup_model.dart';

class GroupItem extends StatelessWidget {
  const GroupItem({Key? key, this.groupModel}) : super(key: key);
  final GroupModel? groupModel;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(top: 2, left: 8, right: 18),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 4, right: 1),
            child: CircleAvatar(
              radius: 26,
              backgroundImage: AssetImage(groupModel!.groupIcon!),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: size.width / 4),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  groupModel!.name!,
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                      fontSize: 15.sp,
                    ),
                  ),
                  textAlign: TextAlign.center,
                ),
                Text(
                  groupModel!.description!,
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      fontWeight: FontWeight.w200,
                      color: Colors.red,
                      fontSize: 10.sp,
                    ),
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              right: 2,
            ),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 8,
                  backgroundColor: Colors.red,
                  child: Text(
                    groupModel!.messageCount!.toString(),
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        fontWeight: FontWeight.w200,
                        color: Colors.white,
                        fontSize: 10.sp,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
