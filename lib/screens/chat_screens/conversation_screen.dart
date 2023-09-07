import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:stacked/stacked.dart';
import '../../Call/ZegCall/AudioCall.dart';
import '../../Call/ZegCall/ZegCall.dart';
import '../../models/stack_model/users_model.dart';
import '../../utils/flushbar_widget.dart';
import '/screens/chat_screens/conversation_body.dart';
import '../../constants/colors.dart';
import '../../getit.dart';
import '../../utils/base_view_builder.dart';
import '../../viewModel/profile_vm.dart';

class ConversationScreen extends StatefulWidget {
  const ConversationScreen({
    Key? key,
    //  this.messageM,
    required this.profilePix,
    required this.count,
    required this.callId,
    required this.userNameD,
    required this.online,
    required this.block,
    required this.ide,
    required this.chatID,
    required this.coin,
    required this.balance,
  }) : super(key: key);
  //final messageM;
  final String profilePix;
  final String userNameD;
  final bool block;
  final String count;
  final String online;
  final String callId;
  final String chatID;
  final String ide;
  final String coin;
  final String balance;
  // String docID;

  @override
  State<ConversationScreen> createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  _ConversationScreenState();
  final TextEditingController _giftController = TextEditingController();
  String friendPrice = "";
  String subscriptionDueDate = "";

