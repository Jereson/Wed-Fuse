import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:ndialog/ndialog.dart';
import 'package:path_provider/path_provider.dart';
import 'package:wedme1/constants/colors.dart';
import 'package:wedme1/utils/flushbar_widget.dart';
import 'package:wedme1/viewModel/base_view_model.dart';
import 'package:wedme1/widget/custom_loader.dart';
import 'package:widgets_to_image/widgets_to_image.dart';

import '../models/wedding_templete_model.dart';

class MarriageViewModel extends BaseViewModel {
  int currentIndex = 0;

  bool isInviteUploaded = false;

  final brideNameController = TextEditingController();
  final groomNameController = TextEditingController();
  final locationController = TextEditingController();
  final tagController = TextEditingController();
  String countCertLink = '';

  String? date;
  DateTime? selectedDate;
  // final newDateFormat = DateFormat("yyyy-MM-dd");
  // final newDateFormat = DateFormat("dd-MM-yyyy");
  final newDateFormat = DateFormat.yMMMMd('en_US');
  final ImagePicker _picker = ImagePicker();
  File? certificatFile;
  File? convertedMarraigeInvite;
  String? fileName;
  List<String> imagesUrls = [];

  CertParseData? certParseData;

  setCurrentIndex(int index) {
    currentIndex = index;
    setState();
  }

//File: '/data/user/0/com.briskita.wedme/cache/image.png'
  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        builder: (context, child) {
          return Theme(
              data: Theme.of(context).copyWith(
                  colorScheme: const ColorScheme.light(
                primary: kPrimaryColor,
                onPrimary: Colors.white,
                onSurface: Colors.black,
              )),
              child: child!);
        },
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime(2100));

    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      date = newDateFormat.format(selectedDate!);

      print('selectedDate $selectedDate');
      print('date $date');
      setState();
    }
  }

  Future<void> pickCertification() async {
    print('object');
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

      if (image != null) {
        certificatFile = File(image.path);
        fileName = image.name;
        setState();
        print('The cert $certificatFile');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  // Future<void> convertMarriageInvite(
  //     WidgetsToImageController controller) async {
  //   final convertImage = await controller.capture();

  //   final tempDir = await getTemporaryDirectory();
  //   File file = await File('${tempDir.path}/${DateTime.now()}.png').create();
  //   file.writeAsBytesSync(convertImage!);
  //   print(file);

  //   convertedMarraigeInvite = file;
  //   setState();
  // }

  Future<void> saveCertificate(
      BuildContext context, WidgetsToImageController controller) async {
    CustomProgressDialog progressDialog = CustomProgressDialog(context,
        blur: 2, loadingWidget: const CustomLoader(), dismissable: false);

    try {
      progressDialog.show();
      final user = firebaseInstance.currentUser;
      //Uplaod first image Marriage cert pick from phone

      //Store image to firebase storage
      UploadTask uploadTask;
      final ref = firebaseStorage.ref().child('marriage/$fileName');
      uploadTask = ref.putFile(certificatFile!);
      final snapshot = await uploadTask.whenComplete(() {});

      //Download the image url
      final certDownloadUrl = await snapshot.ref.getDownloadURL();

      final img = wedingTemplet[currentIndex].image;

      //Upload template from Assets folder
      String imageName =
          img!.substring(img.lastIndexOf("/"), img.lastIndexOf("."));
      String path = img.substring(img.indexOf("/") + 1, img.lastIndexOf("/"));

      // final Directory systemTempDir = Directory.systemTemp;
      // final byteData = await rootBundle.load(img);
      // final file2 = File('${systemTempDir.path}/$imageName.jpg');

      // await file2.writeAsBytes(byteData.buffer
      //     .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

      final convertImage = await controller.capture();

      final tempDir = await getTemporaryDirectory();
      File file = await File('${tempDir.path}/${DateTime.now()}.png').create();
      file.writeAsBytesSync(convertImage!);
      print(file);

      // convertedMarraigeInvite = file;

      TaskSnapshot taskSnapshot = await firebaseStorage
          .ref()
          .child('marriage/$imageName')
          .putFile(file);
      final String templateDownloadUrl =
          await taskSnapshot.ref.getDownloadURL();

      progressDialog.dismiss();
      print('Download Link $certDownloadUrl');
      print('Download1 Link $templateDownloadUrl');

      //Update the urr link to collection
      await marriageCollection
          .doc(user!.uid)
          .collection('myMarriageCert')
          .doc()
          .set({
        'brideName': brideNameController.text,
        'groomName': groomNameController.text,
        'date': date,
        'location': locationController.text,
        'tagPerson': tagController.text,
        'certificatLink': certDownloadUrl,
        'template': templateDownloadUrl,
        'userId': user.uid,
        'status': 0 // 0 means pending and 1 is approve
      }).then((value) {
        isInviteUploaded = true;
        //Clear screen
        brideNameController.clear();
        groomNameController.clear();
        locationController.clear();
        tagController.clear();
        date = null;
        certificatFile = null;
        setState();

        progressDialog.dismiss();
        Navigator.of(context).pop();
        Navigator.of(context).pop();
        Navigator.of(context).pop();
        Navigator.of(context).pop();
        flushbar(
            context: context,
            title: 'Success',
            message: 'Invite saved successfuly',
            isSuccess: true);
      }).catchError((error) {
        progressDialog.dismiss();
        flushbar(
            context: context,
            title: 'Error',
            message: error.toString(),
            isSuccess: false);
      });
    } catch (e) {
      print('the error $e');
      progressDialog.dismiss();
      flushbar(
          context: context,
          title: 'Error',
          message: e.toString(),
          isSuccess: false);
    }
  }

  Future<void> uploadFiles(List images) async {
    // ignore: avoid_function_literals_in_foreach_calls
    images.forEach((image) async {
      final ref = firebaseStorage.ref().child('cerificate/${image.path}');
      FirebaseStorage.instance.ref().child('posts/${image.path}');
      UploadTask uploadTask = ref.putFile(image);

      imagesUrls.add(
          await (await uploadTask.whenComplete(() {})).ref.getDownloadURL());
    });
  }

  void setCertParseData(String id, String link) {
    certParseData = CertParseData(userId: id, template: link);
    setState();
  }
}

class CertParseData {
  final String userId;
  final String template;

  CertParseData({required this.userId, required this.template});
}
