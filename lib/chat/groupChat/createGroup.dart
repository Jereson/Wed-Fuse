import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:date_time_format/date_time_format.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../../getit.dart';
import '../../../utils/base_view_builder.dart';
import '../../../viewModel/profile_vm.dart';
import '../../widget/custom_loader.dart';

class CreateGroupChat extends StatefulWidget {
  const CreateGroupChat({Key? key, required this.pic}) : super(key: key);

 final String pic;

  @override
  State<CreateGroupChat> createState() => _CreateGroupChatState();
}

class _CreateGroupChatState extends State<CreateGroupChat> {

  PlatformFile? selectedPdf;
  PlatformFile? selectedPdfT;
  UploadTask? uploadTask;
  UploadTask? uploadTaskT;
  UploadTask? puploadTask;
  bool Pload = false;
  final TextEditingController _messageTitleController = TextEditingController();
  int _selectedValue = 1; // The default selected value is 1

  void _handleRadioValueChanged(int value) {
    setState(() {
      _selectedValue = value;
    });
  }

  final appBar = AppBar(
    backgroundColor: Colors.white,
    elevation: 0,
    centerTitle: true,
    title: const Text(
      "Create Group Chat",
      style: TextStyle(
          color: Colors.black, fontWeight: FontWeight.w700, fontSize: 25),
    ),
  );
  @override
  Widget build(BuildContext context) {
    return BaseViewBuilder<ProfileViewModel>(
        model: getIt(),
        builder: (pVm, _) {
          return Pload == true?  Container(
            color: Colors.white.withOpacity(0.5),
            child:  const CustomLoader(),
          ):
          Scaffold(
            backgroundColor: Colors.white,
            body: pVm.cachedUserDetail == null
                ? const Center(
              child: CupertinoActivityIndicator(),
            )
                : SingleChildScrollView(
              primary: true,
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 20.0,
                  right: 20,
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      appBar,
                      const SizedBox(height: 60,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children:const [
                           Text("Name of Group", style: TextStyle(fontWeight: FontWeight.w600),),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: _messageTitleController,
                        obscureText: false,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          hintText: "e.g joys group",
                          enabled: true,
                          filled: true,
                          border: InputBorder.none,
                          contentPadding:
                          EdgeInsets.symmetric(vertical: 14, horizontal: 10),
                          isDense: true,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children:const [
                          Text("Header Image",),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      InkWell(
                        onTap: () {
                          selectPictures();
                        },
                        child: Container(
                          width: double.infinity,
                          height: 150,
                          decoration:  BoxDecoration(
                            color: const Color(0xFFf8e8e8),
                              image: DecorationImage(image: selectedPdf==null?FileImage(File("path")):FileImage(File(selectedPdf!.path.toString())),fit: BoxFit.cover),
                              borderRadius: const BorderRadius.all(
                                  Radius.circular(15))

                          ),
                          child:selectedPdf == null
                              ? const Center(child:  Text("Add Image", style: TextStyle(color: Colors.grey))):Text(""),
                        ),
                      ),
                      const SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children:const [
                          Text("Add marriage Certificate",),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      InkWell(
                        onTap: () {
                          selectPicturesT();
                        },
                        child: Container(
                          width: double.infinity,
                          height: 150,
                          decoration:  BoxDecoration(
                              color: const Color(0xFFf8e8e8),
                              image: DecorationImage(image: selectedPdfT==null?FileImage(File("")):FileImage(File(selectedPdfT!.path.toString())),fit: BoxFit.cover),
                              borderRadius: const BorderRadius.all(
                                  Radius.circular(15))


                          ),
                          child:selectedPdfT == null
                              ? const Center(child: Text("Add Image", style: TextStyle(color: Colors.grey),)):
                          const Text("") ,
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      InkWell(
                          onTap: () async {
                            DateTime.now().toIso8601String();
                            var currentUserID = FirebaseAuth.instance.currentUser?.uid;

                            if (selectedPdf == null&&selectedPdfT==null&&_messageTitleController.text.isEmpty) {

                            }else{

                              try {
                                final path = "feedImage/pic/${selectedPdf!.name}";
                                final pathT = "feedImage/pic/${selectedPdfT!.name}";
                                final file = File(selectedPdf!.path!);
                                final fileT = File(selectedPdfT!.path!);
                                final ref = await FirebaseStorage.instance
                                    .ref()
                                    .child(path);
                                uploadTask = ref.putFile(file);
                                uploadTaskT = ref.putFile(fileT);
                                setState(() {
                                  Pload = true;
                                });

                                final snapshot =
                                await uploadTask?.whenComplete(() {});
                                await uploadTaskT?.whenComplete(() {});
                                final urlDownload = await snapshot?.ref.getDownloadURL();
                                final urlDownloadT = await snapshot?.ref.getDownloadURL();
                                var date = DateTime.now().millisecondsSinceEpoch.toString();

                                var id =
                                    DateTime.now().microsecondsSinceEpoch;
                                await FirebaseFirestore.instance.collection("groupChat").doc(date).set({
                                  "users":[FirebaseAuth.instance.currentUser!.uid,],
                                  "photoUrl":urlDownload.toString().trim(),
                                  "photoUrlT":urlDownloadT.toString().trim(),
                                  "name":_messageTitleController.text.trim(),
                                  "userId":FirebaseAuth.instance.currentUser!.uid,
                                  "id":date,
                                  "state":"offline",
                                  "count":0,
                                  "lastChat":"",
                                  "time":""
                                }).then((value) {
                                  Navigator.pop(context);
                                });
                                _messageTitleController.clear();
                                setState(() {
                                  Pload = false;
                                });
                              } catch (e) {
                                print("this is the error $e");
                                setState(() {
                                  Pload = false;
                                });
                              }
                            }

                            }, child: Container(
                                width: double.infinity,
                                height: 56,

                                decoration: const BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(10))),
                                child: const Center(
                                    child: Text(
                                      "Create Wedding Group",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600),
                                    )))

                       ),
                      Pload == true
                          ? const   CustomLoader()
                          : const Text("")
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  Future selectPictures() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type:
      FileType.image, // Tried with FileType.custom too, both works on web.
      //allowedExtensions: ["jpg", "png",]
    );

    // FilePickerResult? book = await FilePicker.platform.pickFiles(
    //   type: FileType.image, // Tried with FileType.custom too, both works on web.
    //   //allowedExtensions: ["jpg", "png",]
    // );

    if (result != null) {
      print("Has pictures");

      setState(() {
        selectedPdf = result.files.single;
      });

      result.files.forEach((element) {});

      // result.files.forEach((f){
      //
      //
      //
      // });

      print(result);
      print(result.files.length);
      print(result);
      print(result.paths);
    } else {
      print("Null or doesn't have pictures");
    }
  }
  Future selectPicturesT() async {
    FilePickerResult? resultT = await FilePicker.platform.pickFiles(
      type:
      FileType.image, // Tried with FileType.custom too, both works on web.
      //allowedExtensions: ["jpg", "png",]
    );

    // FilePickerResult? book = await FilePicker.platform.pickFiles(
    //   type: FileType.image, // Tried with FileType.custom too, both works on web.
    //   //allowedExtensions: ["jpg", "png",]
    // );

    if (resultT != null) {
      print("Has pictures");

      setState(() {
        selectedPdfT = resultT.files.single;
      });

      resultT.files.forEach((element) {});

      // result.files.forEach((f){
      //
      //
      //
      // });

      print(resultT);
      print(resultT.files.length);
      print(resultT);
      print(resultT.paths);
    } else {
      print("Null or doesn't have pictures");
    }
  }

  Future<void> uploadToFirebase() async {
    DateTime.now().toIso8601String();

      try {
        final path = "feedImage/pic/${selectedPdf!.name}";
        final pathT = "feedImage/pic/${selectedPdfT!.name}";
        final file = File(selectedPdf!.path!);
        final fileT = File(selectedPdfT!.path!);
        final ref = await FirebaseStorage.instance.ref().child(path);
        uploadTask = ref.putFile(file);
        setState(() {
          Pload = true;
        });

        final snapshot = await uploadTask?.whenComplete(() {});
        final urlDownload = await snapshot?.ref.getDownloadURL();
        var date = DateTime.now();

        var id = DateTime.now().microsecondsSinceEpoch;
        FirebaseFirestore.instance
            .collection("DiscoverModel")
            .doc(id.toString().trim())
            .set({
          "img": urlDownload.toString().trim(),
          "id": id.toString().trim(),
          "name": "Emmanuel",
          "profilePic": widget.pic,
          "Counter": 0,
          "Addlike": false,
          "writeUp": _messageTitleController.text.trim(),
          "timeTw": "${DateTime.now().format('D, M j')}"
        });
        var userID = FirebaseAuth.instance.currentUser?.uid;
        var eid = DateTime.now().microsecondsSinceEpoch;
        FirebaseFirestore.instance
            .collection("storyline")
            .doc(userID)
            .collection("myStoryline")
            .doc(eid.toString().trim())
            .set({
          "image": urlDownload.toString().trim(),
          "id": eid.toString().trim(),
          "like": [],
          "viewCount": 0,
        });

        _messageTitleController.clear();
        setState(() {
          Pload = false;
        });
      } catch (e) {
        print("this is the error $e");
        setState(() {
          Pload = false;
        });
      }

  }
}
