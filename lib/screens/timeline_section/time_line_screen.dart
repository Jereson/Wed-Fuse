import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:routemaster/routemaster.dart';
import 'package:sizer/sizer.dart';
import 'package:wedme1/constants/colors.dart';
import 'package:wedme1/getit.dart';
import 'package:wedme1/models/discover_model.dart';
import 'package:wedme1/models/live_model.dart';
import 'package:wedme1/screens/timeline_section/shareStory/galleryForStatus.dart';
import 'package:wedme1/utils/base_view_builder.dart';
import 'package:wedme1/viewModel/profile_vm.dart';

import 'package:wedme1/widget/app_bar_widget.dart';

import '../../Call/ZegCall/LiveStream.dart';
import '../../utils/constant_utils.dart';
import '../../utils/styles.dart';
import '../chat_screens/Camera/cameraChat.dart';
import 'AddToFeed/AddToFeed.dart';
import 'classOfTimeline.dart';
import 'feedscreen.dart';
import 'live_item.dart';
import 'notused.dart';

class TimeLineScreen extends ConsumerStatefulWidget {
  const TimeLineScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TimeLineScreenState();
}

class _TimeLineScreenState extends ConsumerState<TimeLineScreen> {
  void navigateToPost(
    BuildContext context,
  ) {
    Routemaster.of(context).push('/add-post');
  }

  bool everyone = true;
  bool noteveryone = false;
  String profilePix = profileAvaterUrl;

