import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../../../chat/groupChat/chatControl/ChatControl.dart';
import '../../../getit.dart';
import '../../../utils/base_view_builder.dart';
import '../../../viewModel/profile_vm.dart';
import 'AddToFeedModel.dart';
import 'const/const.dart';

class AddFeed extends StatefulWidget {
  const AddFeed({Key? key, required this.pic, required this.friends}) : super(key: key);

  final String pic;
  final List friends;

  @override
  State<AddFeed> createState() => _AddFeedState();
}

class _AddFeedState extends State<AddFeed> {
  _AddFeedState();
  List<PlatformFile>? selectedImages;

  PlatformFile? selectedPdf;
  UploadTask? uploadTask;
  UploadTask? loadTask;
  bool load = false;
  final TextEditingController _messageTitleController = TextEditingController();
  int _selectedValue = 1; // The default selected value is 1

  void _handleRadioValueChanged(int value) {
    setState(() {
      _selectedValue = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseViewBuilder<ProfileViewModel>(
        model: getIt(),
        builder: (pVm, _) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: pVm.cachedUserDetail == null
                ? const Center(
                    child: CupertinoActivityIndicator(),
                  )
                : SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      appBar,
                      const Text("Tell everyone what's on your mind"),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 16.0,
                          right: 16,
                        ),
                        child: TextFormField(
                          controller: _messageTitleController,
                          keyboardType: TextInputType.multiline,
                          autocorrect: true,
                          maxLines: 15,
                          style: const TextStyle(fontSize: 12),
                          decoration: const InputDecoration(
                              fillColor: Colors.white,
                              enabled: true,
                              suffix: Text(""),
                              focusedBorder: OutlineInputBorder(),
                              hintText: "what's on your mind",
                              filled: true,
                              border: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.grey),
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(5)))),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 100,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: selectedImages?.length ?? 0,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Stack(
                                children: [
                                  Container(
                                    height: 80,
                                    width: 120,
                                    decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(Radius.circular(8)),
                                        image: DecorationImage(
                                            image: FileImage(File(selectedImages![index].path!)),
                                            fit: BoxFit.cover
                                        )
                                    ),
                                  ),
                                  Positioned(
                                    top: 0,
                                    right: 0,
                                    child: IconButton(
                                      icon: const Icon(Icons.cancel,color: Colors.red,),
                                      onPressed: () {
                                        setState(() {
                                          selectedImages!.removeAt(index);
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),


                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          InkWell(
                            onTap: () {
                              ChatControl().captureImageDiscovery(
                                  context: context, chatRoomId: "chatRoomId", id: "widget");                            },
                            child: Container(
                              height: 72,
                              width: 180,
                              decoration: const BoxDecoration(
                                  image: DecorationImage(image: AssetImage("assets/images/img_13.png"))
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              selectPictures();
                            },
                            child: Container(
                              height: 72,
                              width: 180,
                              decoration: const BoxDecoration(
                                  image: DecorationImage(image: AssetImage("assets/images/img_12.png"))
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 10.0, right: 16),
                        child: Row(
                          children: const [
                            Text(
                              "Who can see your post?",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      InkWell(
                        onTap: () {
                          _handleRadioValueChanged(1);
                        },
                        child: _selectedValue == 1
                            ? RadioListTile(
                          value: 1,
                          controlAffinity: ListTileControlAffinity.trailing,
                          activeColor: Colors.green,
                          title: const Text(
                                'Everyone',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14),
                              ), groupValue: _selectedValue, onChanged: (int? value) {
                          _handleRadioValueChanged(1);

                        },                             )
                            : RadioListTile(
                          value: 1,
                          controlAffinity: ListTileControlAffinity.trailing,
                          activeColor: Colors.grey,
                          title: const Text(
                            'Everyone',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 14),
                          ), groupValue: _selectedValue, onChanged: (int? value) {
                          _handleRadioValueChanged(1);

                        },                             ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      InkWell(
                        onTap: () {
                          _handleRadioValueChanged(2);
                        },
                        child: _selectedValue == 2
                            ?  RadioListTile(
                          value: 2,
                          controlAffinity: ListTileControlAffinity.trailing,
                          activeColor: Colors.green,
                          title: const Text(
                            'Your Friends',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 14),
                          ), groupValue: _selectedValue, onChanged: (int? value) {
                          _handleRadioValueChanged(2);

                        },                             )
                            :  RadioListTile(
                          value: 2,
                          controlAffinity: ListTileControlAffinity.trailing,
                          activeColor: Colors.grey,
                          title: const Text(
                            'Your Friends',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 14),
                          ), groupValue: _selectedValue, onChanged: (int? value) {
                          _handleRadioValueChanged(2);
                        },                             ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      InkWell(
                           onTap: () async{
                             if(selectedImages==null&&_messageTitleController.text.isEmpty){
                               return;
                             }
                             setState(() {
                               load=true;

                             });
                             if(_selectedValue==1){
                               List documentList = [];
                               QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('users').get();
                               querySnapshot.docs.forEach((doc) {
                                 documentList.add(doc.id);
                               });
                               print("1");
                               AddToFeed().addY(selectedImages: selectedImages, messageTitleController: _messageTitleController, pVm: pVm, context: context, uploadTask: uploadTask, documentList:documentList );


                             }else if (_selectedValue==2){
                               List<String> friendsList = [];

                               Future<List<String>> getFriendsList(String userId) async {

                                 QuerySnapshot friendsSnapshot = await FirebaseFirestore.instance
                                     .collection("users")
                                     .doc(userId)
                                     .collection("friends")
                                     .get();

                                 friendsSnapshot.docs.forEach((doc) {
                                   String friendId = doc.id;
                                   friendsList.add(friendId);
                                 });

                                 return friendsList;
                               }

                               print("2");
                               AddToFeed().addY(selectedImages: selectedImages, messageTitleController: _messageTitleController, pVm: pVm, context: context, uploadTask: uploadTask, documentList: widget.friends);

                             }

                             //_showNAlertDialog(selectedImages:selectedImages, messageTitleController: _messageTitleController,  pVm: pVm, uploadTask: uploadTask);
                           },
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 16.0, right: 16),
                            child: Container(
                                width: double.infinity,
                                height: 56,
                                decoration: const BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(10))),
                                child: const Center(
                                    child: Text(
                                  "Make a post",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600),
                                ))),
                          )),
                      load == true
                          ? const CircularProgressIndicator()
                          : const Text("")
                    ],
                  ),
                ),
          );
        });
  }

  Future selectPictures() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.image,
    );

    if (result != null) {
      if (result.files.length > 3) {
        // Keep only the first 3 images and ignore the rest
        setState(() {
          selectedImages = result.files.sublist(0, 3);
        });
      } else {
        setState(() {
          selectedImages = result.files;
        });
      }
    } else {
      // User canceled the selection
    }
  }



}
