import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:wedme1/screens/home_page/homepagescreen.dart';
import '../../../screens/preliminary/dashboard.dart';
import '../../../widget/custom_loader.dart';
import 'DocumentGroup.dart';
import 'MemberTabTop.dart';
import 'MembersList.dart';
import 'RowOfCall.dart';
import 'deleteGroup.dart';

class ChatGroupAdd extends StatefulWidget {
  const ChatGroupAdd({Key? key,
    required this.groupImg,
    required this.groupName,
    required this.groupId, required this.userId,
  }) : super(key: key);
  final String groupImg;
  final String groupName;
  final String groupId;
  final String userId;

  @override
  State<ChatGroupAdd> createState() => _ChatGroupAddState();
}

class _ChatGroupAddState extends State<ChatGroupAdd> {
  @override
  Widget build(BuildContext context) {
    return  DefaultTabController(
      length: 2,
      child: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance.collection("groupChat").doc(widget.groupId).snapshots(),
        builder: (context, snapshot) {
          if(snapshot.hasError&&!snapshot.hasData){
            return const Text("");
          }else{

            return Scaffold(
            backgroundColor: const Color(0xFFF9F9F9),
            body: SafeArea(
              child: Center(
                child: Column(
                  children: [
                    const SizedBox(height: 40,),
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(widget.groupImg),
                    ),
                    const SizedBox(height: 36,),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(widget.groupName,style: const TextStyle(fontWeight: FontWeight.w600,fontSize: 20),overflow: TextOverflow.ellipsis),
                    ),
                    Text("${snapshot.data?.get("users").length} members",style: const TextStyle(fontWeight: FontWeight.w500,fontSize: 12,color: Color(0xFF8A8A8A)),),
                    const SizedBox(height: 40,),
                     RowOfCall(groupId: widget.groupId, userId: widget.userId,),
                    const SizedBox(height: 46,),
                    const MemberTabTop(),
                    snapshot.data != null? Expanded(
                      child: tabViews(user: snapshot.data?.get("users")!, admin: snapshot.data?["userId"], addId: snapshot.data?["id"]),
                    ):const Text(""),
                   widget.userId==FirebaseAuth.instance.currentUser!.uid? InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => DeleteGroup(groupId: widget.groupId,),));

                        },
                        child: const Text("Delete Group",style: TextStyle(color: Colors.red,fontWeight: FontWeight.w600,fontSize: 16),)):const Text(""),
                    const SizedBox(height: 34,),

                  ],
                ),
              ),
            ),
          );
          }
        }
      ),
    );
  }

}


Widget tabViews({
  required List user,
  required String admin,
  required String addId,
}) {
  return     TabBarView(
      physics: const BouncingScrollPhysics(),
      dragStartBehavior: DragStartBehavior.down,
      children: [
        MembersList(users:user, admin: admin, addId: addId,),
        DocumentGroup(docId: addId,),

      ]);
}
