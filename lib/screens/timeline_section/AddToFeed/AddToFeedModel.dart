

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_time_format/date_time_format.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../../viewModel/profile_vm.dart';

class AddToFeed{


  addY({

    required List documentList,required List<PlatformFile>? selectedImages, required TextEditingController messageTitleController, required ProfileViewModel pVm, required BuildContext context, required UploadTask? uploadTask,
})async{
   //  List documentList = [];
   //  QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('users').get();
   //  querySnapshot.docs.forEach((doc) {
   //    documentList.add(doc.id);
   //  });
   //
   //  print(documentList);
   // var snap = FirebaseFirestore.instance.collection("users").doc().get();


    DateTime.now().toIso8601String();
    String currentTimeString =
    DateFormat('h:mm a').format(DateTime.now());

    var currentUserID =
        FirebaseAuth.instance.currentUser?.uid;

    if (selectedImages == null &&
        messageTitleController.text.isNotEmpty) {
      try {
        var id = DateTime.now();
        FirebaseFirestore.instance
            .collection("discoverModel")
            .doc(id.toString().trim())
            .set({
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
          "multiImage":[],
          "writeUp":
          messageTitleController.text.trim(),
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

        }).then((value) {});
        Navigator.pop(context);

        messageTitleController.clear();

      } catch (e) {

      }
    } else {

      if (messageTitleController.text.isEmpty ||
          selectedImages == null) {}
      try {
        final List<String> imageUrls = [];
        for (int i = 0; i < selectedImages!.length; i++) {
          final File file =File(selectedImages[i].path!);
          final String fileName = '${DateTime.now().millisecondsSinceEpoch}.jpg';
          final Reference reference = FirebaseStorage.instance.ref().child('images/$fileName');
          final UploadTask uploadTask = reference.putFile(file);
          final TaskSnapshot downloadUrl = (await uploadTask);
          final String imageUrl = await downloadUrl.ref.getDownloadURL();
          imageUrls.add(imageUrl);
        }



        final snapshot =
            await uploadTask?.whenComplete(() {});
        final urlDownload =
            await snapshot?.ref.getDownloadURL();
        var id = DateTime.now();
        FirebaseFirestore.instance
            .collection("discoverModel")
            .doc(id.toString().trim())
            .set({
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
          "friends":documentList,
          "currentUserID":currentUserID.toString(),
          "counter": [],
          "users":[],
          "time":currentTimeString,
          "multiImage":imageUrls,
          "writeUp":
          messageTitleController.text.trim(),
          "timeTw":
          DateTime.now().format('D, M j'),
          "sharedMultiImage":[],
          "sharedWriteUp":"",
          "sharedProfilePic":"",
          "sharedTime":"",
          "sharedName":"",
          "sharedLike": 0,
          "sharedShare": 0,
          "sharedComments": 0,
          "sharedPost":false,
        }).then((value) {
          Navigator.pop(context);
        });
        var userID =
            FirebaseAuth.instance.currentUser?.uid;
        var eid =
            DateTime.now().microsecondsSinceEpoch;
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

        messageTitleController.clear();

      } catch (e) {

      }
    }
  }

  addUpdate({required List<PlatformFile>? selectedImages, required TextEditingController messageTitleController,
    required ProfileViewModel pVm,
    required BuildContext context,
    required List documentList,
    required String updateId,
    required UploadTask? uploadTask,
  })async{
    DateTime.now().toIso8601String();
    String currentTimeString =
    DateFormat('h:mm a').format(DateTime.now());

    var currentUserID =
        FirebaseAuth.instance.currentUser?.uid;

    if (selectedImages == null &&
        messageTitleController.text.isNotEmpty) {
      try {
        var id = DateTime.now();
        FirebaseFirestore.instance
            .collection("discoverModel")
            .doc(updateId)
            .update({
          "img": "",
          "id": updateId,
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
          "multiImage":[],
          "writeUp":

          messageTitleController.text.trim(),
          "timeTw":
          DateTime.now().format('D, M j'),
          "sharedMultiImage":[],
          "sharedWriteUp":"",
          "sharedProfilePic":"",

          "sharedTime":"",
          "sharedName":"",
          "sharedLike": 0,
          "sharedShare": 0,
          "sharedComments": 0,
          "sharedPost":false,
        }).then((value) {});
        Navigator.pop(context);

        messageTitleController.clear();

      } catch (e) {

      }
    } else {

      if (messageTitleController.text.isEmpty ||
          selectedImages == null) {}
      try {
        final List<String> imageUrls = [];
        for (int i = 0; i < selectedImages!.length; i++) {
          final File file =File(selectedImages[i].path!);
          final String fileName = '${DateTime.now().millisecondsSinceEpoch}.jpg';
          final Reference reference = FirebaseStorage.instance.ref().child('images/$fileName');
          final UploadTask uploadTask = reference.putFile(file);
          final TaskSnapshot downloadUrl = (await uploadTask);
          final String imageUrl = await downloadUrl.ref.getDownloadURL();
          imageUrls.add(imageUrl);
        }



        final snapshot =
        await uploadTask?.whenComplete(() {});
        final urlDownload =
        await snapshot?.ref.getDownloadURL();
        var id = DateTime.now();
        FirebaseFirestore.instance
            .collection("discoverModel")
            .doc(updateId)
            .update({
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
          "multiImage":imageUrls,
          "writeUp":
          messageTitleController.text.trim(),
          "timeTw":
          DateTime.now().format('D, M j'),
          "sharedMultiImage":[],
          "sharedWriteUp":"",
          "sharedProfilePic":"",
          "sharedTime":"",
          "sharedName":"",
          "sharedLike": 0,
          "sharedShare": 0,
          "sharedComments": 0,
          "sharedPost":false,
        }).then((value) {
          Navigator.pop(context);
        });
        var userID =
            FirebaseAuth.instance.currentUser?.uid;
        var eid =
            DateTime.now().microsecondsSinceEpoch;

        messageTitleController.clear();

      } catch (e) {

      }
    }
  }
}