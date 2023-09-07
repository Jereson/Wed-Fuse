import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '/screens/chat_screens/chat_screen.dart';

import '/screens/home_page/homepagescreen.dart';
import '/screens/notifications_screens/notification_screen.dart';

import '../likes_and_match_screen/match_screen.dart';
import '../timeline_section/time_line_screen.dart';

class MyHomePage extends StatefulWidget with WidgetsBindingObserver {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      // Call your function here
      FirebaseFirestore.instance
          .collection("liveStream")
          .doc(FirebaseAuth
          .instance.currentUser!.uid)
          .delete();
      FirebaseFirestore.instance.collection("iHaveMessage").doc(FirebaseAuth.instance.currentUser!.uid).get().then((value) {
        if(value.exists){
        }else{
          FirebaseFirestore.instance.collection("iHaveMessage").doc(FirebaseAuth.instance.currentUser!.uid).set({
            "iHaveMessage":"",
          });
        }
      });

      await FirebaseFirestore.instance
          .collection("haveMessage")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set({"name": ""});
      await FirebaseFirestore.instance
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .update({"state": "online"}).then((value) {
        FirebaseFirestore.instance
            .collection("haveMessage")
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .update({"name": ""});
      });
    } else if (state == AppLifecycleState.inactive) {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .update({"state": "offline"});
    } else {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .update({"state": "offline"});
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  int currentIndex = 0;
  final screens = [
    const HomeScreen(),
    const TimeLineScreen(),
    const ChatScreen(),
    const MatchScreen(),
    const NotificationScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance.collection("iHaveMessage").doc(FirebaseAuth.instance.currentUser!.uid).snapshots(),
      builder: (context, snapshot) {
        if(!snapshot.hasData&&snapshot.hasError){
          return const Text("");
        }else{
          var dd = snapshot.data;
        return Scaffold(
          bottomNavigationBar: BottomNavigationBar(
              unselectedItemColor: const Color.fromARGB(255, 36, 35, 35),
              selectedLabelStyle: GoogleFonts.poppins(
                textStyle: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w400,
                  letterSpacing: -0.41,
                ),
              ),
              unselectedLabelStyle: GoogleFonts.poppins(
                textStyle: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w400,
                  letterSpacing: -0.41,
                ),
              ),
              selectedItemColor: Colors.red,
              backgroundColor: Colors.white,
              currentIndex: currentIndex,
              type: BottomNavigationBarType.fixed,
              onTap: (index) {
                setState(() {
                  currentIndex = index;
                });
              },
              items: [
                BottomNavigationBarItem(
                  icon: Image.asset(
                    "assets/icons/home_icon.png",
                    height: 24,
                    width: 24,
                  ),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Image.asset(
                    "assets/icons/timeline_icon.png",
                    height: 24,
                    width: 24,
                  ),
                  label: 'Timeline',
                ),
               dd?["iHaveMessage"]==0? BottomNavigationBarItem(
                 icon: Image.asset(
                   "assets/images/img_17.png",
                   height: 24,
                   width: 24,
                 ),
                 label: 'Chatroom',
               ):BottomNavigationBarItem(
                  icon: Image.asset(
                    "assets/icons/chat_screen_icon.png",
                    height: 24,
                    width: 24,
                  ),
                  label: 'Chatroom',
                ),
                BottomNavigationBarItem(
                  icon: Image.asset(
                    "assets/icons/likes_icon.png",
                    height: 24,
                    width: 24,
                  ),
                  label: 'Likes',
                ),
                BottomNavigationBarItem(
                  icon: Image.asset(
                    "assets/icons/notification_icon.png",
                    height: 24,
                    width: 24,
                  ),
                  label: 'Notification',
                ),
              ]),
          backgroundColor: const Color.fromARGB(255, 247, 242, 242),
          body: screens[currentIndex],
        );
        }
      }
    );
  }
}
