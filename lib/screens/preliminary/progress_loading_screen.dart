import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:lottie/lottie.dart';

import 'package:wedme1/getit.dart';

import 'package:wedme1/viewModel/profile_vm.dart';

class ProgressLoadingScreen extends StatefulWidget {
  const ProgressLoadingScreen({super.key});

  @override
  State<ProgressLoadingScreen> createState() => _ProgressLoadingScreenState();
}

class _ProgressLoadingScreenState extends State<ProgressLoadingScreen> {
  late Timer _timer;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _startTimer();
    FirebaseFirestore.instance.collection("iHaveMessage").doc(FirebaseAuth.instance.currentUser!.uid).get().then((value) {
      if(value.exists){
      }else{
        FirebaseFirestore.instance.collection("iHaveMessage").doc(FirebaseAuth.instance.currentUser!.uid).set({
          "iHaveMessage":0,
        });
      }
    }).then((value) {
      getIt.get<ProfileViewModel>().getUserProfile(context);

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        // height: size.height,
        width: double.infinity,
        child: Stack(
          children: <Widget>[
            Positioned(
                right: 0,
                bottom: -50,
                child: Image.asset("assets/images/wedme-pattern.png")),
            Positioned.fill(
                child: Center(child: Lottie.asset("assets/gif/loading.json")))
          ],
        ),
      ),
    );
  }
}
