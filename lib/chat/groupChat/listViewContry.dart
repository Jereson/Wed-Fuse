import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wedme1/chat/groupChat/roomChatLikeHome.dart';

import '../../constants/colors.dart';
import '../../models/users_detail_model.dart';
import '../../widget/user_list_item.dart';
import '../messagesChatUp.dart';

class ListViewCountry extends StatelessWidget {
  const ListViewCountry({
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
            Navigator.push(context, MaterialPageRoute(builder: (context) => const MessageChatList(),));
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
      body: Padding(
        padding: const EdgeInsets.only(top: 14),
        child: Column(
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
                      UsersDetailModel  userDetail = UsersDetailModel.fromJson(doc.data());
                      userdata.add(userDetail);
                    }


                    return userdata;
                  }),
                  builder: (_, snapshot) {
                    if (snapshot.connectionState ==
                        ConnectionState.waiting||!snapshot.hasData) {
                      return const Center(child: Text("", style: TextStyle(color: Colors.red),));
                    } else if(snapshot.hasData && snapshot.data!.isEmpty){
                      return const Center(
                        child: Text("No Body from your country yet", style: TextStyle(color: Colors.red)),
                      );
                    }else {
                      return ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: snapshot.data?.length,
                          itemBuilder: ((context, index) {
                            // final ee = snapshot.data!.docs[index];
                            final userDetail = snapshot.data![index];

                            return SizedBox(
                              // height: 550,
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
      ),
    );
  }
}
