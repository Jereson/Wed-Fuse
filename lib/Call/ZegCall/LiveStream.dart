
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
//
import 'package:zego_uikit_prebuilt_live_streaming/zego_uikit_prebuilt_live_streaming.dart';
import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';

// Package imports:

class LivePage extends StatelessWidget {
  final String liveID;
  final String localUserID;
  final String cachedUserDetail;
  final List friends;

  const LivePage({
    Key? key,
    required this.liveID,
    required this.localUserID,
    required this.cachedUserDetail,
    required this.friends,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ZegoUIKitPrebuiltLiveStreaming(
          appID: 1437302100,
          appSign:
              "fc06680ec176143f9e657d1c3de8506cdd785c1e0086a17c6293821b2946e977",
          userID: FirebaseAuth.instance.currentUser!.uid,
          userName: localUserID,
          liveID: FirebaseAuth.instance.currentUser!.uid,
          config: true
              ? (ZegoUIKitPrebuiltLiveStreamingConfig.host(
                  plugins: [ZegoUIKitSignalingPlugin()],
                )
                ..turnOnMicrophoneWhenJoining = true
                ..confirmDialogInfo = true
                    ? ZegoDialogInfo(
                        title: "Stop the live",
                        message: "Are you sure to stop the live?",
                        cancelButtonName: "Cancel",
                        confirmButtonName: "Stop it",
                      )
                    : null
                ..onLeaveConfirmation = (BuildContext context) async {
                  // show a dialog to confirm leaving the live stream
                  bool confirmed = await showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                              backgroundColor: Colors.white.withOpacity(0.9),
                              title: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  IconButton(
                                      onPressed: () =>
                                          Navigator.of(context).pop(false),
                                      icon: Container(
                                        height: 10,
                                        width: 10,
                                        decoration: const BoxDecoration(
                                            image: DecorationImage(
                                                image: AssetImage(
                                                    "assets/images/img_14.png"),
                                                fit: BoxFit.cover)),
                                      )),
                                ],
                              ),
                              content: const Text(
                                  "Are you sure you want to end \nyour live?",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.black)),
                              actionsAlignment: MainAxisAlignment.center,
                              actions: [
                                InkWell(
                                  onTap: () {
                                    Navigator.of(context).pop(true);
                                    FirebaseFirestore.instance
                                        .collection("liveStream")
                                        .doc(FirebaseAuth
                                            .instance.currentUser!.uid)
                                        .delete();
                                  },
                                  child: Container(
                                      width: 154,
                                      height: 40,
                                      decoration: const BoxDecoration(
                                          color: Color(0xFFE50707),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(7))),
                                      child: const Center(
                                          child: Text(
                                        "End",
                                        style: TextStyle(color: Colors.white),
                                      ))),
                                ),
                              ]));

                  // return whether the user confirmed leaving the live stream
                  return confirmed;
                }
                ..startLiveButtonBuilder = (context, startLive) {
                  return InkWell(
                    onTap: () {
                      FirebaseFirestore.instance
                          .collection("liveStream")
                          .doc(FirebaseAuth.instance.currentUser!.uid)
                          .set({
                        "friends": friends,
                        "liveId": FirebaseAuth.instance.currentUser!.uid,
                        "liveProfile": cachedUserDetail
                      }).then((value) {});
                      startLive();
                    },
                    child: Container(
                        width: 107,
                        height: 48,
                        decoration: const BoxDecoration(
                            color: Color(0xFFE50707),
                            borderRadius: BorderRadius.all(Radius.circular(7))),
                        child: const Center(
                            child: Text(
                          "Go Live",
                          style: TextStyle(color: Colors.white),
                        ))),
                  );
                })
              : ZegoUIKitPrebuiltLiveStreamingConfig.audience(
                  plugins: [ZegoUIKitSignalingPlugin()],
                )
            ..audioVideoViewConfig.useVideoViewAspectFill = true
            ..onCameraTurnOnByOthersConfirmation = (BuildContext context) {
              return onTurnOnAudienceDeviceConfirmation(
                context,
                isCameraOrMicrophone: true,
              );
            }
            ..onMicrophoneTurnOnByOthersConfirmation = (BuildContext context) {
              return onTurnOnAudienceDeviceConfirmation(
                context,
                isCameraOrMicrophone: false,
              );
            }),
    );
  }

  Image prebuiltImage(String name) {
    return Image.asset(name, package: 'zego_uikit_prebuilt_live_streaming');
  }

  Widget hostAudioVideoViewForegroundBuilder(
    BuildContext context,
    Size size,
    ZegoUIKitUser? user,
    Map<String, dynamic> extraInfo,
  ) {
    if (user == null || user.id == localUserID) {
      return Container();
    }

    const toolbarCameraNormal = 'assets/icons/toolbar_camera_normal.png';
    const toolbarCameraOff = 'assets/icons/toolbar_camera_off.png';
    const toolbarMicNormal = 'assets/icons/toolbar_mic_normal.png';
    const toolbarMicOff = 'assets/icons/toolbar_mic_off.png';
    return Positioned(
      top: 15,
      right: 0,
      child: Row(
        children: [
          ValueListenableBuilder<bool>(
            valueListenable: ZegoUIKit().getCameraStateNotifier(user.id),
            builder: (context, isCameraEnabled, _) {
              return GestureDetector(
                onTap: () {
                  ZegoUIKit().turnCameraOn(!isCameraEnabled, userID: user.id);
                },
                child: SizedBox(
                  width: size.width * 0.4,
                  height: size.width * 0.4,
                  child: prebuiltImage(
                    isCameraEnabled ? toolbarCameraNormal : toolbarCameraOff,
                  ),
                ),
              );
            },
          ),
          SizedBox(width: size.width * 0.1),
          ValueListenableBuilder<bool>(
            valueListenable: ZegoUIKit().getMicrophoneStateNotifier(user.id),
            builder: (context, isMicrophoneEnabled, _) {
              return GestureDetector(
                onTap: () {
                  ZegoUIKit()
                      .turnMicrophoneOn(!isMicrophoneEnabled, userID: user.id);
                },
                child: SizedBox(
                  width: size.width * 0.4,
                  height: size.width * 0.4,
                  child: prebuiltImage(
                    isMicrophoneEnabled ? toolbarMicNormal : toolbarMicOff,
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }

  Future<bool> onTurnOnAudienceDeviceConfirmation(
    BuildContext context, {
    required bool isCameraOrMicrophone,
  }) async {
    const textStyle = TextStyle(
      fontSize: 10,
      color: Colors.white70,
    );
    return await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.blue[900]!.withOpacity(0.9),
          title: Text(
              "You have a request to turn on your ${isCameraOrMicrophone ? "camera" : "microphone"}",
              style: textStyle),
          content: Text(
              "Do you agree to turn on the ${isCameraOrMicrophone ? "camera" : "microphone"}?",
              style: textStyle),
          actions: [
            ElevatedButton(
              child: const Text('Cancel', style: textStyle),
              onPressed: () => Navigator.of(context).pop(false),
            ),
            ElevatedButton(
              child: const Text('OK', style: textStyle),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    );
  }
}
