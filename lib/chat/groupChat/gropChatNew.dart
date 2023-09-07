import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:core';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import '/models/message_model.dart';

import 'createGroup.dart';
import 'gropConversationScreen.dart';

class GroupChatNew extends StatefulWidget {
  const GroupChatNew({Key? key}) : super(key: key);

  @override
  State<GroupChatNew> createState() => _GroupChatNewState();
}

class _GroupChatNewState extends State<GroupChatNew>
    with WidgetsBindingObserver {
  final TextEditingController _searchTextController = TextEditingController();

  final FirebaseFirestore _fireStatus = FirebaseFirestore.instance;

  FirebaseAuth auth = FirebaseAuth.instance;
  String result = "";

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _searchTextController.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  void stState(String state) async {
    await _fireStatus
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({"state": state});
  }

  String nameUser = "";
  String chatRid(String user1, String user2) {
    if (user1[0].toLowerCase().codeUnits[0] >
        user2.toLowerCase().codeUnits[0]) {
      return "$user1$user2";
    } else {
      return "$user2$user1";
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<MessageModel> messageModel = MessageModel.messageList;
    if (messageModel.isNotEmpty) {
      return Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 14, right: 14, bottom: 8),
              child: TextFormField(
                controller: _searchTextController,
                obscureText: false,
                onChanged: (value) {
                  setState(() {
                    nameUser = value;
                  });
                },
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  hintText: "Search User",
                  enabled: true,
                  filled: true,
                  border: InputBorder.none,
                  suffixIcon: Icon(
                    Icons.search,
                    color: Colors.black,
                    size: 22,
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 14, horizontal: 10),
                  isDense: true,
                ),
              ),
            ),
        Padding(
            padding: const EdgeInsets.only(left: 14, right: 14, bottom: 8),
            child: InkWell(
              onTap: () {
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children:  [
                  StreamBuilder<DocumentSnapshot>(
                    stream: FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).snapshots(),
                    builder: (context, snapshot) {
                      if(!snapshot.hasData&&snapshot.hasError&&snapshot.connectionState==ConnectionState.waiting){
                        return const Text("");
                      }else{
                        final data = snapshot.data?.data() as Map<String, dynamic>?;
                        final isVerified = data?['isVerified'];
                       return isVerified==true?Row(
                         children:  [
                           InkWell(
                               onTap: () {
                                 Navigator.of(context).push(MaterialPageRoute(builder: (context) => const CreateGroupChat(pic: '',),));

                               },
                               child: const Text("Create Wedding Group", style: TextStyle(fontSize: 20, color: Colors.red),)),
                           const Icon(Icons.add, color: Colors.red,)

                         ],
                       ):const Text("You are not yet verify", style:TextStyle(fontSize: 16, color: Colors.red),);
                      }

                    }
                  ),
                ],
              ),
            ),
          ),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.only(left: 14, right: 14, bottom: 8),
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("groupChat")
                      .where('users',
                          arrayContains: FirebaseAuth.instance.currentUser!.uid)
                      .snapshots(),
                  builder: (_,
                      AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                          snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(child: Text(""));
                    } else if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const Text("");
                    } else {
                      final filteredDocs = snapshot.data?.docs
                          .where((doc) =>
                              doc.id !=
                                  FirebaseAuth.instance.currentUser?.uid &&
                              doc["name"].toString().contains(nameUser))
                          .toList();
                      return ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: filteredDocs!.length,
                          itemBuilder: ((context, index) {
                            final sortedDocs = filteredDocs.toList()
                              ..sort(
                                  (a, b) => b["name"].compareTo(a["name"]));
                            final ee = sortedDocs[index];
                            return GestureDetector(
                              onTap: () async {
                                FirebaseFirestore.instance.collection("groupChat").doc(ee["id"]).update({
                                  "count":0
                                });

                                  await Navigator.of(context)
                                      .push(MaterialPageRoute(
                                      builder: ((context) {
                                        if(nameUser.isEmpty){
                                          return GroupConversationScreen(
                                            //  messageModel: messageModel[index],
                                            profilePix: ee["photoUrl"],
                                            userNameD: ee["name"],
                                            online: "online",
                                            chatId: ee["id"],
                                            ide: ee["userId"], groupId: ee["id"], idChat: ee["id"], callId: ee["id"],
                                          );

                                        }else if(ee["fullName"].toString().toLowerCase().startsWith(nameUser)){
                                          return GroupConversationScreen(
                                            //  messageModel: messageModel[index],
                                            profilePix: ee["photoUrl"],
                                            userNameD: ee["name"],
                                            online: "online",
                                            chatId: ee["id"],
                                            ide: ee["userId"], groupId: ee["id"], idChat: ee["id"], callId: ee["id"],
                                          );

                                        }else{
                                          return Container();

                                        }
                                      }

                                      )))
                                      .then((value) {});
                              },
                              child: SizedBox(
                                width: double.infinity,
                                child: Column(
                                  children: [
                                    const SizedBox(height: 10,),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Row(
                                          children: [
                                            CircleAvatar(
                                                radius: 26,
                                                backgroundImage: NetworkImage(
                                                    ee["photoUrl"]),
                                                child: "state" == "online"
                                                    ? Stack(
                                                        children: const [
                                                          Positioned(
                                                            bottom: -8,
                                                            left: -6,
                                                            child: CircleAvatar(
                                                              radius: 14,
                                                              backgroundColor:
                                                                  Colors
                                                                      .transparent,
                                                              child: ImageIcon(
                                                                AssetImage(
                                                                    "assets/icons/online_icon.png"),
                                                                color: Colors
                                                                    .green,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      )
                                                    : Container()),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  width: MediaQuery.of(context).size.width*0.7,
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          SizedBox(
                                                            width: MediaQuery.of(context).size.width*0.5,
                                                            child: Text(
                                                              ee["name"],
                                                              overflow: TextOverflow.ellipsis,
                                                              style: GoogleFonts.poppins(
                                                                textStyle: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight.w400,
                                                                  color: Colors.black,
                                                                  fontSize: 14.sp,
                                                                ),
                                                               ),
                                                              textAlign: TextAlign.start,
                                                            ),
                                                          ),
                                                          ee["count"]==0?
                                                          Text(
                                                            ee["time"],
                                                            style: GoogleFonts.poppins(
                                                              textStyle: TextStyle(
                                                                fontWeight:
                                                                FontWeight.w400,
                                                                color: Colors.black,
                                                                fontSize: 12.sp,
                                                              ),
                                                            ),
                                                            textAlign: TextAlign.start,
                                                          ):
                                                          Text(
                                                            ee["time"],
                                                            style: GoogleFonts.poppins(
                                                              textStyle: TextStyle(
                                                                fontWeight:
                                                                FontWeight.w400,
                                                                color: Colors.red,
                                                                fontSize: 12.sp,
                                                              ),
                                                            ),
                                                            textAlign: TextAlign.start,
                                                          ),


                                                        ],
                                                      ),
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          ee["count"]==0?
                                                          SizedBox(
                                                            width: MediaQuery.of(context).size.width*0.5,
                                                            child: Text(
                                                              ee["lastChat"],
                                                              overflow: TextOverflow.ellipsis,
                                                              style: GoogleFonts.poppins(
                                                                textStyle: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight.w400,
                                                                  color: Colors.black,
                                                                  fontSize: 12.sp,
                                                                ),
                                                               ),
                                                              textAlign: TextAlign.start,
                                                            ),
                                                          ):
                                                          Text(
                                                            ee["lastChat"],
                                                            style: GoogleFonts.poppins(
                                                              textStyle: TextStyle(
                                                                fontWeight:
                                                                    FontWeight.w400,
                                                                color: Colors.red,
                                                                fontSize: 12.sp,
                                                              ),
                                                             ),
                                                            textAlign: TextAlign.start,
                                                          ),
                                                          ee["count"]==0?
                                                          const Text("✓✓"):
                                                          CircleAvatar(
                                                            radius: 12,
                                                            child: Text(
                                                              ee["count"].toString(),
                                                              style: GoogleFonts.poppins(
                                                                textStyle: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight.w400,
                                                                  color: Colors.white,
                                                                  fontSize: 10.sp,
                                                                ),
                                                               ),
                                                              textAlign: TextAlign.start,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10,)
                                  ],
                                ),
                              ),
                            );
                          }));
                    }
                  }),
            ))
          ],
        ),
      );
    } else {
      return const Text(" Empty list");
    }
  }
}