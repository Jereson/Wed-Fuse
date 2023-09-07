import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../models/users_detail_model.dart';
import '../../../screens/timeline_section/GroupChatDesign.dart';
import '../../../widget/user_list_item.dart';
import 'AddMembersGetLink.dart';

class MembersList extends StatefulWidget {
  const MembersList({Key? key,required this.users, required this.admin, required this.addId}) : super(key: key);
  final List users;
  final String admin;
  final String addId;

  @override
  State<MembersList> createState() => _MembersListState();
}

class _MembersListState extends State<MembersList> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Column(
        children:  [
           AddMembersGetLink(addedUser: widget.users, addId: widget.addId, adminBtn: widget.admin,),
          Expanded(
            flex: 50,
            child: StreamBuilder<List<UsersDetailModel>>(
          stream: FirebaseFirestore.instance
              .collection("users")
              .snapshots()
              .map((snapshot) {
            List<UsersDetailModel> userdata = [];
            for (var doc in snapshot.docs) {
              UsersDetailModel  userDetail = UsersDetailModel.fromJson(doc.data());
              if (widget.users.contains(userDetail.userId
              )) {
                userdata.add(userDetail);
              }
            }
            return userdata;
          }),
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting || !snapshot.hasData) {
            return const Center(child: Text("", style: TextStyle(color: Colors.red),));
          } else if(snapshot.hasData && snapshot.data!.isEmpty){
            return const Center(
              child: Text("No Body from your country yet", style: TextStyle(color: Colors.red)),
            );
          } else {
            return ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: snapshot.data?.length,
                itemBuilder: ((context, index) {
                  final userDetail = snapshot.data![index];
                  return GroupChatUserItem(
                    userDetail: userDetail,
                    indexTwo: index, idCurrent: widget.addId, admin: widget.admin,
                  );
                }));
          }
        }
    ),


    ),



        ],
      ),
    );
  }
}








