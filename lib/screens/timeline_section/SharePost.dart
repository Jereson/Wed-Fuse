import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_time_format/date_time_format.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../getit.dart';
import '../../utils/base_view_builder.dart';
import '../../viewModel/profile_vm.dart';
import 'AddToFeed/SharePostFirstRow.dart';
import 'AddToFeed/SharedPostDetails.dart';

class SharePost extends StatefulWidget {
  const SharePost({
    required this.countShow,
    required this.comments,
    required this.share,
    required this.name,
    required this.listImage,
    required this.id,
    required this.time,
    required this.textPost,
    required this.imageUrl,
    Key? key
  }) : super(key: key);
  final String countShow;
  final String comments;
  final String share;
  final String name;
  final List listImage;
  final String time;
  final String textPost;
  final String id;
  final String imageUrl;

  @override
  State<SharePost> createState() => _SharePostState();
}

class _SharePostState extends State<SharePost> {
  final TextEditingController _sendMessageController = TextEditingController();
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
          appBar: AppBar(
            elevation: 0,
            centerTitle: true,
            title: const Text("Share Post",style: TextStyle(color:Colors.black,fontSize: 18,fontWeight: FontWeight.w700),),
          backgroundColor: Colors.white,),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                   SharePostFirstRow(photoUrl: pVm.cachedUserDetail!.photoUrl!, fullName: pVm.cachedUserDetail!.displayName! ,),
                  writeMessageTextField(context),
                  SharedPostDetails(widget: widget,),
                  const SizedBox(
                    height: 20,
                  ),
                 Column(
                   children: [
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
                       onTap: () {
                         var id = DateTime.now();
                         String currentTimeString =
                         DateFormat('h:mm a').format(DateTime.now());
                         var currentUserID =
                             FirebaseAuth.instance.currentUser?.uid;
                         FirebaseFirestore.instance
                             .collection("discoverModel")
                             .doc(id.toString().trim())
                             .set({
                           "img": "",
                           "id": id.toString().trim(),
                           "name":
                           pVm.cachedUserDetail!.displayName!,
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
                           "multiImage":[],
                           "writeUp":
                           _sendMessageController.text.trim(),
                           "timeTw":
                           DateTime.now().format('D, M j'),
                           "sharedMultiImage":widget.listImage,
                           "sharedWriteUp": widget.textPost,
                           "sharedProfilePic": widget.imageUrl,
                           "sharedTime": widget.time,
                           "sharedName": widget.name,
                           "sharedLike": widget.countShow,
                           "sharedShare":  widget.share,
                           "sharedComments":  widget.comments,
                           "sharedPost":true,
                         }).then((value) {
                           FirebaseFirestore.instance.collection("discoverModel").doc(widget.id).update(
                               {
                                 "share": FieldValue.increment(1),

                               });
                           Navigator.pop(context);
                         });
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
                                     "Share a post",
                                     style: TextStyle(
                                         color: Colors.white,
                                         fontSize: 20,
                                         fontWeight: FontWeight.w600),
                                   ))),
                         )),
                   ],
                 ),
                  const SizedBox(
                    height: 10,
                  ),

                ],
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
          hintText: "Write about something",
          hintStyle: TextStyle(color: Color(0xFF360001)),
          border: InputBorder.none),
    );
  }
}


