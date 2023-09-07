import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:wedme1/constants/colors.dart';
import 'package:wedme1/models/goup_model.dart';

import '../../widget/text_input.dart';
import 'group_items.dart';

class GroupChat extends StatefulWidget {
  const GroupChat({Key? key}) : super(key: key);

  @override
  State<GroupChat> createState() => _GroupChatState();
}

class _GroupChatState extends State<GroupChat> {
  final List<GroupModel>? groupModelist = GroupModel.groupList;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    if (groupModelist!.isNotEmpty) {
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 12, bottom: 20),
            child: CustomWidgets.textField("",
                suffixIcon: Icons.search, hint: "Search group"),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20, bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Create Wedding Group',
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: kPrimaryColor,
                      fontSize: 14.sp,
                    ),
                  ),
                ),
                const Icon(
                  Icons.add,
                  color: kPrimaryColor,
                )
              ],
            ),
          ),
          SizedBox(
            height: 2.h,
          ),
          Expanded(
            child: ListView.builder(
                itemCount: groupModelist!.length,
                itemBuilder: ((context, index) {
                  return GestureDetector(
                    onTap: () {
                      // here
                    },
                    child: GroupItem(
                      groupModel: groupModelist![index],
                    ),
                  );
                })),
          ),
        ],
      );
    } else {
      return const Text('No Data Yet');
    }
  }
}
