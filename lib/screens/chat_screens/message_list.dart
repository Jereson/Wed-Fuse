import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:core';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import '../../getit.dart';
import '../../models/stack_model/users_model.dart';
import '../../utils/base_view_builder.dart';
import '../../viewModel/profile_vm.dart';
import '/models/message_model.dart';

import '../../chat/groupChat/roomChatLikeHome.dart';
import '../../constants/colors.dart';
import 'conversation_screen.dart';

class MessageList extends StatefulWidget {
  const MessageList({Key? key}) : super(key: key);

  @override
  State<MessageList> createState() => _MessageListState();
}

class _MessageListState extends State<MessageList> with WidgetsBindingObserver {
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
      return  BaseViewBuilder<ProfileViewModel>(
          model: getIt(),
          initState: (init) {

          },
          builder: (pVm, _) {
            false;
            return Scaffold(
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 14, right: 14, bottom: 8),
                    child: TextFormField(
                      controller: _searchTextController,
                      obscureText: false,
                      onChanged: (value) {
                        setState(() {
                          nameUser = value.isNotEmpty
                              ? value.substring(0, 1).toUpperCase() +
                                  value.substring(1).toLowerCase()
                              : '';
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
                  Expanded(
                      child: Padding(
                    padding:
                        const EdgeInsets.only(left: 14, right: 14, bottom: 8),
                    child: StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection("messageList")
                            .doc(FirebaseAuth.instance.currentUser!.uid)
                            .collection("individual")
                            .where('userId',
                                isNotEqualTo:
                                    FirebaseAuth.instance.currentUser!.uid)
                            .orderBy('userId', descending: true)
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
                                        FirebaseAuth
                                            .instance.currentUser?.uid &&
                                    doc["fullName"]
                                        .toString()
                                        .contains(nameUser))
                                .toList();
                            return ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                itemCount: filteredDocs!.length,
                                itemBuilder: ((context, index) {
                                  final sortedDocs = filteredDocs.toList()
                                    ..sort((a, b) =>
                                        b["order"].compareTo(a["order"]));
                                  final ee = sortedDocs[index];
                                  return GestureDetector(
                                    onTap: () async {
                                      FirebaseFirestore.instance
                                          .collection("blockUser")
                                          .doc(FirebaseAuth
                                              .instance.currentUser!.uid)
                                          .get()
                                          .then((value) {
                                        if (value.exists) {
                                          //FirebaseFirestore.instance.collection("blockUser").doc(FirebaseAuth.instance.currentUser!.uid).set({});
                                        } else {
                                          FirebaseFirestore.instance
                                              .collection("blockUser")
                                              .doc(FirebaseAuth
                                                  .instance.currentUser!.uid)
                                              .set({
                                            "whoBlcck": "",
                                          });
                                        }
                                      });
                                      FirebaseFirestore.instance
                                          .collection("blockUser")
                                          .doc(ee["userId"])
                                          .get()
                                          .then((value) {
                                        FirebaseFirestore.instance
                                            .collection("iHaveMessage")
                                            .doc(FirebaseAuth
                                                .instance.currentUser!.uid)
                                            .update({
                                          "iHaveMessage": 0,
                                        });
                                        if (value.exists) {
                                          //FirebaseFirestore.instance.collection("blockUser").doc(FirebaseAuth.instance.currentUser!.uid).set({});
                                        } else {
                                          FirebaseFirestore.instance
                                              .collection("blockUser")
                                              .doc(ee["userId"])
                                              .set({
                                            "whoBlcck": "",
                                          });
                                        }
                                      });

                                      String roomId = chatRid(
                                          FirebaseAuth
                                              .instance.currentUser!.uid,
                                          ee["userId"]);
                                      FirebaseFirestore.instance
                                          .collection("messageList")
                                          .doc(FirebaseAuth
                                              .instance.currentUser!.uid)
                                          .collection("individual")
                                          .doc(ee["userId"])
                                          .update({"count": 0});
                                      await Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: ((context) {
                                        if (nameUser.isEmpty) {
                                          return ConversationScreen(
                                            //messageM: messageModel[index],
                                            profilePix: ee["photoUrl"],
                                            userNameD: ee["fullName"],
                                            online: ee["state"],
                                            chatID: roomId,
                                            ide: ee["userId"],
                                            count: ee["count"].toString(),
                                            block: ee["block"],
                                            callId: ee["callId"],
                                            coin: pVm
                                                .cachedUserDetail!.coinBalance
                                                .toString(),
                                            balance: pVm
                                                .cachedUserDetail!.balance!
                                                .toString(),
                                          );
                                        } else if (ee["fullName"][0]
                                            .toString()
                                            .toLowerCase()
                                            .startsWith(
                                                nameUser[0].toUpperCase())) {
                                          return ConversationScreen(
                                            //messageM: messageModel[index],
                                            profilePix: ee["photoUrl"],
                                            userNameD: ee["fullName"],
                                            online: ee["state"],
                                            chatID: roomId,
                                            ide: ee["userId"],
                                            count: ee["count"],
                                            block: ee["block"],
                                            callId: ee["callId"],
                                            coin: pVm
                                                .cachedUserDetail!.coinBalance!
                                                .toString(),
                                            balance: pVm
                                                .cachedUserDetail!.balance!
                                                .toString(),
                                          );
                                        } else {
                                          return const Center(
                                              child: Text("User not found"));
                                        }
                                      }))).then((value) {});
                                    },
                                    child: SizedBox(
                                      width: double.infinity,
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Row(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                      top: 15,
                                                    ),
                                                    child: StreamBuilder<
                                                            DocumentSnapshot>(
                                                        stream:
                                                            FirebaseFirestore
                                                                .instance
                                                                .collection(
                                                                    "users")
                                                                .doc(ee[
                                                                    "userId"])
                                                                .snapshots(),
                                                        builder: (context,
                                                            snapshot) {
                                                          var state = snapshot
                                                              .data?["state"];
                                                          if (snapshot.hasError &&
                                                              !snapshot
                                                                  .hasData &&
                                                              snapshot.connectionState ==
                                                                  ConnectionState
                                                                      .waiting) {
                                                            return const Text(
                                                                "");
                                                          } else {
                                                            if (state ==
                                                                "online") {}
                                                            return CircleAvatar(
                                                                radius: 26,
                                                                backgroundImage:
                                                                    NetworkImage(ee[
                                                                        "photoUrl"]),
                                                                child: state ==
                                                                        "online"
                                                                    ? Stack(
                                                                        children: const [
                                                                          Positioned(
                                                                            bottom:
                                                                                -8,
                                                                            left:
                                                                                -6,
                                                                            child:
                                                                                CircleAvatar(
                                                                              radius: 14,
                                                                              backgroundColor: Colors.transparent,
                                                                              child: ImageIcon(
                                                                                AssetImage("assets/icons/online_icon.png"),
                                                                                color: Colors.green,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      )
                                                                    : Container());
                                                          }
                                                        }),
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      SizedBox(
                                                        width: 200,
                                                        child: Text(
                                                          ee["fullName"],
                                                          style: GoogleFonts
                                                              .poppins(
                                                            textStyle:
                                                                TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 14.sp,
                                                            ),
                                                          ),
                                                          textAlign:
                                                              TextAlign.start,
                                                        ),
                                                      ),
                                                      Container(
                                                        child: ee["count"] == 0
                                                            ? Text(
                                                                ee["latestChat"] ??
                                                                    const Text(
                                                                        ""),

                                                                style:
                                                                    GoogleFonts
                                                                        .poppins(
                                                                  textStyle:
                                                                      TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w200,
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        10.sp,
                                                                  ),
                                                                ),
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                              )
                                                            : Text(
                                                                ee["latestChat"] ??
                                                                    const Text(
                                                                        ""),
                                                                style:
                                                                    GoogleFonts
                                                                        .poppins(
                                                                  textStyle:
                                                                      TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w200,
                                                                    color: Colors
                                                                        .red,
                                                                    fontSize:
                                                                        10.sp,
                                                                  ),
                                                                ),
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                              ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                children: [
                                                  Container(
                                                      child: ee["count"] == 0
                                                          ? Text(
                                                              ee["time"],
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .black),
                                                            )
                                                          : Text(
                                                              ee["time"],
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .red),
                                                            )),
                                                  Container(
                                                      child: ee["count"] == 0
                                                          ? const Text("✓✓")
                                                          : CircleAvatar(
                                                              radius: 8,
                                                              child: Text(
                                                                ee["count"]
                                                                    .toString(),
                                                                style:
                                                                    const TextStyle(
                                                                        fontSize:
                                                                            8),
                                                              ))),
                                                ],
                                              )
                                            ],
                                          ),
                                          const Divider(),
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
              floatingActionButton: ProfileViewModel().validateSubscriptionStus(pVm.cachedUserDetail?.subscriptionDueDate ?? "${DateTime.now()}") &&
                  pVm.cachedUserDetail?.subscriptionType == "premium"
                  ? const FloatingActionChatRoom()
                  : Container(),
            );
          });
    } else {
      return const Text(" Empty list");
    }
  }
}

class FloatingActionChatRoom extends StatelessWidget {
  const FloatingActionChatRoom({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
          SharedPreferences prefs = await SharedPreferences.getInstance();
          String? selectedCountry = prefs.getString('sortname');
          String? selectedCountryS = prefs.getString('selectedCountryS');
          if (selectedCountry == null && selectedCountryS == null) {
          } else {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => RoomChatLikeHome(
                country: selectedCountry!,
                state: selectedCountryS!,
              ),
            ));
          }
        },
        child: Text(
          'ChatRoom',
          style: GoogleFonts.poppins(
            textStyle: TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.white,
              fontSize: 16.sp,
            ),
          ),
        ),
      ),
    );
  }
}
