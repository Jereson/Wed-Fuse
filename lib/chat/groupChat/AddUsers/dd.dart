// import 'dart:io';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:date_time_format/date_time_format.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_storage/firebase_storage.dart';
//
// import '../../../getit.dart';
// import '../../../utils/base_view_builder.dart';
// import '../../../viewModel/profile_vm.dart';
// import 'const/const.dart';
//
// class UpdateAddFeed extends StatefulWidget {
//   const UpdateAddFeed({Key? key,
//     required this.postId,
//     required this.postImage,
//     required this.textOn
//   }) : super(key: key);
//
//   final String postId;
//   final String postImage;
//   final String textOn;
//
//   @override
//   State<UpdateAddFeed> createState() => _UpdateAddFeedState();
// }
//
// class _UpdateAddFeedState extends State<UpdateAddFeed> {
//   _UpdateAddFeedState();
//
//   PlatformFile? selectedPdf;
//   UploadTask? uploadTask;
//   UploadTask? loadTask;
//   bool load = false;
//   late  TextEditingController _messageTitleController;
//
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     _messageTitleController = TextEditingController(text: widget.textOn.toString());
//
//   }
//   int _selectedValue = 1; // The default selected value is 1
//
//   void _handleRadioValueChanged(int value) {
//     setState(() {
//       _selectedValue = value;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return BaseViewBuilder<ProfileViewModel>(
//         model: getIt(),
//         builder: (pVm, _) {
//           return Scaffold(
//             backgroundColor: Colors.white,
//             body: pVm.cachedUserDetail == null
//                 ? const Center(
//               child: CupertinoActivityIndicator(),
//             )
//                 : SingleChildScrollView(
//               primary: true,
//               child: Center(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     appBarE,
//                     const Text("Tell everyone what's on your mind"),
//                     const SizedBox(
//                       height: 10,
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(
//                         left: 50.0,
//                         right: 50,
//                       ),
//                       child: TextFormField(
//                         controller: _messageTitleController,
//                         keyboardType: TextInputType.multiline,
//                         autocorrect: true,
//                         maxLines: 5,
//                         style: const TextStyle(fontSize: 12),
//                         decoration: const InputDecoration(
//                             fillColor: Colors.white,
//                             enabled: true,
//                             suffix: Text("200"),
//                             focusedBorder: OutlineInputBorder(),
//                             hintText: "what's on your mind",
//                             filled: true,
//                             border: OutlineInputBorder(
//                                 borderSide:
//                                 BorderSide(color: Colors.grey),
//                                 borderRadius: BorderRadius.all(
//                                     Radius.circular(5)))),
//                       ),
//                     ),
//                     const SizedBox(
//                       height: 10,
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//
//                         Container(
//                           height: 200,
//                           width: 130,
//                           decoration: widget.postImage.isEmpty?
//                           const BoxDecoration(
//                               color: Color(0xFFFFCDD2),
//                               borderRadius: BorderRadius.all(
//                                   Radius.circular(5))):
//                           BoxDecoration(
//                               image: DecorationImage(image: NetworkImage(widget.postImage),fit: BoxFit.cover),
//                               borderRadius: const BorderRadius.all(
//                                   Radius.circular(20))),
//                           child: widget.postImage.isEmpty?const Center(child: Text("No Image")):const Text(""),
//                         ),
//                         const Icon(Icons.swap_horiz),
//                         InkWell(
//                           onTap: () {
//                             selectPictures();
//                           },
//                           child: Container(
//                             height: 200,
//                             width: 130,
//                             decoration: selectedPdf == null?
//                             BoxDecoration(
//                               borderRadius:const BorderRadius.all(
//                                 Radius.circular(5),
//                               ),
//                               border: Border.all(
//                                 color: Colors.red,
//                                 width: 2.0,
//                                 style: BorderStyle.solid,
//                               ),
//                               color: const Color(0xFFFFCDD2),
//                             )
//                                 :BoxDecoration(
//                               image: DecorationImage(image: FileImage(File(selectedPdf!.path
//                                   .toString()),),fit: BoxFit.cover),
//                               borderRadius:const BorderRadius.all(
//                                 Radius.circular(5),
//                               ),
//                               border: Border.all(
//                                 color: Colors.red,
//                                 width: 2.0,
//                                 style: BorderStyle.solid,
//                               ),
//                               color: const Color(0xFFFFCDD2),
//                             ),
//                             child: const Center(
//                               child: Text("Add\nImage"),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(
//                       height: 10,
//                     ),
//                     Padding(
//                       padding:
//                       const EdgeInsets.only(left: 30.0, right: 30),
//                       child: Row(
//                         children: const [
//                           Text(
//                             "Select who can view your post",
//                             style: TextStyle(
//                                 fontSize: 20,
//                                 fontWeight: FontWeight.w500),
//                           ),
//                         ],
//                       ),
//                     ),
//                     const SizedBox(
//                       height: 10,
//                     ),
//                     Padding(
//                         padding:
//                         const EdgeInsets.only(left: 30.0, right: 30),
//                         child: InkWell(
//                           onTap: () {
//                             _handleRadioValueChanged(1);
//                           },
//                           child: _selectedValue == 1
//                               ? Container(
//                             width: double.infinity,
//                             height: 56,
//                             decoration: const BoxDecoration(
//                                 color: Colors.red,
//                                 borderRadius: BorderRadius.all(
//                                     Radius.circular(10))),
//                             child: ListTile(
//                               title: const Text(
//                                 'Everyone can see',
//                                 style: TextStyle(
//                                     color: Colors.white,
//                                     fontSize: 14),
//                               ),
//                               leading: Radio(
//                                 activeColor: Colors.white,
//                                 focusColor: Colors.red,
//                                 hoverColor: Colors.white,
//                                 value: 1,
//                                 groupValue: _selectedValue,
//                                 onChanged: (value) {
//                                   _handleRadioValueChanged(
//                                       int.parse(value.toString()));
//                                 },
//                               ),
//                             ),
//                           )
//                               : Container(
//                             width: double.infinity,
//                             height: 56,
//                             decoration: const BoxDecoration(
//                               color: Colors.white,
//                               borderRadius: BorderRadius.all(
//                                   Radius.circular(10)),
//                               border: Border(
//                                   top:
//                                   BorderSide(color: Colors.red),
//                                   bottom:
//                                   BorderSide(color: Colors.red),
//                                   right:
//                                   BorderSide(color: Colors.red),
//                                   left: BorderSide(
//                                       color: Colors.red)),
//                             ),
//                             child: ListTile(
//                               title: const Text(
//                                 'Everyone can see',
//                                 style: TextStyle(
//                                     color: Colors.grey,
//                                     fontSize: 14),
//                               ),
//                               leading: Radio(
//                                 activeColor: Colors.red,
//                                 focusColor: Colors.red,
//                                 hoverColor: Colors.white,
//                                 value: 1,
//                                 groupValue: _selectedValue,
//                                 onChanged: (value) {
//                                   _handleRadioValueChanged(
//                                       int.parse(value.toString()));
//                                 },
//                               ),
//                             ),
//                           ),
//                         )),
//                     const SizedBox(
//                       height: 10,
//                     ),
//                     Padding(
//                       padding:
//                       const EdgeInsets.only(left: 30.0, right: 30),
//                       child: InkWell(
//                         onTap: () {
//                           _handleRadioValueChanged(2);
//                         },
//                         child: _selectedValue == 2
//                             ? Container(
//                           width: double.infinity,
//                           height: 56,
//                           decoration: const BoxDecoration(
//                               color: Colors.red,
//                               borderRadius: BorderRadius.all(
//                                   Radius.circular(10))),
//                           child: ListTile(
//                             title: const Text(
//                               'People who i have message can see',
//                               style: TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 14),
//                             ),
//                             leading: Radio(
//                               activeColor: Colors.white,
//                               focusColor: Colors.red,
//                               hoverColor: Colors.white,
//                               value: 2,
//                               groupValue: _selectedValue,
//                               onChanged: (value) {
//                                 _handleRadioValueChanged(
//                                     int.parse(value.toString()));
//                               },
//                             ),
//                           ),
//                         )
//                             : Container(
//                           width: double.infinity,
//                           height: 56,
//                           decoration: const BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.all(
//                                 Radius.circular(10)),
//                             border: Border(
//                                 top: BorderSide(color: Colors.red),
//                                 bottom:
//                                 BorderSide(color: Colors.red),
//                                 right:
//                                 BorderSide(color: Colors.red),
//                                 left:
//                                 BorderSide(color: Colors.red)),
//                           ),
//                           child: ListTile(
//                             title: const Text(
//                               'People who i have message can see',
//                               style: TextStyle(
//                                   color: Colors.grey, fontSize: 14),
//                             ),
//                             leading: Radio(
//                               activeColor: Colors.red,
//                               focusColor: Colors.red,
//                               hoverColor: Colors.white,
//                               value: 1,
//                               groupValue: _selectedValue,
//                               onChanged: (value) {
//                                 _handleRadioValueChanged(
//                                     int.parse(value.toString()));
//                               },
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(
//                       height: 50,
//                     ),
//                     InkWell(
//                         onTap: () async {
//
//                           DateTime.now().toIso8601String();
//
//                           if (selectedPdf == null&&_messageTitleController.text.isNotEmpty) {
//                             try {
//
//                               FirebaseFirestore.instance
//                                   .collection("discoverModel")
//                                   .doc(widget.postId)
//                                   .update({
//                                 "img": "",
//                                 "writeUp":
//                                 _messageTitleController.text.trim(),
//                                 "timeTw":
//                                 DateTime.now().format('D, M j')
//                               }).then((value) {
//                               });
//                               Navigator.pop(context);
//
//                               _messageTitleController.clear();
//                               setState(() {
//                                 load = false;
//                               });
//                             } catch (e) {
//                               setState(() {
//                                 load = false;
//                               });
//                             }
//                           } else {
//                             if(_messageTitleController.text.isEmpty||selectedPdf==null){
//
//                             }
//
//                             try {
//                               final path =
//                                   "feedImage/pic/${selectedPdf!.name}";
//                               final file = File(selectedPdf!.path!);
//                               final ref =  FirebaseStorage.instance
//                                   .ref()
//                                   .child(path);
//                               uploadTask = ref.putFile(file);
//                               setState(() {
//                                 load = true;
//                               });
//
//                               final snapshot =
//                               await uploadTask?.whenComplete(() {});
//                               final urlDownload =
//                               await snapshot?.ref.getDownloadURL();
//                               FirebaseFirestore.instance
//                                   .collection("discoverModel")
//                                   .doc(widget.postId)
//                                   .update({
//                                 "img": urlDownload.toString().trim(),
//                                 "writeUp":
//                                 _messageTitleController.text.trim(),
//                               }).then((value) {
//                                 Navigator.pop(context);
//                               });
//                               var userID =
//                                   FirebaseAuth.instance.currentUser?.uid;
//                               var eid =
//                                   DateTime.now().microsecondsSinceEpoch;
//                               FirebaseFirestore.instance
//                                   .collection("storyline")
//                                   .doc(userID)
//                                   .collection("myStoryline")
//                                   .doc(eid.toString().trim())
//                                   .set({
//                                 "image": urlDownload.toString().trim(),
//                                 "id": eid.toString().trim(),
//                                 "like": [],
//                                 "viewCount": 0,
//                               });
//
//                               _messageTitleController.clear();
//                               setState(() {
//                                 load = false;
//                               });
//                             } catch (e) {
//                               setState(() {
//                                 load = false;
//                               });
//                             }
//                           }
//                         },
//                         child: Padding(
//                           padding: const EdgeInsets.only(
//                               left: 30.0, right: 30),
//                           child: Container(
//                               width: double.infinity,
//                               height: 56,
//                               decoration: const BoxDecoration(
//                                   color: Colors.red,
//                                   borderRadius: BorderRadius.all(
//                                       Radius.circular(10))),
//                               child: const Center(
//                                   child: Text(
//                                     "Edit Post",
//                                     style: TextStyle(
//                                         color: Colors.white,
//                                         fontSize: 20,
//                                         fontWeight: FontWeight.w600),
//                                   ))),
//                         )),
//                     load == true
//                         ? const CircularProgressIndicator()
//                         : const Text("")
//                   ],
//                 ),
//               ),
//             ),
//           );
//         });
//   }
//
//   Future selectPictures() async {
//     FilePickerResult? result = await FilePicker.platform.pickFiles(
//       type:
//       FileType.image, // Tried with FileType.custom too, both works on web.
//       //allowedExtensions: ["jpg", "png",]
//     );
//
//     // FilePickerResult? book = await FilePicker.platform.pickFiles(
//     //   type: FileType.image, // Tried with FileType.custom too, both works on web.
//     //   //allowedExtensions: ["jpg", "png",]
//     // );
//
//     if (result != null) {
//
//       setState(() {
//         selectedPdf = result.files.single;
//       });
//
//
//     } else {
//     }
//   }
//
// }
