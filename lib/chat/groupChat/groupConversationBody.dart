import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:path_provider/path_provider.dart';
import '../../chat/groupChat/chatControl/ChatControl.dart';
import '../../utils/flushbar_widget.dart';
import '/constants/colors.dart';
import 'package:ndialog/ndialog.dart';
import 'dart:io';
import 'package:record/record.dart';
import '/models/chat_model.dart';

class GroupConversationBody extends StatefulWidget {
  const GroupConversationBody({
    Key? key,
    required this.chatRoomId,
    required this.idj,
    required this.fullName,
    required this.count,
    required this.photoUrl,
    required this.userId,
    required this.state,
    required this.currentUserID,
    required this.currentFullName,
    required this.currentPhotoUrl,
    required this.docID,
  }) : super(key: key);
  final String chatRoomId;
  final String idj;
  final String photoUrl;
  final String fullName;
  final int count;
  final String state;
  final String userId;
  final String currentUserID;
  final String currentFullName;
  final String currentPhotoUrl;
  final String docID;

  @override
  State<GroupConversationBody> createState() => _GroupConversationBodyState();
}

class _GroupConversationBodyState extends State<GroupConversationBody> {
  final messages = ChatModel.messages;
  final record = Record();
  String? filePathLight;

  String docID = "";
  final audioPlayer = AudioPlayer();
  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;
  bool startRecordingNow=false;
  Future<void> stopRecording() async {
    await record.stop();
  }

  Future<void> startRecording() async {
    if (await record.hasPermission()) {
      Directory directory;

      if (Platform.isIOS) {
        directory = await getTemporaryDirectory();
      } else {
        directory = (await getExternalStorageDirectory())!;
      }
      String filePath =
          '${directory.path}/${DateTime.now().millisecondsSinceEpoch}.acc';

      await record.start(
        path: filePath,
        encoder: AudioEncoder.AAC, // by default
        bitRate: 128000, // by default
        samplingRate: 44100, // by default
      );

      bool isRecording = await record.isRecording();

      setState(() {
        filePathLight = filePath;
      });
    } else {
      if (context.mounted) {
        flushbar(
            context: context,
            title: 'Permission Required',
            message: 'Please enable recording permision',
            isSuccess: false);
      }
    }
  }

  Future<void> upload() async {
    final ref = FirebaseStorage.instance
        .ref()
        .child('audio-path/${DateTime.now().microsecondsSinceEpoch}');
    UploadTask uploadTask = ref.putFile(File(filePathLight!));
    uploadTask.showCustomProgressDialog(context);
    final down = await uploadTask.whenComplete(() {});

    final downloadedFile = await down.ref.getDownloadURL();
    await FirebaseFirestore.instance
        .collection("groupChat")
        .doc(widget.chatRoomId)
        .collection("chatR")
        .add({
      "message": "",
      'timestamp': FieldValue.serverTimestamp(),
      "image": "",
      "imageSent": "https://firebasestorage.googleapis.com/v0/b/wedme-373214.appspot.com/o/images%2Fmyimage.jpg1684366500670296?alt=media&token=f8f1e6ad-2366-451c-bc99-43e089c35a28",
      "isAudio":true,
      "audio": downloadedFile,
      "order":DateTime.now().millisecondsSinceEpoch,
      "currentUser": FirebaseAuth.instance.currentUser?.uid,

    });

    print('The downloaded file $downloadedFile');
  }

