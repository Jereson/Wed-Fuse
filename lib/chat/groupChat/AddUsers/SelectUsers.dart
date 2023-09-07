import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:core';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import '/models/message_model.dart';

class SelectUsers extends StatefulWidget {
  const SelectUsers({Key? key, required this.addedUser,required this.addId}) : super(key: key);
  final List addedUser;
  final String addId;

  @override
  State<SelectUsers> createState() => _SelectUsersState();
}

class _SelectUsersState extends State<SelectUsers> with WidgetsBindingObserver {
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

  String? selectedUser;

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

  List selectedUsers = [];

  String nameUser = "";

  @override
  Widget build(BuildContext context) {
    final List<MessageModel> messageModel = MessageModel.messageList;
    if (messageModel.isNotEmpty) {
      return Scaffold(
        backgroundColor: const Color(0xFFF9F9F9),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppBar(
              toolbarHeight: 20,
              backgroundColor: Colors.white,
              elevation: 0,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.black,
                      )),
                  const Text(
                    "Add a Member",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              Container(
                color: Colors.transparent,
                height: 31,
                width: 79.71,
                padding: EdgeInsets.only(right: 12),
                child: FloatingActionButton(
                  backgroundColor: const Color(0xFF0234E6),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.horizontal(
                      right: Radius.circular(30),
                      left: Radius.circular(30),
                    ),
                  ),
                  onPressed: () {
                    print(selectedUsers);
                    FirebaseFirestore.instance.collection("groupChat").doc(widget.addId).update({
                      "users": FieldValue.arrayUnion(selectedUsers)
                    }).then((value) {
                      Navigator.pop(context);
                    });
                  },
                  child: Text(
                    'Add  ${selectedUsers.length}',
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ),
            ]),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 14, right: 14, bottom: 8),
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
                decoration: InputDecoration(
                  enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey)),
                  hintText: "Add a member",
                  filled: true,
                  fillColor: const Color(0xFFF9F9F9),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
                  isDense: true,
                  prefixIcon: const Icon(
                    Icons.person_add_alt_outlined,
                    color: Colors.black,
                    size: 22,
                  ),
                  suffixIcon: const Icon(
                    Icons.person_add_alt_outlined,
                    color: Color(0xFFF9F9F9),
                    size: 22,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.only(left: 14, right: 14, bottom: 8),
              child: Card(
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection("messageList")
                          .doc(FirebaseAuth.instance.currentUser!.uid)
                          .collection("individual")
                          .where('userId', whereNotIn: widget.addedUser)
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
                                      FirebaseAuth.instance.currentUser?.uid &&
                                  doc["fullName"].toString().contains(nameUser))
                              .toList();
                          return Column(
                            children: [
                              Row(
                                children: const [
                                  Text(
                                    "Friends",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                        color: Color(0xFF999999)),
                                  ),
                                ],
                              ),
                              Expanded(
                                child: ListView.builder(
                                    physics: const BouncingScrollPhysics(),
                                    itemCount: filteredDocs!.length,
                                    itemBuilder: ((context, index) {
                                      final sortedDocs = filteredDocs.toList()
                                        ..sort((a, b) =>
                                            b["order"].compareTo(a["order"]));
                                      final ee = sortedDocs[index];
                                      return Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 32.0),
                                        child: InkWell(
                                          onTap: () {
                                            setState(() {
                                              if (selectedUsers
                                                  .contains(ee["userId"])) {
                                                selectedUsers
                                                    .remove(ee["userId"]);
                                              } else {
                                                selectedUsers.add(ee["userId"]);
                                              }
                                              print(selectedUsers);
                                            });
                                          },
                                          child: SizedBox(
                                            width: double.infinity,
                                            child: Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .end,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            SizedBox(
                                                              child: Row(
                                                                children: [
                                                                  CircleAvatar(
                                                                    radius: 25,
                                                                    backgroundImage:
                                                                        NetworkImage(
                                                                            ee["photoUrl"]),
                                                                  ),
                                                                  const SizedBox(
                                                                    width: 20,
                                                                  ),
                                                                  Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Text(
                                                                        ee["fullName"],
                                                                        style: GoogleFonts
                                                                            .poppins(
                                                                          textStyle:
                                                                              TextStyle(
                                                                            fontWeight:
                                                                                FontWeight.w600,
                                                                            color:
                                                                                Colors.black,
                                                                            fontSize:
                                                                                14.sp,
                                                                          ),
                                                                        ),
                                                                        textAlign:
                                                                            TextAlign.start,
                                                                      ),
                                                                      Text(
                                                                        "Active",
                                                                        style: GoogleFonts
                                                                            .poppins(
                                                                          textStyle:
                                                                              TextStyle(
                                                                            fontWeight:
                                                                                FontWeight.w500,
                                                                            color:
                                                                                Colors.black,
                                                                            fontSize:
                                                                                12.sp,
                                                                          ),
                                                                        ),
                                                                        textAlign:
                                                                            TextAlign.start,
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
                                                    selectedUsers.contains(
                                                            ee["userId"])
                                                        ? const Icon(
                                                            Icons.check_circle,
                                                            color: Color(
                                                                0xFF0234E6),
                                                          )
                                                        : Text("")
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    })),
                              ),
                            ],
                          );
                        }
                      }),
                ),
              ),
            )),
          ],
        ),
      );
    } else {
      return const Text(" Empty list");
    }
  }
}
