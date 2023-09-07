
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

// Project imports:
class PrebuiltCallPage extends StatefulWidget {
  const PrebuiltCallPage({Key? key, required  this.username, required this.chatId, required this.callId}) : super(key: key);
  final String username;
  final String chatId;
  final String callId;

  @override
  State<StatefulWidget> createState() => PrebuiltCallPageState();
}

class PrebuiltCallPageState extends State<PrebuiltCallPage> {
  @override
  Widget build(BuildContext context) {


    return SafeArea(
      child: ZegoUIKitPrebuiltCall(
        appID: 954211943 /*input your AppID*/,
        appSign: "fc06680ec176143f9e657d1c3de8506cdd785c1e0086a17c6293821b2946e977" /*input your AppSign*/,
        userID: FirebaseAuth.instance.currentUser!.uid,
        userName: widget.username,
        callID: widget.callId,
        config: ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall()

        /// support minimizing
          ..topMenuBarConfig.isVisible = true
          ..topMenuBarConfig.buttons = [
            ZegoMenuBarButtonName.minimizingButton,
            ZegoMenuBarButtonName.showMemberListButton,
          ]

        ///
          ..onOnlySelfInRoom = (context) {
            if (PrebuiltCallMiniOverlayPageState.idle !=
                ZegoUIKitPrebuiltCallMiniOverlayMachine().state()) {
              ZegoUIKitPrebuiltCallMiniOverlayMachine()
                  .changeState(PrebuiltCallMiniOverlayPageState.idle);
            } else {
              Navigator.of(context).pop();
            }
          },
      ),
    );
  }
}