import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_time_format/date_time_format.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;

import '../../../getit.dart';
import '../../../utils/base_view_builder.dart';
import '../../../viewModel/profile_vm.dart';
import '../roomChatLikeHome.dart';

class ChatControl {
  processOne(
      {required String f, required PageController pageViewController}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('selectedCountry', f);
    if (f.isEmpty) {
    } else if (f.isNotEmpty) {
      pageViewController.nextPage(
          duration: const Duration(milliseconds: 00001),
          curve: Curves.bounceIn);
    }
  }

  processTwo(
      {required String f,
      required BuildContext context,
      required String w}) async {
    if (f.isEmpty) {
    } else if (f.isNotEmpty) {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => RoomChatLikeHome(
          country: w, state: '',
        ),
      ));
    }
  }

  captureImage({required BuildContext context, required String chatRoomId,required String id}) async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (image == null) {
        return; // User has cancelled the camera or went back without capturing an image
      }
      //TODO:LIST
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DisplayImageScreenChatG(
            imagePath: image.path,
            idUrli: chatRoomId, id: id,
          ),
        ),
      );
    } catch (e) {
      // _showCameraError(e);
    }
  }
  captureImageDiscovery({required BuildContext context, required String chatRoomId,required String id}) async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);

      if (image == null) {
        return; // User has cancelled the camera or went back without capturing an image
      }
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DisplayImageScreenChatGD(
            imagePath: image.path,
            idUrli: chatRoomId, id: id,
          ),
        ),
      );
    } catch (e) {
      // _showCameraError(e);
    }
  }


  captureImageG({required BuildContext context, required String chatRoomId}) async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (image == null) {
        return; // User has cancelled the camera or went back without capturing an image
      }
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DisplayImageScreenChatGForGroup(
            imagePath: image.path,
            idUrli: chatRoomId, id: chatRoomId,
          ),
        ),
      );
    } catch (e) {
      // _showCameraError(e);
    }
  }

  Future<void> uploadToFirebaseN({required String userId,
      required String photoUrl,
      required String chatRoomId,
      required String idj,
      required PlatformFile? selectPicture,
      required PlatformFile? selectedAudio,
      required UploadTask? uploadTask,
      required String currentFullName,
      required TextEditingController sendMessageController,
      required String currentPhotoUrl,
      required String state,
      required String fullName}) async {

    var userIDNew = FirebaseAuth.instance.currentUser!.uid;
    var now = DateTime.now();
    var formatter = DateFormat('H:mm');
    int addOne = 1;
    var formattedTime = formatter.format(now).toString();
    final individualCollection = FirebaseFirestore.instance
        .collection("messageList")
        .doc(userIDNew)
        .collection("individual");
    final firstIndividualCollection = FirebaseFirestore.instance
        .collection("messageList")
        .doc(userId)
        .collection("individual");

    var docIc = DateTime.now().millisecondsSinceEpoch.toString();
    firstIndividualCollection.get().then((value) {
      if (value.docs.isEmpty) {
        individualCollection.doc(userId).set({
          "photoUrl": photoUrl,
          "fullName": fullName,
          "state": state,
          "userId": userId,
          "order":now.millisecondsSinceEpoch,
          "callId":userId+userIDNew,
          "latestChat": "",
          "count": 1,
          "time":formattedTime,
          "docId": docIc,
          "block":false,
        }).then((value) {
          firstIndividualCollection.doc(userIDNew).set({
            "photoUrl": currentPhotoUrl,
            "fullName": currentFullName,
            "state": state,
            "block":false,
            "order":now.millisecondsSinceEpoch,
            "count": 1,
            "callId":userId+userIDNew,
            "time":formattedTime,
            "userId": userIDNew,
            "latestChat":sendMessageController.text.trim(),
            "docId": docIc
          });
        });
      } else {}
    });
    individualCollection.get().then((value) {
      if (value.docs.isEmpty) {
        individualCollection.doc(userId).set({
          "photoUrl": photoUrl,
          "fullName": fullName,
          "state": state,
          "userId": userId,
          "order":now.millisecondsSinceEpoch,
          "latestChat": "",
          "callId":userId+userIDNew,
          "count": 1,
          "time":formattedTime,
          "docId": docIc,
          "block":false,
        });
        firstIndividualCollection.doc(userIDNew).set({
          "photoUrl": photoUrl,
          "fullName": fullName,
          "state": state,
          "userId": userIDNew,
          "callId":userId+userIDNew,
          "order":now.millisecondsSinceEpoch,
          "latestChat": "",
          "count": 1,
          "time":formattedTime,
          "docId": docIc,
          "block":false,
        });
      } else {}
    });


    if (selectPicture == null && selectedAudio == null&&sendMessageController.text.isNotEmpty) {
      await FirebaseFirestore.instance
          .collection("chat")
          .doc(chatRoomId)
          .collection("chatR")
          .add({
        "message": sendMessageController.text.trim(),
        'timestamp': FieldValue.serverTimestamp(),
        "image": "",
        "imageSent": "",
        "isAudio":false,
        "audio": "",
        "order":now.millisecondsSinceEpoch,
        "currentUser": FirebaseAuth.instance.currentUser?.uid,

      }).then((value) {
        FirebaseFirestore.instance.collection("iHaveMessage").doc(userId).update({
          "iHaveMessage": 1,
        });
        FirebaseFirestore.instance.collection("haveMessage").doc(userId).update({
          "count": FieldValue.increment(addOne),
        });

        firstIndividualCollection.doc(userId).update({
          "latestChat":sendMessageController.text.trim(),
          "time":formattedTime,
          "count": FieldValue.increment(addOne),
          "order":now.millisecondsSinceEpoch
        });
        individualCollection.doc(userId).update({
          "latestChat":sendMessageController.text.trim(),
          "time":formattedTime,
          "count": FieldValue.increment(addOne),
          "order":now.millisecondsSinceEpoch
        });
      });
      sendMessageController.clear();
    } else {
      final path = "file/audio/${selectedAudio!.name}";
      final pathImage = "file/audio/${selectPicture!.name}";
      final file = File(selectedAudio.path!);
      final fileImage = File(selectPicture.path!);

      final ref = FirebaseStorage.instance.ref().child(path);
      FirebaseStorage.instance.ref().child(pathImage);
      uploadTask = ref.putFile(file);
      uploadTask = ref.putFile(fileImage);
      try {
        final snapshot = await uploadTask.whenComplete(() {});
        final snapshotImage = await uploadTask.whenComplete(() {});
        final urlDownloadImage = await snapshotImage.ref.getDownloadURL();

        await snapshot.ref.getDownloadURL().then((value) async {
          await FirebaseFirestore.instance
              .collection("chat")
              .doc(chatRoomId)
              .collection("chatR")
              .add({
            "message": sendMessageController.text.trim(),
            'timestamp': FieldValue.serverTimestamp(),
            "image": urlDownloadImage.toString().trim(),
            "audio": value.toString().trim(),
            "currentUser": FirebaseAuth.instance.currentUser?.uid
          });
        });
      } catch (e) {}
    }
  }

  Future<void> uploadToFirebaseG({required String userId,
    required String chatRoomId,
    required PlatformFile? selectPicture,
    required PlatformFile? selectedAudio,
    required UploadTask? uploadTask,
    required TextEditingController sendMessageController,
   }) async {

    var now = DateTime.now();
    var formatter = DateFormat('H:mm');
    int addOne = 1;
    var formattedTime = formatter.format(now).toString();

    if (selectPicture == null && selectedAudio == null&&sendMessageController.text.isNotEmpty) {
      await FirebaseFirestore.instance
          .collection("groupChat")
          .doc(chatRoomId)
          .collection("chatR")
          .add({
        "message": sendMessageController.text.trim(),
        'timestamp': FieldValue.serverTimestamp(),
        "image": "",
        "imageSent": "",
        "audio": "",
        "isAudio":false,
        "currentUser": FirebaseAuth.instance.currentUser?.uid
      }).then((value) {
        FirebaseFirestore.instance.collection("groupChat").doc(chatRoomId).update(
            {
              "lastChat":sendMessageController.text.trim(),
              "time":formattedTime,
              "count": FieldValue.increment(addOne),


            });
      });
      sendMessageController.clear();
    } else {
      final path = "file/audio/${selectedAudio!.name}";
      final pathImage = "file/audio/${selectPicture!.name}";
      final file = File(selectedAudio.path!);
      final fileImage = File(selectPicture.path!);

      final ref = FirebaseStorage.instance.ref().child(path);
      FirebaseStorage.instance.ref().child(pathImage);
      uploadTask = ref.putFile(file);
      uploadTask = ref.putFile(fileImage);
      try {
        final snapshot = await uploadTask.whenComplete(() {});
        final snapshotImage = await uploadTask.whenComplete(() {});
        final urlDownloadImage = await snapshotImage.ref.getDownloadURL();

        await snapshot.ref.getDownloadURL().then((value) async {
          await FirebaseFirestore.instance
              .collection("groupChat")
              .doc(chatRoomId)
              .collection("chatR")
              .add({
            "message": sendMessageController.text.trim(),
            'timestamp': FieldValue.serverTimestamp(),
            "imageSent": urlDownloadImage.toString().trim(),
            "image": "",
            "audio": value.toString().trim(),
            "currentUser": FirebaseAuth.instance.currentUser?.uid
          });
        });
      } catch (e) {}
    }
  }
}

