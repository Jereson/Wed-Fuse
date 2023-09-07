import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:social_media_recorder/main.dart';
import '../../../screens/preliminary/dashboard.dart';
import '/constants/colors.dart';
import '/screens/home_page/homepagescreen.dart';

class LeaveGroup extends StatefulWidget {
  const LeaveGroup({Key? key, required this.groupId}) : super(key: key);
  final String groupId;

  @override
  State<LeaveGroup> createState() => _LeaveGroupState();
}

class _LeaveGroupState extends State<LeaveGroup> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () => navigateToNextPage());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          height: 90,
          width: 90,
          decoration: BoxDecoration(
              color: kPrimaryColor, borderRadius: BorderRadius.circular(10)),
          child: const

          SpinKitRipple(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
  void navigateToNextPage() {
    FirebaseFirestore.instance.collection("groupChat").doc(widget.groupId).update(
        {
          "users":FieldValue.arrayRemove([FirebaseAuth.instance.currentUser!.uid])
        }).then((value) {

      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MyHomePage(),));
    });
  }
}