  final List<DiscoverModel> discoverModel = DiscoverModel.timeLineData;
  final List<LiveModel> liveModel = LiveModel.liveModelData;






  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserData();
  }

  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      // Call your function here
     getUserData();
    } else {

    }
  }

  String userName="";



  getUserData() async {
    DocumentSnapshot userSnapshot = await userCollection.get();
    userName = userSnapshot.get('photoUrl');
    //print(userName);
  }



  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: BaseViewBuilder<ProfileViewModel>(
      model: getIt(),
      builder: (pVm, _) {
          return Scaffold(
            appBar: CustomAppbar.matchScreenAppBar(context, size: size, photoUrl: pVm.cachedUserDetail!.photoUrl!),
            backgroundColor: Colors.white,
            body: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                Padding(
                padding: const EdgeInsets.only(
                  left: 10,
                ),
                child: Text(
                  "Live",
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
                  SizedBox(
                    height: 60,
                    width: MediaQuery.of(context).size.width * 1,
                    child: Row(
                      children: [
                        StreamBuilder<DocumentSnapshot>(
                            stream: FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).snapshots(),
                          builder: (context, snapshot) {
                            return InkWell(
                              onTap: () async {
                                // if(pVm.validateSubscriptionStus(pVm.cachedUserDetail!.subscriptionDueDate!)||pVm.cachedUserDetail!.subscriptionType=="proPremium"){
                                //   List friends = snapshot.data!["friends"];
                                //
                                //   Navigator.push(
                                //       context,
                                //       MaterialPageRoute(
                                //           builder: (context) =>
                                //               LivePage(liveID: '', localUserID: pVm.cachedUserDetail!.displayName!, cachedUserDetail: pVm.cachedUserDetail!.photoUrl!, friends: friends,)
                                //         //CameraScreenChat(UIDi: '',),
                                //       ));
                                // }
                                List friends = snapshot.data!["friends"];

                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            LivePage(liveID: '', localUserID: pVm.cachedUserDetail!.displayName!, cachedUserDetail: pVm.cachedUserDetail!.photoUrl!, friends: friends,)
                                      //CameraScreenChat(UIDi: '',),
                                    ));


                              },
                              child: StreamBuilder(
                                stream: null,
                                builder: (context, snapshot) {
                                  return
                                  CircleAvatar(
                                    radius: 24,
                                    backgroundImage: NetworkImage(pVm.cachedUserDetail!.photoUrl!),
                                    child: Stack(
                                      children: const [
                                        Positioned(
                                          bottom: -5,
                                          right: -6,
                                          child: CircleAvatar(
                                            radius: 18,
                                            backgroundColor: Colors.transparent,
                                            child: Icon(
                                              Icons.add_circle,
                                              color: Colors.red,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }
                              ),
                            );
                          }
                        ),
                        const Flexible(
                          child: LiveItem(),
                        ),
                      ],
                    ),
                  ),
                  const Divider(),
                  Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: Text(
                      "Discover",
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 1,
                  ),
                  const Expanded(
                    child: FeedDetails(),
                  )
                ],
              ),
            ),
            // floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
            floatingActionButton:
            StreamBuilder<DocumentSnapshot>(
                stream: FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).snapshots(),
              builder: (context, snapshot) {
                return Container(
                  color: Colors.transparent,
                  height: 51,
                  width: 128,
                  child: FloatingActionButton(
                    splashColor: const Color.fromARGB(255, 241, 31, 16),
                    backgroundColor: const Color.fromARGB(255, 241, 32, 17),
                    focusColor: const Color.fromARGB(255, 241, 50, 36),
                    onPressed: () async {
                      List friends = snapshot.data!["friends"];

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddFeed(
                              pic: profilePix, friends: friends,
                            ),
                          ));

                    },
                    child: const Icon(Icons.add),
                  ),
                );
              }
            ),
          );
        }
      ),
    );
  }

  addFeedFunction() {
    Size size = MediaQuery.of(context).size;
    return showModalBottomSheet(
      enableDrag: true,
      isScrollControlled: true,
      barrierColor: Colors.grey,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      backgroundColor: Colors.white,
      isDismissible: true,
      context: context,
      builder: (context) => Padding(
        padding: const EdgeInsets.only(right: 37, left: 37),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: 2.h,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Create Post",
                    style: Styles.headLineStyle2,
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                const Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Tell everyone what's on your mind",
                    style: TextStyle(
                      color: Color.fromARGB(255, 70, 68, 68),
                      fontSize: 14,
                    ),
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                TextField(
                  maxLines: 4,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                  ),
                ),
                const SizedBox(height: 2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: 185,
                      width: 120,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        image: const DecorationImage(
                            image:
                                AssetImage("assets/images/image_rectangle.png"),
                            fit: BoxFit.fill),
                      ),
                      child: const Center(
                        child: Text("Add\nImage",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14.0,
                            )),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 2,
                ),
                Text(
                  'Select who can view your post',
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 2),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      everyone = true;
                      noteveryone = false;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    width: size.width,
                    height: 54,
                    decoration: BoxDecoration(
                      color: everyone ? kPrimaryColor : Colors.grey[200],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.circle,
                          size: 15,
                          color: everyone ? Colors.white : kPrimaryColor,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          "Everyone can see",
                          style: TextStyle(
                            color: everyone ? Colors.white : Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w200,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      everyone = true;
                      noteveryone = false;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    width: size.width,
                    height: 54,
                    decoration: BoxDecoration(
                      color: everyone ? kPrimaryColor : Colors.grey[200],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.circle,
                          size: 15,
                          color: everyone ? Colors.white : kPrimaryColor,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          "Everyone can see",
                          style: TextStyle(
                            color: everyone ? Colors.white : Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w200,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      everyone = false;
                      noteveryone = true;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    width: size.width,
                    height: 54,
                    decoration: BoxDecoration(
                      color: noteveryone ? kPrimaryColor : Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: kPrimaryColor),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.circle,
                          size: 15,
                          color: noteveryone ? Colors.white : kPrimaryColor,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          "People who i have messaged can see",
                          style: TextStyle(
                            color: noteveryone ? Colors.white : Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w200,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Center(
                child: Container(
                  padding: const EdgeInsets.only(left: 37, right: 37),
                  width: 300,
                  height: 54,
                  decoration: BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      'Send Post',
                      style:
                          Styles.buttonTextStyle.copyWith(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 0.2.h),
          ],
        ),
      ),
    );
  }
}