class DisplayImageScreenChatGForGroup extends StatefulWidget {
  DisplayImageScreenChatGForGroup({Key? key, required this.imagePath, required this.id,required this.idUrli}) : super(key: key);
  final String imagePath;
  final String id;
  String idUrli;

  @override
  _DisplayImageScreenChatGForGroupState createState() => _DisplayImageScreenChatGForGroupState(idUrl: idUrli);
}

class _DisplayImageScreenChatGForGroupState extends State<DisplayImageScreenChatGForGroup> {
  _DisplayImageScreenChatGForGroupState({required this.idUrl});
  UploadTask? _uploadTask;
  String? _downloadUrl;
  //String profilePix = profileAvaterUrl;
  bool _loading = false;
  bool Pload = false;
  String idUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Stack(
        alignment: Alignment.center,
        children: [
          FloatingActionButton(
            onPressed: (){
              _uploadImage(id: widget.id);
            },
            child: Pload == true
                ? const CircularProgressIndicator(
              backgroundColor: Colors.white,
            )
                : const Icon(Icons.send),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: FileImage(File(widget.imagePath)),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  void _uploadImage({required String id}) async {
    Pload == false ? Pload = true : Pload = false;
    setState(() {
      Pload = true;
    });

    try {
      final image = img.decodeImage(File(widget.imagePath).readAsBytesSync());
      final compressedImage = img.encodeJpg(image!, quality: 5);
      setState(() {
        Pload == true;
      });
      _uploadTask = FirebaseStorage.instance
          .ref()
          .child('images/myimage.jpg${DateTime.now().microsecondsSinceEpoch}')
          .putFile(File(widget.imagePath));
      var now = DateTime.now();
      final snapshot = await _uploadTask?.whenComplete(() {});
      final urlDownload = await snapshot?.ref.getDownloadURL().then((value) async {
        await FirebaseFirestore.instance
            .collection("groupChat")
            .doc(id)
            .collection("chatR")
            .add({
          "message": "",
          'timestamp': FieldValue.serverTimestamp(),
          "image": "",
          "imageSent": value.toString(),
          "audio": "",
          "isAudio":false,
          "currentUser": FirebaseAuth.instance.currentUser?.uid

        }).then((value) {
          Navigator.of(context).pop();
        });


        setState(() {
          Pload = false;
        });
      });

      setState(() {
        _downloadUrl = urlDownload;
      });
    } catch (e) {
      setState(() {
        Pload = false;
      });
      print(e);
    }
  }
}




class DisplayImageScreenChatG extends StatefulWidget {
  DisplayImageScreenChatG({Key? key, required this.imagePath, required this.id,required this.idUrli}) : super(key: key);
  final String imagePath;
  final String id;
  String idUrli;

  @override
  _DisplayImageScreenChatGState createState() => _DisplayImageScreenChatGState(idUrl: idUrli);
}

class _DisplayImageScreenChatGState extends State<DisplayImageScreenChatG> {
  _DisplayImageScreenChatGState({required this.idUrl});
  UploadTask? _uploadTask;
  String? _downloadUrl;
  //String profilePix = profileAvaterUrl;
  bool _loading = false;
  bool Pload = false;
  String idUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Stack(
        alignment: Alignment.center,
        children: [
          FloatingActionButton(
            onPressed: (){
              _uploadImage(id: widget.id);
            },
            child: Pload == true
                ? const CircularProgressIndicator(
              backgroundColor: Colors.white,
            )
                : const Icon(Icons.send),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: FileImage(File(widget.imagePath)),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  void _uploadImage({required String id}) async {
    Pload == false ? Pload = true : Pload = false;
    setState(() {
      Pload = true;
    });

    try {
      final image = img.decodeImage(File(widget.imagePath).readAsBytesSync());
      final compressedImage = img.encodeJpg(image!, quality: 5);
      setState(() {
        Pload == true;
      });
      _uploadTask = FirebaseStorage.instance
          .ref()
          .child('images/myimage.jpg${DateTime.now().microsecondsSinceEpoch}')
          .putFile(File(widget.imagePath));
      var now = DateTime.now();
      final snapshot = await _uploadTask?.whenComplete(() {});
      final urlDownload = await snapshot?.ref.getDownloadURL().then((value) async {
        await FirebaseFirestore.instance
            .collection("chat")
            .doc(id)
            .collection("chatR")
            .add({
          "message": "",
          'timestamp': FieldValue.serverTimestamp(),
          "image": "",
          "imageSent": value.toString(),
          "isAudio":false,
          "audio": "",
          "order":now.millisecondsSinceEpoch,
          "currentUser": FirebaseAuth.instance.currentUser?.uid,

        }).then((value) {
          Navigator.of(context).pop();
        });


        setState(() {
          Pload = false;
        });
      });

      setState(() {
        _downloadUrl = urlDownload;
      });
    } catch (e) {
      setState(() {
        Pload = false;
      });
      print(e);
    }
  }
}



class DisplayImageScreenChatGD extends StatefulWidget {
  DisplayImageScreenChatGD({Key? key, required this.imagePath, required this.id,required this.idUrli}) : super(key: key);
  final String imagePath;
  final String id;
  String idUrli;

  @override
  _DisplayImageScreenChatGStateD createState() => _DisplayImageScreenChatGStateD(idUrl: idUrli);

}
class _DisplayImageScreenChatGStateD extends State<DisplayImageScreenChatGD> {
  _DisplayImageScreenChatGStateD({required this.idUrl});
  UploadTask? _uploadTask;
  String? _downloadUrl;
  //String profilePix = profileAvaterUrl;
  bool _loading = false;
  bool Pload = false;
  String idUrl;

  @override
  Widget build(BuildContext context) {
    return BaseViewBuilder<ProfileViewModel>(
        model: getIt(),
        builder: (pVm, _) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            actions:  [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text("Add photo",style: TextStyle(color: Colors.black),),
                ],
              ),
              const SizedBox(width: 10,)
            ],
            leading: IconButton(onPressed: () {
              Navigator.pop(context);
            }, icon: Image.asset("assets/images/img_16.png",height: 12,)),
          ),

          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height*0.7,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      image: DecorationImage(
                        image: FileImage(File(widget.imagePath)),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 40,),
                  Pload==true?const CircularProgressIndicator():  InkWell(
                    onTap: () async {
                      Pload == false ? Pload = true : Pload = false;
                      setState(() {
                        Pload = true;
                      });

                      String currentTimeString = DateFormat('h:mm a').format(DateTime.now());

                      try {
                        final image = img.decodeImage(File(widget.imagePath).readAsBytesSync());
                        final compressedImage = img.encodeJpg(image!, quality: 5);
                        setState(() {
                          Pload == true;
                        });

                        _uploadTask = FirebaseStorage.instance
                            .ref()
                            .child('images/myimage.jpg${DateTime.now().microsecondsSinceEpoch}')
                            .putFile(File(widget.imagePath));

                        var id = DateTime.now();
                        var currentUserID = FirebaseAuth.instance.currentUser?.uid;
                        final snapshot = await _uploadTask?.whenComplete(() {});

                        var urlDownload = await snapshot?.ref.getDownloadURL();

                        print(urlDownload.toString());
                        List documentList = [];
                        QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('users').get();
                        querySnapshot.docs.forEach((doc) {
                          documentList.add(doc.id);
                        });
                        await FirebaseFirestore.instance.collection("discoverModel").doc(id.toString()).set({
                          "img": "",
                          "id": id.toString().trim(),
                          "name":
                          pVm.cachedUserDetail!.fullName!,
                          "profilePic":
                          pVm.cachedUserDetail!.photoUrl!,
                          "alike": false,
                          "like": 0,
                          "share": 0,
                          "comments": 0,
                          "currentUserID":currentUserID.toString(),
                          "counter": [],
                          "users":[],
                          "time":currentTimeString,
                          "multiImage": [urlDownload],
                          "writeUp":"",
                          "timeTw":
                          DateTime.now().format('D, M j'),
                          "sharedMultiImage":[],
                          "sharedWriteUp":"",
                          "sharedProfilePic":"",
                          "friends":documentList,
                          "sharedTime":"",
                          "sharedName":"",
                          "sharedLike": 0,
                          "sharedShare": 0,
                          "sharedComments": 0,
                          "sharedPost":false,

                        }).then((value) {
                          Navigator.of(context).pop();
                        });

                        setState(() {
                          Pload = false;
                          _downloadUrl = urlDownload;
                        });
                      } catch (e) {
                        setState(() {
                          Pload = false;
                        });
                        print(e);
                      }
                    },
                    child: Container(
                      height: 56,
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),

                      child: const Center(child: Text("Save",style: TextStyle(color: Colors.white),),),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }
    );
  }

  // void _uploadImage() async {
  //   Pload == false ? Pload = true : Pload = false;
  //   setState(() {
  //     Pload = true;
  //   });
  //
  //   try {
  //     final image = img.decodeImage(File(widget.imagePath).readAsBytesSync());
  //     final compressedImage = img.encodeJpg(image!, quality: 5);
  //     setState(() {
  //       Pload == true;
  //     });
  //     _uploadTask = FirebaseStorage.instance
  //         .ref()
  //         .child('images/myimage.jpg${DateTime.now().microsecondsSinceEpoch}')
  //         .putFile(File(widget.imagePath));
  //     var id = DateTime.now();
  //
  //     final snapshot = await _uploadTask?.whenComplete(() {});
  //     final urlDownload = await snapshot?.ref.getDownloadURL().then((value) async {
  //       await FirebaseFirestore.instance
  //           .collection("discoverModel").doc(id.toString()).set({
  //         "img": "",
  //         "id": id.toString().trim(),
  //         "name":
  //         pVm.cachedUserDetail!.displayName!,
  //         "profilePic":
  //         pVm.cachedUserDetail!.photoUrl!,
  //         "alike": false,
  //         "like": 0,
  //         "share": 0,
  //         "comments": 0,
  //         "currentUserID":currentUserID.toString(),
  //         "counter": 0,
  //         "users":[],
  //         "time":currentTimeString,
  //         "multiImage":[],
  //         "writeUp":
  //         messageTitleController.text.trim(),
  //         "timeTw":
  //         DateTime.now().format('D, M j')
  //
  //       }).then((value) {
  //         Navigator.of(context).pop();
  //       });
  //
  //
  //       setState(() {
  //         Pload = false;
  //       });
  //     });
  //
  //     setState(() {
  //       _downloadUrl = urlDownload;
  //     });
  //   } catch (e) {
  //     setState(() {
  //       Pload = false;
  //     });
  //     print(e);
  //   }
  // }
}

