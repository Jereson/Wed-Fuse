import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ndialog/ndialog.dart';
import 'package:wedme1/screens/congratulation_screen.dart';
import 'package:wedme1/utils/flushbar_widget.dart';
import 'package:wedme1/viewModel/base_view_model.dart';
import 'package:wedme1/widget/custom_loader.dart';

class BannerVm extends BaseViewModel {
//Banner propertites
  ImagePicker bannerPiker = ImagePicker();
  List<XFile> pickedBanner = [];

  Future<void> pickBannerFromGalary(BuildContext context,
      [bool mounted = true]) async {
    try {
      final List<XFile> images = await bannerPiker.pickMultiImage();
      if (images.isNotEmpty) {
        pickedBanner.addAll(images);
        setState();
      }
    } catch (e) {
      flushbar(
          context: context,
          title: 'Error',
          message: e.toString(),
          isSuccess: false);
    }
  }

  Future<void> pickBannerFromCamera(BuildContext context) async {
    try {
      final XFile? image =
          await bannerPiker.pickImage(source: ImageSource.camera);
      if (image != null) {
        File file = File(image.path);

        print('The photot length ${pickedBanner.length}');
        pickedBanner.add(image);
        setState();
      }
    } catch (e) {
      print(e);
    }
  }

  unPickBanner(int index) {
    pickedBanner.removeAt(index);
    setState();
  }

  Future<void> uploadBanner(BuildContext context, [bool mounted = true]) async {
    CustomProgressDialog progressDialog = CustomProgressDialog(context,
        blur: 2, loadingWidget: const CustomLoader(), dismissable: false);
    try {
      UploadTask uploadTask;
      int total = 0;
      if (pickedBanner.length <= 3) {
        if (pickedBanner.isNotEmpty) {
          setState();
          progressDialog.show();
          for (var i = 0; i < pickedBanner.length; i++) {
            //var img in pickedStories
            File file = File(pickedBanner[i].path);

            final ref = firebaseStorage
                .ref()
                .child('user/banner/${pickedBanner[i].name}');
            uploadTask = ref.putFile(file);
            final snapshot = await uploadTask.whenComplete(() {});
            final urlDownload = await snapshot.ref.getDownloadURL();
            final uid = firebaseInstance.currentUser!.uid;
            //  String uid = 'qihGXx29paYuVEASzcfgDWLF9CD3';

            await userCollection
                .doc(uid)
                .update({
                  'bannerPic': FieldValue.arrayUnion([urlDownload])
                })
                .then((value) => total++)
                .catchError((error) {
                  progressDialog.dismiss();
                  flushbar(
                      context: context,
                      title: 'Error',
                      message: error.toString(),
                      isSuccess: false);
                });
          }
        }

        progressDialog.dismiss();
        if (total == pickedBanner.length) {
          if (!mounted) return;
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                  builder: (context) => const CongratulationScreen()),
              (route) => false);
        }
      } else {
        flushbar(
            context: context,
            title: 'Max',
            message: 'You can only upload a max of 3 images',
            isSuccess: false);
      }
    } catch (e) {
      progressDialog.dismiss();
      flushbar(
          context: context,
          title: 'Error',
          message: e.toString(),
          isSuccess: false);
    }
  }
}
