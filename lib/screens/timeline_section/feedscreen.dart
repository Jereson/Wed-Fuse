import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import '../../getit.dart';
import '../../utils/base_view_builder.dart';
import '../../viewModel/marriage_vm.dart';
import '../Profile/profile_screen/report_problem.dart';
import 'AddToFeed/SharedTrue.dart';
import 'AddToFeed/updateAddtoFeed.dart';
import 'discover_items.dart';

class FeedDetails extends StatefulWidget {
  const FeedDetails({Key? key}) : super(key: key);

  @override
  State<FeedDetails> createState() => _FeedDetailsState();
}

class _FeedDetailsState extends State<FeedDetails> with WidgetsBindingObserver {
  late bool dd;
  late int counted;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      await FirebaseFirestore.instance
          .collection("discoverModel")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get()
          .then((v) {
        dd = v.data()!["alike"];
      });
      await FirebaseFirestore.instance
          .collection("discoverModel")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get()
          .then((v) {
        counted = v.data()!["counter"];
        // print(counted);
      });
    } else {
      //print("off");
    }
  }

  bool like = false;
  int countLike = 0;

  var network = ConnectionState;
  var waitInt = ConnectionState.none;
  int counter = 0;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  bool _isItemHidden = true;
  var user = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    //print(counted);
    return BaseViewBuilder<MarriageViewModel>(
        model: getIt(),
        builder: (mVm, _) {
          return Scaffold(
            key: _scaffoldKey,
            body: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("discoverModel").where("friends",arrayContains: FirebaseAuth.instance.currentUser!.uid)

                  .snapshots(),
              builder: (_,
                  AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: Text(""),
                  );
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Center(
                    child: Text(""),
                  );
                } else {
                  var filteredDocs = snapshot.data!.docs.where((docSnapshot) {
                    List userIds = docSnapshot["users"];
                    return !userIds
                        .contains(FirebaseAuth.instance.currentUser!.uid);
                  }).toList();
                  filteredDocs.sort((a, b) {
                    var timeA = a["time"] ; // Assuming the "time" field is of type Timestamp
                    var timeB = b["time"];
                    return timeA.compareTo(timeB); // Sort in descending order
                  });

                  return ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: filteredDocs.length,
                    reverse: false,
                    controller: _scrollController,
                    itemBuilder: (context, index) {
                      var ds = filteredDocs[index];

                      return SizedBox(
                        child: ds["sharedPost"] == true
                            ? SharedPost(
                                imgUrl: ds["img"],
                                profileImageUrl: ds["sharedProfilePic"],
                                userName: ds["name"],
                                dateUpload: ds["timeTw"],
                                textPose: ds["writeUp"],
                                countN: ds["counter"],
                                id: ds["id"],
                                iconOnPressed: () {
                                  if (mounted == true) {
                                    if (ds["currentUserID"] ==
                                        FirebaseAuth
                                            .instance.currentUser?.uid) {
                                      _showAlertDialog(
                                          context: context,
                                          postID: ds["id"].toString(),
                                          text: ds["writeUp"].toString(),
                                          imagePost: ds["img"].toString(),
                                          images: ds["multiImage"]);
                                    } else {
                                      _showNAlertDialog(ds["id"].toString());
                                    }
                                  }
                                },
                                date: ds["time"],
                                like: ds["like"],
                                share: ds["share"],
                                comments: ds["comments"],
                                listImage: ds["multiImage"],
                                sharedUserName: ds["sharedName"],
                                sharedDateUpload: ds["sharedTime"],
                                sharedTextPose: ds["sharedWriteUp"],
                                sharedListImage: ds["sharedMultiImage"],
                                shareCountShow: ds["sharedLike"],
                                shareComments: ds["sharedComments"], shareShare: ds["sharedShare"], currentImageUrl: ds["profilePic"], index: index,
                              )
                            : DiscoverItem(
                                imgUrl: ds["img"],
                                profileImageUrl: ds["profilePic"],

                                userName: ds["name"],
                                dateUpload: ds["timeTw"],
                                textPose: ds["writeUp"],
                                id: ds["id"],
                                countShow: ds["counter"],
                                iconOnPressed: () {
                                  if (mounted == true) {
                                    if (ds["currentUserID"] ==
                                        FirebaseAuth
                                            .instance.currentUser?.uid) {
                                      _showAlertDialog(
                                          context: context,
                                          postID: ds["id"].toString(),
                                          text: ds["writeUp"].toString(),
                                          imagePost: ds["img"].toString(),
                                          images: ds["multiImage"]);
                                    } else {
                                      _showNAlertDialog(ds["id"].toString());
                                    }
                                  }
                                },
                                date: ds["time"],
                                like: ds["like"],
                                share: ds["share"],
                                comments: ds["comments"],
                                listImage: ds["multiImage"],
                              ),
                      );
                    },
                  );
                }
              },
            ),
          );
        });
  }

  void _showAlertDialog(
      {required BuildContext context,
      required String postID,
      required String text,
      required List images,
      required String imagePost}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(0))),
          // title:  Text(''),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Action",
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
              InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                    _showAAlertDialog(context: context, postIdD: postID);
                  },
                  child: const Text(
                    'Delete Post',
                    style: TextStyle(fontSize: 16),
                  )),
              const SizedBox(height: 10),
              StreamBuilder<DocumentSnapshot>(
                  stream: FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).snapshots(),
                builder: (context, snapshot) {
                  return InkWell(
                      onTap: () {
                        List friends = snapshot.data!["friends"];

                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => UpdateAddFeed(
                            postId: postID, postImage: imagePost, textOn: text,
                            pic: '', images: images, friends: friends,
                            //text: '',
                            //pic: '',
                          ),
                        ));
                      },
                      child: const Text(
                        'Edit Post',
                        style: TextStyle(fontSize: 16),
                      ));
                }
              ),
              const SizedBox(height: 10),
              InkWell(
                  onTap: () async {
                    final dynamicLinkParams = DynamicLinkParameters(
                      link: Uri.parse(
                          "https://www.wedme.com/marriageInvite?groupId="),
                      uriPrefix: "https://wedme.page.link",
                      androidParameters: AndroidParameters(
                        //TODO:: Change this link to the app play store link

                        fallbackUrl: Uri.parse("https://play.google.com"),
                        packageName: "com.briskita.wedme",
                        minimumVersion: 30,
                      ),
                      //TODO:: Update the iOS proper data
                      //Also change for Info.plist
                      //Follow this below link to setup ios properly
                      //https://firebase.flutter.dev/docs/dynamic-links/receive/
                      iosParameters: const IOSParameters(
                        bundleId: "com.example.app.ios",
                        appStoreId: "123456789",
                        minimumVersion: "1.0.1",
                      ),
                    );

                    Uri? buildLink = await FirebaseDynamicLinks.instance
                        .buildLink(dynamicLinkParams);
                    await Share.share(
                      '$buildLink',
                      subject: 'Download, WedMeApp to view this post',
                    );
                  },
                  child: const Text(
                    'Share Post',
                    style: TextStyle(fontSize: 16),
                  )),
              const SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }

  void _showNAlertDialog(String postId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(0))),
          // title:  Text(''),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Action",
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
              InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: ((context) => ReportProblemScreen(
                            postId: postId,
                          ))));
                },
                child: const Text(
                  'Report Post',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              const SizedBox(height: 10),
              InkWell(
                  onTap: () async {
                    await FirebaseFirestore.instance
                        .collection("DiscoverModel")
                        .doc(postId)
                        .update({
                      "users": FieldValue.arrayUnion(
                          [FirebaseAuth.instance.currentUser!.uid])
                    }).then((value) {
                      _showNAlertDialogHide();
                    });
                    setState(() {
                      _isItemHidden = !_isItemHidden;
                    });
                  },
                  child: const Text(
                    'Hide Post',
                    style: TextStyle(fontSize: 16),
                  )),
              const SizedBox(height: 10),
              InkWell(
                  onTap: () async {
                    final dynamicLinkParams = DynamicLinkParameters(
                      link: Uri.parse(
                          "https://www.wedme.com/marriageInvite?groupId="),
                      uriPrefix: "https://wedme.page.link",
                      androidParameters: AndroidParameters(
                        //TODO:: Change this link to the app play store link

                        fallbackUrl: Uri.parse("https://play.google.com"),
                        packageName: "com.briskita.wedme",
                        minimumVersion: 30,
                      ),
                      //TODO:: Update the iOS proper data
                      //Also change for Info.plist
                      //Follow this below link to setup ios properly
                      //https://firebase.flutter.dev/docs/dynamic-links/receive/
                      iosParameters: const IOSParameters(
                        bundleId: "com.example.app.ios",
                        appStoreId: "123456789",
                        minimumVersion: "1.0.1",
                      ),
                      // googleAnalyticsParameters: const GoogleAnalyticsParameters(
                      //   source: "twitter",
                      //   medium: "social",
                      //   campaign: "example-promo",
                      // ),
                      // socialMetaTagParameters: SocialMetaTagParameters(
                      //   title: "Example of a Dynamic Link",
                      //   imageUrl: Uri.parse("https://example.com/image.png"),
                      // ),
                    );

                    Uri? buildLink = await FirebaseDynamicLinks.instance
                        .buildLink(dynamicLinkParams);
                    await Share.share(
                      '$buildLink',
                      subject: 'Download, WedMeApp to view this post',
                    );
                  },
                  child: const Text(
                    'Share Post',
                    style: TextStyle(fontSize: 16),
                  )),
              const SizedBox(height: 10),
            ],
          ),
          // actions: <Widget>[
          //   TextButton(
          //     onPressed: () {
          //       Navigator.of(context).pop();
          //     },
          //     child: Text('OK'),
          //   ),
          // ],
        );
      },
    );
  }

  void _showNAlertDialogHide() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(0))),
          // title:  Text(''),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Action",
                    style: TextStyle(fontSize: 16),
                  ),
                  InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "X",
                        style: TextStyle(fontSize: 20),
                      )),
                ],
              ),
              const Divider(),
              const SizedBox(height: 10),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'Done!',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18, color: Color(0xFF01A024)),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'This post has been hidden \nfrom your discover feeds',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
              const SizedBox(height: 10),
            ],
          ),
          // actions: <Widget>[
          //   TextButton(
          //     onPressed: () {
          //       Navigator.of(context).pop();
          //     },
          //     child: Text('OK'),
          //   ),
          // ],
        );
      },
    );
  }

  void _showAAlertDialog(
      {required BuildContext context, required String postIdD}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(0))),
          // title:  Text(''),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Action",
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'Are you sure you want to \ndelete this post',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                        height: 50,
                        width: 84,
                        decoration: const BoxDecoration(
                            color: Color(0xFFF4F4F4),
                            borderRadius: BorderRadius.all(Radius.circular(4))),
                        child: const Center(
                            child: Text(
                          "Cancel",
                          style: TextStyle(fontSize: 20),
                        ))),
                  ),
                  const SizedBox(
                    width: 33,
                  ),
                  InkWell(
                    onTap: () async {
                      await FirebaseFirestore.instance
                          .collection("discoverModel")
                          .doc(postIdD)
                          .delete()
                          .then((value) {
                        Navigator.of(context).pop();
                      });
                    },
                    child: Container(
                        height: 50,
                        width: 84,
                        decoration: const BoxDecoration(
                            color: Color(0xFFFFEAEA),
                            borderRadius: BorderRadius.all(Radius.circular(4))),
                        child: const Center(
                            child: Text(
                          "Delete",
                          style: TextStyle(fontSize: 20, color: Colors.red),
                        ))),
                  ),
                ],
              ),
            ],
          ),
          // actions: <Widget>[
          //   TextButton(
          //     onPressed: () {
          //       Navigator.of(context).pop();
          //     },
          //     child: Text('OK'),
          //   ),
          // ],
        );
      },
    );
  }
}
