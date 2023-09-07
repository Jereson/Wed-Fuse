import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' as foundation;

import '../../chat/groupChat/chatControl/ChatControl.dart';
import '../../constants/colors.dart';
import '../../getit.dart';
import '../../utils/base_view_builder.dart';
import '../../viewModel/profile_vm.dart';
import 'CommentPostColumeOne.dart';
import 'StreamForComment.dart';

class CommentPost extends StatefulWidget {
  const CommentPost({
    Key? key,
    required this.name,
    required this.time,
    required this.share,
    required this.comment,
    required this.profileImage,
    required this.listImage,
    required this.id,
    required this.postText,
    required this.likes,
  }) : super(key: key);
  final String name;
  final String time;
  final String share;
  final String profileImage;
  final String comment;
  final String postText;
  final String id;
  final String likes;
  final List listImage;

  @override
  State<CommentPost> createState() => _CommentPostState();
}

class _CommentPostState extends State<CommentPost> {
  final TextEditingController _sendMessageController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  bool emojiShowing = false;

  @override
  Widget build(BuildContext context) {
    return BaseViewBuilder<ProfileViewModel>(
        model: getIt(),
        builder: (pVm, _) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            centerTitle: true,
            elevation: 0,
            title: const Text(
              "Discover",
              style: TextStyle(
                  color: Colors.black, fontSize: 18, fontWeight: FontWeight.w700),
            ),
            backgroundColor: Colors.white,
          ),
          body: SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const Divider(),
                    Expanded(
                      child: CommentPostColumOne(
                        name: widget.name,
                        time: widget.time,
                        share: widget.share, comment: widget.comment, likes: widget.likes, postText: widget.postText, profileImage:widget.profileImage, listImage: widget.listImage,
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    const Divider(),
                    const SizedBox(
                      height: 24,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          widget.listImage.isEmpty?  Expanded(

                            child: SizedBox(
                              height: 200,
                              child: StreamForComment(id: widget.id, list: widget.listImage,),
                            ),
                          ): Expanded(

                            child: SizedBox(
                              height: 150,
                              child: StreamForComment(id: widget.id, list: widget.listImage,),
                            ),
                          ),
                          SizedBox(
                            height: 80,
                            child: BottomSheet(
                              onClosing: () {},
                              builder: (context) {
                                return Container(
                                  margin: EdgeInsets.only(
                                      bottom: emojiShowing == true ? 150 : 10),
                                  padding:
                                  const EdgeInsets.only(left: 10, bottom: 10, top: 10),
                                  height: 70,
                                  width: double.infinity,
                                  color: Colors.white,
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: kEditextColor,
                                            border: Border.all(
                                              color: kEditextColor,
                                              width: 1.0,
                                            ),
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(left: 16.0),
                                                child: writeMessageTextField(context),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 15,
                                      ),
                                      FloatingActionButton(
                                        onPressed: () {
                                          if(_sendMessageController.text.isNotEmpty){
                                            FirebaseFirestore.instance.collection("discoverModel").doc(widget.id).collection("comments").add(
                                                {
                                                  "comment":_sendMessageController.text.trim(),
                                                  "picture":pVm.cachedUserDetail!.photoUrl!,
                                                  "name":pVm.cachedUserDetail!.displayName!

                                                }).then((value) {
                                                  _sendMessageController.clear();
                                                  FirebaseFirestore.instance.collection("discoverModel").doc(widget.id).update({
                                                    "comments": FieldValue.increment(1),
                                                  });

                                            });
                                          }

                                        },
                                        backgroundColor: kPrimaryColor,
                                        elevation: 0,
                                        child: Image.asset("assets/images/img_15.png",height: 20,),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }
    );
  }

  TextField writeMessageTextField(BuildContext context) {
    return TextField(
      controller: _sendMessageController,
      decoration: const InputDecoration(
          // prefixIcon: InkWell(
          //   onTap: () {
          //     emojiShowing = !emojiShowing;
          //     setState(() {});
          //     _focusNode.unfocus(); // disable keyboard
          //
          //     if (!emojiShowing) {
          //       Navigator.pop(context);
          //     } else {
          //       emojiShowing == true
          //           ? showBottomSheet(
          //         enableDrag: false,
          //         constraints: const BoxConstraints(minHeight: 20),
          //         context: context,
          //         builder: (context) {
          //           return SizedBox(
          //               height: 150,
          //               child: EmojiPicker(
          //                 textEditingController: _sendMessageController,
          //                 config: Config(
          //                   verticalSpacing: 0,
          //                   horizontalSpacing: 0,
          //                   gridPadding: EdgeInsets.zero,
          //                   initCategory: Category.RECENT,
          //                   bgColor: const Color(0xFFF2F2F2),
          //                   indicatorColor: Colors.blue,
          //                   iconColor: Colors.grey,
          //                   iconColorSelected: Colors.blue,
          //                   backspaceColor: Colors.blue,
          //                   skinToneDialogBgColor: Colors.white,
          //                   skinToneIndicatorColor: Colors.grey,
          //                   enableSkinTones: true,
          //                   showRecentsTab: true,
          //                   recentsLimit: 28,
          //                   replaceEmojiOnLimitExceed: false,
          //                   noRecents: const Text(
          //                     'No Recent',
          //                     style: TextStyle(
          //                         fontSize: 20, color: Colors.black26),
          //                     textAlign: TextAlign.center,
          //                   ),
          //                   checkPlatformCompatibility: true,
          //                   loadingIndicator: const SizedBox.shrink(),
          //                   tabIndicatorAnimDuration: kTabScrollDuration,
          //                   categoryIcons: const CategoryIcons(),
          //                   buttonMode: ButtonMode.MATERIAL,
          //                   columns: 7,
          //                   emojiSizeMax: 32 * (foundation.defaultTargetPlatform ==
          //                           TargetPlatform.iOS
          //                           ? 1.30
          //                           : 1.0),
          //                 ),
          //               ));
          //         },
          //       ) : Container();
          //     }
          //   },
          //   child: const ImageIcon(AssetImage("assets/icons/emoji_face.png")),
          // ),
          // suffixIcon: InkWell(
          //   onTap: () async {
          //     emojiShowing = !emojiShowing;
          //     setState(() {});
          //     _focusNode.unfocus(); // disable keyboard
          //
          //     if (!emojiShowing) {
          //       Navigator.pop(context);
          //     } else {
          //       emojiShowing == true
          //           ? showBottomSheet(
          //         enableDrag: false,
          //         constraints: const BoxConstraints(minHeight: 20),
          //         context: context,
          //         builder: (context) {
          //           return SizedBox(
          //               height: 150,
          //               child: EmojiPicker(
          //                 textEditingController: _sendMessageController,
          //                 config: Config(
          //                   verticalSpacing: 0,
          //                   horizontalSpacing: 0,
          //                   gridPadding: EdgeInsets.zero,
          //                   initCategory: Category.RECENT,
          //                   bgColor: const Color(0xFFF2F2F2),
          //                   indicatorColor: Colors.blue,
          //                   iconColor: Colors.grey,
          //                   iconColorSelected: Colors.blue,
          //                   backspaceColor: Colors.blue,
          //                   skinToneDialogBgColor: Colors.white,
          //                   skinToneIndicatorColor: Colors.grey,
          //                   enableSkinTones: true,
          //                   showRecentsTab: true,
          //                   recentsLimit: 28,
          //                   replaceEmojiOnLimitExceed: false,
          //                   noRecents: const Text(
          //                     'No Recent',
          //                     style: TextStyle(
          //                         fontSize: 20, color: Colors.black26),
          //                     textAlign: TextAlign.center,
          //                   ),
          //                   checkPlatformCompatibility: true,
          //                   loadingIndicator: const SizedBox.shrink(),
          //                   tabIndicatorAnimDuration: kTabScrollDuration,
          //                   categoryIcons: const CategoryIcons(),
          //                   buttonMode: ButtonMode.MATERIAL,
          //                   columns: 7,
          //                   emojiSizeMax: 32 *
          //                       (foundation.defaultTargetPlatform ==
          //                           TargetPlatform.iOS
          //                           ? 1.30
          //                           : 1.0),
          //                 ),
          //               ));
          //         },
          //       )
          //           : Container();
          //     }
          //   },
          //   child:  Container(),
          // ),
          hintText: "Write message...",
          hintStyle: TextStyle(color: Color(0xFF360001)),
          border: InputBorder.none),
    );
  }
}

