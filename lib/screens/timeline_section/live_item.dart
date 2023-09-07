import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";

import 'package:story_view/controller/story_controller.dart';
import 'package:story_view/widgets/story_view.dart';
import 'package:wedme1/models/live_model.dart';

import '../../Call/ZegCall/JoinLiveStream.dart';
import '../../getit.dart';
import '../../utils/base_view_builder.dart';
import '../../utils/constant_utils.dart';
import '../../viewModel/profile_vm.dart';
import 'classOfTimeline.dart';

class LiveItem extends StatelessWidget {
  const LiveItem({
    Key? key,
    this.liveModel,
  }) : super(key: key);
  final LiveModel? liveModel;
  final String profilePix = profileAvaterUrl;
  // String img;

  static Future<UserProfileT> userProfile() async {
    var snapshotD =
        await userCollection.withConverter(fromFirestore: (snapshot, options) {
      if (!snapshot.exists) return null;
      return UserProfileT.fromJson(snapshot.data()!);
    }, toFirestore: (ve, options) {
      return ve.noSuchMethod(Invocation.getter(Symbol.empty));
    }).get();
    return snapshotD.data()!;
  }

  @override
  Widget build(BuildContext context) {
    return BaseViewBuilder<ProfileViewModel>(
        model: getIt(),
        builder: (pVm, _) {
          return StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("liveStream")
                  .where('friends',
                      arrayContains: FirebaseAuth.instance.currentUser!.uid)
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
                  return ListView.builder(
                    itemCount: snapshot.data?.docs.length,
                    reverse: false,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      DocumentSnapshot ds = snapshot.data!.docs[index];
                      return Container(
                        padding: const EdgeInsets.only(
                            left: 5, right: 2, top: 6, bottom: 6),
                        child: InkWell(
                          onTap: () async {
                            print(ds["liveId"]);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => JoinLivePage(
                                    liveID: ds["liveId"],
                                    localUserID: pVm.cachedUserDetail!.displayName!,
                                  ),
                                ));
                          },
                          child: CircleAvatar(
                            backgroundColor: const Color(0xFF099FB3),
                            radius: 30,
                            child: CircleAvatar(
                                backgroundImage:
                                    NetworkImage(ds["liveProfile"].toString())),
                          ),
                        ),
                      );
                    },
                  );
                }
              });
        });
  }
}

class WhatsP extends StatelessWidget {
  WhatsP({
    Key? key,
    this.text = "",
    required this.bringUrl,
    this.color = Colors.yellow,
  }) : super(key: key);

  final String text;

  final Color color;
  final String bringUrl;
  final String imageUrl = "";

  final StoryController _controller = StoryController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: bringUrl == ""
          ? StoryView(
              onComplete: () {
                Navigator.pop(context);
              },
              storyItems: [StoryItem.text(title: text, backgroundColor: color)],
              controller: _controller)
          : StoryView(
              storyItems: [
                StoryItem.pageImage(
                    url: bringUrl, controller: StoryController())
              ],
              controller: _controller,
              repeat: false,
              onComplete: () {
                Navigator.pop(context);
              },
            ),
    );
  }
}
