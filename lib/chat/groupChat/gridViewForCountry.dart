import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../constants/colors.dart';
import '../../screens/chat_screens/chat_screen.dart';
import '../messagesChatUp.dart';
import '/chat/groupChat/roomChatLikeHome.dart';

import '../../models/users_detail_model.dart';
import '../../widget/user_list_item.dart';

class GridViewCountries extends StatelessWidget {
  const GridViewCountries({
    super.key,
    required this.widget,
  });

  final RoomChatLikeHome widget;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Container(
        color: Colors.transparent,
        height: 51,
        width: 128,
        child: FloatingActionButton(
          splashColor: kPrimaryColor,
          backgroundColor: kPrimaryColor,
          focusColor: kPrimaryColor,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.horizontal(
              right: Radius.circular(30),
              left: Radius.circular(30),
            ),
          ),
          onPressed: () async {
            //Navigator.of(context).popUntil((route) => route.isFirst || route.settings.name == "/screen3");
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => ChatScreen(),
            //   ),
            // );
            Navigator.push(context, MaterialPageRoute(builder: (context) => MessageChatList(),));
          },
          child: Text(
            'Messages',
            style: GoogleFonts.poppins(
              textStyle: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.white,
                fontSize: 16.sp,
              ),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          const Expanded(
              flex: 1,
              child: SizedBox(height: 10,)),
          Expanded(
            flex: 50,
            child: StreamBuilder<List<UsersDetailModel>>(
                stream: FirebaseFirestore.instance
                    .collection("users")
                    .where('userId',
                    isNotEqualTo: FirebaseAuth.instance.currentUser!.uid)
                    .where("country", isEqualTo: widget.country)
                    .snapshots()
                    .map((snapshot) {
                  List<UsersDetailModel> userdata = [];
                  for (var doc in snapshot.docs) {
                    UsersDetailModel userDetail = UsersDetailModel.fromJson(doc.data());
                    userdata.add(userDetail);
                  }
                  return userdata;
                }),
                builder: (_, snapshot) {
                  if (snapshot.connectionState ==
                      ConnectionState.waiting && !snapshot.hasData&&!snapshot.hasData) {
                    return const Center(
                      child: Text("", style: TextStyle(color: Colors.red)),
                    );
                  } else if(snapshot.hasData && snapshot.data!.isEmpty){
                    return const Center(
                      child: Text("No Body from your country yet", style: TextStyle(color: Colors.red)),
                    );
                  } else if(!snapshot.hasData){
                    return const Center(
                      child: Text("", style: TextStyle(color: Colors.red)),
                    );
                  }else {
                    return GridView.builder(
                        gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                        ),
                        physics: const BouncingScrollPhysics(),
                        itemCount: snapshot.data?.length,
                        itemBuilder: ((context, index) {
                          final userDetail = snapshot.data![index];
                          return SizedBox(
                            height: MediaQuery.of(context).size.height * 0.75,
                            child: UserItem(
                              userDetail: userDetail,
                              indexTwo: index,
                            ),
                          );
                        }));
                  }
                }),
          ),
        ],
      ),
    );
  }
}