  getFriendDetail() {
    FirebaseFirestore.instance
        .collection("users")
        .doc(widget.ide)
        .get()
        .then((value) {
      friendPrice.isEmpty;
      friendPrice = value.data()!["coinBalance"].toString();
      subscriptionDueDate = value.data()!["subscriptionDueDate"].toString();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getFriendDetail();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<UsersModel>.reactive(
      viewModelBuilder: () => UsersModel(),
      onViewModelReady: (viewModel) async {
        await viewModel.dsNow();
      },
      builder: (context, viewModel, child) => Scaffold(
          appBar: AppBar(
            elevation: 0,
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            flexibleSpace: SafeArea(
              child: Container(
                padding: const EdgeInsets.only(right: 4, top: 6),
                child: Column(
                  children: [
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                                onPressed: () {
                                  FirebaseFirestore.instance
                                      .collection("messageList")
                                      .doc(FirebaseAuth
                                          .instance.currentUser!.uid)
                                      .collection("individual")
                                      .doc(widget.ide)
                                      .update({"count": 0});
                                  Navigator.of(context).pop();
                                },
                                icon: const Icon(
                                  Icons.arrow_back_ios,
                                )),
                            InkWell(
                              onTap: () {},
                              child: CircleAvatar(
                                radius: 20,
                                backgroundImage:
                                    NetworkImage(widget.profilePix),
                                child: widget.online == "online"
                                    ? Stack(
                                        children: const [
                                          Positioned(
                                            bottom: -10,
                                            right: -12,
                                            child: CircleAvatar(
                                                radius: 18,
                                                backgroundColor:
                                                    Colors.transparent,
                                                child: Image(
                                                    image: AssetImage(
                                                        "assets/icons/online_icon.png"))),
                                          ),
                                        ],
                                      )
                                    : Container(),
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.3,
                              child: Text(
                                widget.userNameD,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14.sp,
                                )),
                              ),
                            ),
                            Container(
                              width: 30,
                              height: 30,
                              decoration: const BoxDecoration(
                                  color: kPrimaryColor,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10),
                                  )),
                              margin: const EdgeInsets.all(10),
                              child: GestureDetector(
                                onTap: () {
                                  if(    ProfileViewModel().validateSubscriptionStus(
                                      viewModel.userAccount?.subscriptionDueDate ??
                                          "${DateTime.now()}") &&
                                      viewModel.userAccount?.subscriptionType == "premium"){
                                    Navigator.of(context).push(MaterialPageRoute(
                                        builder: ((context) => AudioCallPage(
                                          username: widget.userNameD,
                                          chatId: widget.chatID,
                                          callId: "testing",
                                        )
                                            //PrebuiltCallPage(username: widget.userNameD, chatId: widget.chatID, callId: 'new',)
                                            // const VoiceCallScreen()
                                        )));
                                  }else{

                                  }
                                },
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(80),
                                    child: const Image(
                                        image: AssetImage(
                                            "assets/icons/phone_icon.png"))),
                              ),
                            ),
                            Container(
                              width: 30,
                              height: 30,
                              decoration: const BoxDecoration(
                                  color: kPrimaryColor,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10),
                                  )),
                              margin: const EdgeInsets.all(10),
                              child: GestureDetector(
                                onTap: () {
                                  if(    ProfileViewModel().validateSubscriptionStus(
                                      viewModel.userAccount?.subscriptionDueDate ??
                                          "${DateTime.now()}") &&
                                      viewModel.userAccount?.subscriptionType == "premium"){
                                    Navigator.of(context).push(MaterialPageRoute(
                                        builder: ((context) => PrebuiltCallPage(
                                          username: widget.userNameD,
                                          chatId: widget.chatID,
                                          callId: "testing",
                                        )
                                            //PrebuiltCallPage(username: widget.userNameD, chatId: widget.chatID, callId: 'new',)
                                            // const VoiceCallScreen()
                                        )));

                                  }else{
                                  }

                                },
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(80),
                                    child: const Image(
                                        image: AssetImage(
                                            "assets/icons/video_call_icon.png"))),
                              ),
                            ),
                            PopupMenuButton<String>(
                              onSelected: (String choice) {

                                if(    ProfileViewModel().validateSubscriptionStus(viewModel.userAccount?.subscriptionDueDate ??
                                        "${DateTime.now()}") &&
                                    viewModel.userAccount?.subscriptionType == "premium")
                                {
                                  if (choice == 'Gift coin') {
                                    _showNAlertDialog(
                                        fName: widget.userNameD,
                                        pVm: viewModel.userAccount,
                                        balance: widget.balance,
                                        coin: widget.coin,
                                        friendId: widget.ide);
                                  } else if (choice == "Block") {
                                    _showNAlertDialogBlock(
                                        fName: widget.userNameD,
                                        userId: widget.ide);
                                  } else if (choice == "Unblock") {}
                                }else{
                                  flushbar(
                                      context: context,
                                      title: 'Access Denied',
                                      message:
                                      'Upgrade or update your account to premium to access to this feature',
                                      isSuccess: false
                                  );
                                }

                              },
                              itemBuilder: (BuildContext context) {
                                return [
                                  const PopupMenuItem<String>(
                                    value: 'Gift coin',
                                    child: Text('Gift coin'),
                                  ),
                                  widget.block == true
                                      ? const PopupMenuItem<String>(
                                          value: 'Unblock',
                                          child: Text(
                                            'Unblock',
                                            style: TextStyle(color: Colors.red),
                                          ),
                                        )
                                      : const PopupMenuItem<String>(
                                          value: 'Block',
                                          child: Text(
                                            'Block',
                                            style: TextStyle(color: Colors.red),
                                          ),
                                        ),
                                ];
                              },
                              icon: const Icon(Icons.more_vert),
                            )
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          backgroundColor: Colors.white,
          body: ConversationBody(
            chatRoomId: widget.chatID,
            userAccount:viewModel.userAccount,
            idj: widget.ide,
            photoUrl: widget.profilePix,
            state: widget.online,
            userId: widget.ide,
            fullName: widget.userNameD,
            currentUserID: viewModel.userAccount?.userId??"",
            currentFullName: viewModel.userAccount?.fullName??"",
            currentPhotoUrl: viewModel.userAccount?.photoUrl??"",
            docID: '',
            count: widget.count,
            block: widget.block,
            whoBlock: widget.online, subscriptionDueDate: viewModel.userAccount?.subscriptionDueDate??"",
          )),
    );
  }

  void _showNAlertDialog(
      {required String fName,
      required  pVm,
      required String friendId,
      required String balance,
      required String coin}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ViewModelBuilder<UsersModel>.reactive(
          viewModelBuilder: () => UsersModel(),
          onViewModelReady: (viewModel) async {
            await viewModel.dsNow();
          },
          builder: (context, viewModel, child) => AlertDialog(
            backgroundColor: Colors.white,
            shape: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(16))),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Gift Coins",
                      style: TextStyle(fontSize: 16),
                    ),
                    InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Image.asset(
                          "assets/images/img_14.png",
                          height: 14,
                          width: 14,
                        )),
                  ],
                ),
                const Divider(),
                const SizedBox(height: 10),
                Container(
                  height: 58,
                  padding: const EdgeInsets.only(left: 10),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10))),
                  child: Row(
                    children: [
                      const Icon(CupertinoIcons.money_dollar_circle),
                      Expanded(
                        child: TextFormField(
                          controller: _giftController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                              hintText: "",
                              hintStyle: TextStyle(color: Color(0xFF360001)),
                              border: InputBorder.none),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  height: 58,
                  padding: const EdgeInsets.only(left: 10),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10))),
                  child: Row(
                    children: [
                      const Icon(CupertinoIcons.person),
                      Expanded(
                        child: Text(
                          fName,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                InkWell(
                  onTap: () {
                    print("dfkdff;dfdkfd${viewModel.userAccount?.subscriptionDueDate}");
                    FirebaseFirestore.instance
                        .collection("users")
                        .doc(friendId)
                        .get()
                        .then((value) {
                      setState(() {
                        friendPrice = value.data()!["coinBalance"].toString();
                      });

                      int giftAmount = int.parse(_giftController.text.trim());
                      var coinBalance = viewModel.userAccount?.coinBalance;
                      int userBalance = int.parse(
                              viewModel.userAccount!.coinBalance.toString()) -
                          giftAmount.toInt();

                      int friendBalance =
                          int.parse(friendPrice) + giftAmount.toInt();
                      if (giftAmount == 0) {
                        flushbar(
                            context: context,
                            title: 'insufficient coin',
                            message:
                            "You don't have enough coins. Please fund your wallet",
                            isSuccess: false
                        );
                        print("Gift amount is 0");
                      } else if (giftAmount < 0) {
                        flushbar(
                            context: context,
                            title: 'insufficient coin',
                            message:
                            "You don't have enough coins. Please fund your wallet",
                            isSuccess: false
                        );
                        print("Gift amount is negative");
                      }else if(ProfileViewModel().validateSubscriptionStus(viewModel.userAccount?.subscriptionDueDate??"${DateTime.now()}")){
                        if (coinBalance! >= giftAmount) {
                          FirebaseFirestore.instance
                              .collection("users")
                              .doc(FirebaseAuth.instance.currentUser!.uid)
                              .update({"coinBalance": userBalance}).then((value) {
                            FirebaseFirestore.instance
                                .collection("users")
                                .doc(friendId)
                                .update({"coinBalance": friendBalance});
                          }).then((value) {
                            _showNAlertDialogDone(
                                fName: fName, coin: _giftController.text.trim());
                          });
                        }
                      }


                 else {
                        print("Not enough coins to gift");
                      }
                    });
                  },
                  child: Container(
                    height: 58,
                    padding: const EdgeInsets.only(left: 10),
                    decoration: BoxDecoration(
                        color: Colors.red,
                        border: Border.all(color: Colors.red),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10))),
                    child: const Center(
                      child: Text(
                        "Gift coins",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showNAlertDialogBlock({
    required String fName,
    required String userId,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(16))),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "",
                    style: TextStyle(fontSize: 16),
                  ),
                  InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Image.asset(
                        "assets/images/img_14.png",
                        height: 14,
                        width: 14,
                      )),
                ],
              ),
              const Divider(),
              const SizedBox(height: 10),
              Container(
                height: 58,
                width: double.infinity,
                padding: const EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.white),
                    borderRadius: const BorderRadius.all(Radius.circular(10))),
                child: Center(
                  child: Text(
                    "Are you sure you want to block $fName?",
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.black),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              InkWell(
                onTap: () {
                  FirebaseFirestore.instance
                      .collection("blockUser")
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                      .update({
                    "whoBlcck": FieldValue.arrayUnion([FirebaseAuth.instance.currentUser!.uid]),
                  }).then((value) {
                    FirebaseFirestore.instance
                        .collection("blockUser")
                        .doc(userId)
                        .update({
                      "whoBlcck": FieldValue.arrayUnion([FirebaseAuth.instance.currentUser!.uid]),
                    });
                  });
                  FirebaseFirestore.instance
                      .collection("messageList")
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                      .collection("individual")
                      .doc(userId)
                      .update({
                    "block": true,
                    "state": FirebaseAuth.instance.currentUser!.uid,
                  }).then((value) {
                    FirebaseFirestore.instance
                        .collection("messageList")
                        .doc(userId)
                        .collection("individual")
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .update({
                      "block": true,
                      "state": FirebaseAuth.instance.currentUser!.uid,
                    });
                  }).then((value) {
                    Navigator.pop(context);
                  });
                  // FirebaseFirestore.instance.runTransaction((transaction) async {
                  //   DocumentSnapshot snapshot = await transaction.get(FirebaseFirestore.instance.collection('messageList').doc(FirebaseAuth.instance.currentUser!.uid).collection("individual").doc(userId));
                  //   int counter = snapshot.get('count');
                  //   if (true) {
                  //     counter++;
                  //   } else {
                  //     counter--;
                  //   }
                  //   transaction.update(
                  //       FirebaseFirestore.instance.collection('messageList').doc(FirebaseAuth.instance.currentUser!.uid).collection("individual").doc(userId),
                  //       {'count': counter});
                  // });
                },
                child: Container(
                  height: 58,
                  padding: const EdgeInsets.only(left: 10),
                  decoration: BoxDecoration(
                      color: Colors.red,
                      border: Border.all(color: Colors.red),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10))),
                  child: const Center(
                    child: Text(
                      "Block",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }

  void _showNAlertDialogDone({
    required String fName,
    required String coin,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(16))),
          // title:  Text(''),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "",
                    style: TextStyle(fontSize: 16),
                  ),
                  InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Image.asset(
                        "assets/images/img_14.png",
                        height: 14,
                        width: 14,
                      )),
                ],
              ),
              const Divider(),
              const SizedBox(height: 10),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.white),
                    borderRadius: const BorderRadius.all(Radius.circular(10))),
                child: const Center(
                  child: Text(
                    "Done!",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ),
              Container(
                height: 58,
                width: double.infinity,
                padding: const EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.white),
                    borderRadius: const BorderRadius.all(Radius.circular(10))),
                child: Center(
                  child: Text(
                    "You have gifted $coin coins to $fName",
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.black),
                  ),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }
}

class UserModel extends BaseViewModel {
  var userId = FirebaseAuth.instance.currentUser!.uid;

  UsersModelView? userAccount;
  int currentIndex = 0;

  dsNow() {
    var userId = FirebaseAuth.instance.currentUser!.uid;
    FirebaseFirestore.instance
        .collection("users")
        .doc(userId)
        .get()
        .then((value) {
      userAccount = UsersModelView.fromJson(value.data()!);
      // notifyListeners();
    });
  }
}

UsersModelView usersModelViewFromJson(String str) =>
    UsersModelView.fromJson(json.decode(str));

String usersModelViewToJson(UsersModelView data) => json.encode(data.toJson());

class UsersModelView {
  String userId;
  String balance;
  String coinBalance;
  String displayName;

  UsersModelView({
    required this.userId,
    required this.balance,
    required this.coinBalance,
    required this.displayName,
  });

  factory UsersModelView.fromJson(Map<String, dynamic> json) => UsersModelView(
        userId: json["userId"],
        balance: json["balance"],
        coinBalance: json["coinBalance"],
        displayName: json["displayName"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "balance": balance,
        "coinBalance": coinBalance,
        "displayName": displayName,
      };
}