  String? urlAudio;
  _GroupConversationBodyState();
  final TextEditingController _sendMessageController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _sendMessageController.dispose();
    audioPlayer.dispose();

  }

  PlatformFile? selectedAudio;
  PlatformFile? selectPicture;
  UploadTask? uploadTask;
  bool emojiShowing = false;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    audioPlayer.onPlayerStateChanged.listen((event) {
      setState(() {
        isPlaying = event == PlayerState.playing;
      });

      audioPlayer.onDurationChanged.listen((event) {
        setState(() {
          duration = event;
        });
      });
      audioPlayer.onPositionChanged.listen((event) {
        position = event;
      });
    });
  }

  String pathToAudio = "";

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        FirebaseFirestore.instance.collection("groupChat").doc(widget.chatRoomId).update({
          "count":0
        });
        FirebaseFirestore.instance
            .collection("messageList")
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection("individual")
            .doc(widget.idj)
            .update({"count": 0});
        if (emojiShowing == true) {
          return false;
        }
        return true;
      },
      child: Column(
        children: <Widget>[
          Expanded(

            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("groupChat")
                    .doc(widget.chatRoomId)
                    .collection("chatR")
                    .orderBy('timestamp', descending: false)
                    .snapshots(),
                builder: (_,
                    AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                  if (!snapshot.hasData) {
                    return const Text("");
                  } else {
                    return ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: snapshot.data?.docs.length,
                      shrinkWrap: true,
                      reverse: false,
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      itemBuilder: (context, index) {
                        final message = snapshot.data!.docs[index]
                        ['currentUser'] !=
                            FirebaseAuth.instance.currentUser?.uid;
                        snapshot.data!.docs[index]['message'] !=
                            FirebaseAuth.instance.currentUser?.uid;
                        return Column(
                          children: [
                            Align(
                              alignment: (message
                                  ? Alignment.topLeft
                                  : Alignment.topRight),
                              child: Container(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                child: snapshot.data!.docs[index]["message"] == ""
                                    ? Container()
                                    : Container(
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(50),
                                      topRight: Radius.circular(0),
                                      bottomLeft: Radius.circular(50),
                                      bottomRight: Radius.circular(40),
                                    ),
                                    color: (message
                                        ? Colors.grey.shade200
                                        : Colors.black),
                                  ),
                                  padding: const EdgeInsets.all(16),
                                  child: Text(
                                    snapshot.data!.docs[index]["message"],
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: message
                                          ? Colors.black
                                          : Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Align(
                              alignment: (message
                                  ? Alignment.topLeft
                                  : Alignment.topRight),
                              child: Container(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                child: snapshot.data!.docs[index]["imageSent"] ==
                                    ""
                                    ? Container()
                                    : snapshot.data!.docs[index]["isAudio"]==true?
                                Container(
                                  width: 200,
                                  child: Row(
                                    children: [
                                      IconButton(onPressed: () async {
                                        if (isPlaying) {
                                          await audioPlayer.pause();
                                        } else {
                                          await audioPlayer.play(UrlSource(
                                              snapshot.data!.docs[index]
                                              ["audio"]));
                                        }

                                      }, icon:  isPlaying == false
                                          ? const Icon(
                                        Icons.play_circle,
                                      )
                                          : const Icon(
                                        Icons.pause,
                                      ),),
                                      Container(
                                        height: 12,
                                        width: 120,
                                        decoration: const BoxDecoration(
                                            color: Colors.grey
                                        ),

                                      )

                                    ],
                                  ),
                                ):
                                Container(
                                  height:
                                  MediaQuery.of(context).size.height *
                                      0.2,
                                  width: MediaQuery.of(context).size.width *
                                      0.5,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: NetworkImage(snapshot.data!
                                            .docs[index]["imageSent"]),
                                        fit: BoxFit.cover),
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(50),
                                      topRight: Radius.circular(0),
                                      bottomLeft: Radius.circular(50),
                                      bottomRight: Radius.circular(40),
                                    ),
                                  ),
                                  padding: const EdgeInsets.all(16),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  }
                }),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              margin: EdgeInsets.only(bottom: emojiShowing == true ? 150 : 10),
              padding: const EdgeInsets.only(left: 10, bottom: 10, top: 10),
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
                          writeMessageTextField(context),
                        ],
                      ),
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        ChatControl().captureImageG(
                            context: context, chatRoomId: widget.chatRoomId);
                      },
                      icon: const Icon(Icons.image)),
                  const SizedBox(
                    width: 15,
                  ),
                  FloatingActionButton(
                    onPressed: () {
                      ChatControl().uploadToFirebaseG(
                          chatRoomId: widget.chatRoomId,
                          selectedAudio: selectedAudio,
                          selectPicture: selectPicture,
                          sendMessageController: _sendMessageController,
                          userId: widget.userId,
                          uploadTask: uploadTask,);
                    },
                    backgroundColor: kPrimaryColor,
                    elevation: 0,
                    child: const Icon(
                      Icons.send,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  TextField writeMessageTextField(BuildContext context) {
    return TextField(
      controller: _sendMessageController,
      decoration: InputDecoration(
          prefixIcon: InkWell(
            onTap: () {
              emojiShowing = !emojiShowing;
              setState(() {});
              _focusNode.unfocus(); // disable keyboard

              if (!emojiShowing) {
                Navigator.pop(context);
              } else {
                emojiShowing == true
                    ? showBottomSheet(
                  enableDrag: false,
                  constraints: const BoxConstraints(minHeight: 20),
                  context: context,
                  builder: (context) {
                    return SizedBox(
                        height: 150,
                        child: EmojiPicker(
                          textEditingController: _sendMessageController,
                          config: Config(
                            verticalSpacing: 0,
                            horizontalSpacing: 0,
                            gridPadding: EdgeInsets.zero,
                            initCategory: Category.RECENT,
                            bgColor: const Color(0xFFF2F2F2),
                            indicatorColor: Colors.blue,
                            iconColor: Colors.grey,
                            iconColorSelected: Colors.blue,
                            backspaceColor: Colors.blue,
                            skinToneDialogBgColor: Colors.white,
                            skinToneIndicatorColor: Colors.grey,
                            enableSkinTones: true,
                            showRecentsTab: true,
                            recentsLimit: 28,
                            replaceEmojiOnLimitExceed: false,
                            noRecents: const Text(
                              'No Recent',
                              style: TextStyle(
                                  fontSize: 20, color: Colors.black26),
                              textAlign: TextAlign.center,
                            ),
                            checkPlatformCompatibility: true,
                            loadingIndicator: const SizedBox.shrink(),
                            tabIndicatorAnimDuration: kTabScrollDuration,
                            categoryIcons: const CategoryIcons(),
                            buttonMode: ButtonMode.MATERIAL,
                            columns: 7,
                            emojiSizeMax: 32 *
                                (foundation.defaultTargetPlatform ==
                                    TargetPlatform.iOS
                                    ? 1.30
                                    : 1.0),
                          ),
                        ));
                  },
                )
                    : Container();
              }
            },
            child: const ImageIcon(AssetImage("assets/icons/emoji_face.png")),
          ),
          suffixIcon: InkWell(
            onTap: () async {

              startRecordingNow = !startRecordingNow;
              print(startRecordingNow);
              setState(() {

              });
              if(startRecordingNow){

                await startRecording();
              }else{
                upload();
              }

            },
            child:startRecordingNow ? Icon( Icons.pause):Icon(Icons.mic),
          ),
          hintText: "Write message...",
          hintStyle: const TextStyle(color: Color(0xFF360001)),
          border: InputBorder.none),
    );
  }
}
