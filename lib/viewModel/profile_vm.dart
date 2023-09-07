import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:ndialog/ndialog.dart';
import 'package:page_animation_transition/animations/bottom_to_top_transition.dart';
import 'package:page_animation_transition/page_animation_transition.dart';
// import 'package:social_media_recorder/main.dart';
import 'package:wedme1/constants/colors.dart';
import 'package:wedme1/getit.dart';
import 'package:wedme1/models/users_detail_model.dart';
import 'package:wedme1/screens/Auth/screen/login_screen.dart';
import 'package:wedme1/screens/Profile/profile_screen/verification/processing_verificationscreen.dart';
import 'package:wedme1/screens/add_image_screen.dart';
import 'package:wedme1/screens/congratulation_screen.dart';
import 'package:wedme1/screens/hobbies_screen.dart';
import 'package:wedme1/screens/preference_screen.dart';
import 'package:wedme1/utils/flushbar_widget.dart';
import 'package:wedme1/utils/local_storage_utils.dart';
import 'package:wedme1/viewModel/base_view_model.dart';
import 'package:wedme1/widget/custom_loader.dart';
import '../screens/preliminary/dashboard.dart';

extension SearchTerm on List<UsersDetailModel> {
  List<UsersDetailModel> filterSearch(
      {String? country,
      String? city,
      String? religion,
      num? startAge,
      required num? endAge}) {
    return where((element) =>
        element.country!.contains(country!) ||
        (element.age! >= startAge! && element.age! <= endAge!) ||
        element.religion!.contains(religion!) ||
        element.city!.contains(city!)).toList();
  }
}

class ProfileViewModel extends BaseViewModel {
  bool isIdUploaded = false;
  String? _idType;
  String? get idType => _idType;
  int? _selectedValue = -1;
  int? get selectedValue => _selectedValue;

  int userPercentMatch = 0;

  bool isHomeShowGrid = false;

  String? date;
  DateTime? selectedDate;
  final newDateFormat = DateFormat("dd-MM-yyyy");

  final ImagePicker _picker = ImagePicker();

  //Storyline properties
  final ImagePicker _storylinePicker = ImagePicker();
  List<XFile> pickedStories = [];

  //Update banner properties
  final ImagePicker _updateBannerPicker = ImagePicker();
  List<XFile> pickedUpdateBanner = [];
  int? sumLength;

  bool searchEmpty = true;
  String religionTerm = '';
  String countryTerm = '';

  UsersDetailModel? userDetail;
  bool isUsersLoaded = false;

  List<UsersDetailModel> userList = [];
  UsersDetailModel? _selectedUser;
  UsersDetailModel? cachedUserDetail;

  UsersDetailModel? get selectedUser => _selectedUser;

  ImagePicker changeProfilePicker = ImagePicker();
  XFile? pickerChangePic;

  //Bio Data properties
  final bioNameController = TextEditingController();
  String? bioMonth;
  String? bioDay;
  String? bioYear;
  bool maleSelected = false;
  bool femaleSelected = false;
  String? genderType;

  //Preference properties
  bool preferredMale = false;
  bool preferredFemale = false;
  bool preferredEveryOne = false;
  String? selectedpreference;

  final rpEmailController = TextEditingController();
  final reportController = TextEditingController();

  final fdEmailController = TextEditingController();
  final feedbackController = TextEditingController();

  bool validateSubscriptionStus(String dueDate) {
    DateTime now = DateTime.now();
    DateTime dt1 = DateTime.parse('$now');

    if (dueDate.isEmpty) {
      return false;
    } else {
      DateTime dt2 = DateTime.parse(dueDate);
      final valideate = dt1.isBefore(dt2);
      print('The validate date $valideate');
      return valideate;
    }
  }

  setIdType(String id, int index) {
    _idType = id;
    _selectedValue = index;
    setState();
  }

  setSelectedUser(UsersDetailModel user) {
    _selectedUser = user;
    setState();
  }

  selectBirthMonth(String month) {
    if (month.isEmpty) {
      'Please enter your day';
      return;
    } else {
      bioMonth = month;
      setState();
    }
  }

  selectBirthDay(String day) {
    if (day.isEmpty) {
      'Please enter your day';
      return;
    } else {
      bioDay = day;
      setState();
    }
  }

  selectBirthYear(String year) {
    if (year.isEmpty) {
      'Please enter your day';
      return;
    } else {
      bioYear = year;
      setState();
    }
  }

  selectGender(String gender) {
    if (gender == 'Male') {
      maleSelected = true;
      femaleSelected = false;
      genderType = gender;
      setState();
    } else {
      maleSelected = false;
      femaleSelected = true;
      // preferredMale = false;
      // preferredFemale = true;
      genderType = gender;
      setState();
    }

    print('The gender $gender');
  }

  setPrefernce(bool male, bool female, bool everyOne) {
    preferredMale = male;
    preferredFemale = female;
    preferredEveryOne = everyOne;
    setState();
    if (male) {
      selectedpreference = 'Male';
    } else if (female) {
      selectedpreference = 'Female';
    } else if (everyOne) {
      selectedpreference = 'Everyone';
    }
    setState();
  }

  Future<void> pickAndUploadIdentity(BuildContext context) async {
    CustomProgressDialog progressDialog = CustomProgressDialog(context,
        blur: 2, loadingWidget: const CustomLoader(), dismissable: false);
    if (_idType != null) {
      try {
        final user = firebaseInstance.currentUser;
        UploadTask uploadTask;
        final XFile? image =
            await _picker.pickImage(source: ImageSource.gallery);
        if (image != null) {
          File file = File(image.path);
          String documentName = image.name;
          progressDialog.show();
          final ref =
              firebaseStorage.ref().child('user/identity/$documentName');
          uploadTask = ref.putFile(file);
          final snapshot = await uploadTask.whenComplete(() {});
          final urlDownload = await snapshot.ref.getDownloadURL();
          print('Download Link $urlDownload');

          if (user != null) {
            print('The userid ${user.uid}');

            return userCollection.doc(user.uid).update({
              'identityType': _idType,
              'identityLink': urlDownload
            }).then((value) {
              isIdUploaded = true;
              setState();
              progressDialog.dismiss();
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) => const ProcessingVerificationScreen()),
              );
            }).catchError((error) {
              progressDialog.dismiss();
              flushbar(
                  context: context,
                  title: 'Error',
                  message: error.toString(),
                  isSuccess: false);
            });
          }
        }
      } catch (e) {
        print(e);
      }
    } else {
      flushbar(
          context: context,
          title: 'Identity',
          message: 'Please select identity type',
          isSuccess: false);
    }
  }

  Future<void> getUserProfile(BuildContext context,
      [bool mounted = true]) async {
    final uid = firebaseInstance.currentUser!.uid;
    print('The user id $uid');
    await userCollection.doc(uid).get().then((value) {
      if (value.exists) {
        cachedUserDetail = UsersDetailModel.fromJson(value.data()!);
        print('The user detail ${cachedUserDetail!.bannerPic!}');
        setState();

        Navigator.of(context).pushReplacement(PageAnimationTransition(
            page: const MyHomePage(),
            pageAnimationType: BottomToTopTransition()));
      } else {
        //Delete user account if user collection
        // firebaseInstance.currentUser!.delete();

        Navigator.of(context).pushReplacement(PageAnimationTransition(
            page: const LoginScreen(),
            pageAnimationType: BottomToTopTransition()));
      }
    }).catchError((err) {
      print('The error ${err.toString()}');
    });
  }

  Stream<List<UsersDetailModel>> allUsers() {
    List<dynamic> interest = cachedUserDetail!.interest!.isEmpty
        ? ['.k']
        : cachedUserDetail!.interest!;

    return userCollection
        .where('userId', isNotEqualTo: cachedUserDetail!.userId)
        .where('interest', arrayContainsAny: interest)
        .snapshots()
        .map((snapshot) {
      List<UsersDetailModel> userdetail = [];
      for (var doc in snapshot.docs) {
        userDetail = UsersDetailModel.fromJson(doc.data());
        userdetail.add(userDetail!);
      }
      return userdetail;
    });
  }

  Future<void> allUsers2() async {
    List<dynamic> interest = cachedUserDetail!.interest!.isEmpty
        ? ['.k']
        : cachedUserDetail!.interest!;

    await userCollection
        .where('userId', isNotEqualTo: cachedUserDetail!.userId)
        .where('interest', arrayContainsAny: interest)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        userList = [];
        for (var doc in value.docs) {
          userDetail = UsersDetailModel.fromJson(doc.data());
          userList.add(userDetail!);
        }
        setState();
      }
    });
    isUsersLoaded = true;
    setState();
  }

  Future<void> updatePrefernce(BuildContext context) async {
    if (selectedpreference != null) {
      updateUserData(context,
          data: {
            'preference': selectedpreference,
          },
          route: const HobbiesScreen());
    } else {
      flushbar(
          context: context,
          title: 'Preference Required',
          message: 'Please select your gender preference',
          isSuccess: false);
    }
  }

  Future<void> updateHobbies(BuildContext context, List<String> hobbies) async {
    if (hobbies.isNotEmpty) {
      updateUserData(context,
          data: {
            'interest': hobbies,
          },
          route: const AddImageScreen());
    } else {
      flushbar(
          context: context,
          title: 'Hobbies Required',
          message: 'Please your hobbies',
          isSuccess: false);
    }
  }

  Future<void> logOutUser(BuildContext context) async {
    CustomProgressDialog progressDialog = CustomProgressDialog(context,
        blur: 2, loadingWidget: const CustomLoader(), dismissable: false);

    progressDialog.show();
    await FirebaseAuth.instance.signOut().then((value) {
      progressDialog.dismiss();
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) {
        return const LoginScreen();
      }), (route) => false);
    });
  }

  Future<void> pickStoriesFromGalary(BuildContext context,
      [bool mounted = true]) async {
    try {
      final List<XFile> images = await _storylinePicker.pickMultiImage();
      if (images.isNotEmpty) {
        pickedStories.addAll(images);
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

  Future<void> pickSotryFromCamera(BuildContext context) async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.camera);
      if (image != null) {
        File file = File(image.path);

        print('The photot length ${pickedStories.length}');
        pickedStories.add(image);
        setState();
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> uploadStoryline(BuildContext context,
      [bool mounted = true]) async {
    CustomProgressDialog progressDialog = CustomProgressDialog(context,
        blur: 2, loadingWidget: const CustomLoader(), dismissable: false);
    try {
      UploadTask uploadTask;
      int total = 0;
      if (pickedStories.length <= 3) {
        if (pickedStories.isNotEmpty) {
          setState();
          progressDialog.show();
          for (var i = 0; i < pickedStories.length; i++) {
            //var img in pickedStories
            File file = File(pickedStories[i].path);

            final ref = firebaseStorage
                .ref()
                .child('user/storyline/${pickedStories[i].name}');
            uploadTask = ref.putFile(file);
            final snapshot = await uploadTask.whenComplete(() {});
            final urlDownload = await snapshot.ref.getDownloadURL();
            final uid = firebaseInstance.currentUser!.uid;
            //final docId = randomAlphaNumeric(14);
            final docId = DateTime.now().millisecondsSinceEpoch.toString();
            await storylineCollection
                .doc(uid)
                .collection('myStoryline')
                .doc(docId)
                .set({
                  'id': docId,
                  'image': urlDownload,
                  'viewCount': 0,
                  'like': []
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
        if (total == pickedStories.length) {
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
            message: 'You can only upload a max of 3 images at a time',
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

  unPickStory(int index) {
    pickedStories.removeAt(index);
    setState();
  }

  Future<void> deleteBanner(BuildContext context, String imageIrl,
      [bool mounted = true]) async {
    CustomProgressDialog progressDialog = CustomProgressDialog(context,
        blur: 2, loadingWidget: const CustomLoader(), dismissable: false);
    try {
      final uid = firebaseInstance.currentUser!.uid;
      //First filter out the name from the url
      final readUrl = imageIrl.split('%');
      final url2 = readUrl.last.split('?');
      final url3 = url2.first.replaceAll('2F', '');

      progressDialog.show();
      await userCollection.doc(uid).update({
        'bannerPic': FieldValue.arrayRemove([imageIrl])
      });
      final ref = firebaseStorage.ref().child('user/banner/$url3');
      await ref.delete();
      await refreshUserDetail();
      if (!mounted) return;
      progressDialog.dismiss();
      flushbar(
          context: context,
          title: 'Success',
          message: 'Image deleted successfully',
          isSuccess: false);
    } on FirebaseException catch (e) {
      progressDialog.dismiss();
      flushbar(
          context: context,
          title: 'Error',
          message: e.message.toString(),
          isSuccess: false);
      print("Failed with error '${e.code}': ${e.message}");
    } catch (e) {
      progressDialog.dismiss();
      flushbar(
          context: context,
          title: 'Error',
          message: 'Error occured, try again',
          isSuccess: false);
    }
  }

  Future<void> pickUpdateBanner(BuildContext context, int bannerlength,
      [bool mounted = true]) async {
    // if (bannerlength < 5) {
    final List<XFile> images = await _updateBannerPicker.pickMultiImage();

    if (images.isNotEmpty) {
      sumLength = bannerlength + images.length;
      // print(object)
      setState();

      if (sumLength! < 5) {
        pickedUpdateBanner.addAll(images);
        setState();
      } else {
        pickedUpdateBanner = [];
        if (!mounted) return;
        flushbar(
            context: context,
            title: 'Max',
            message: 'Max upload, exceeded, remove some images and try again.',
            isSuccess: false);
      }
    }
    // } else {
    //   if (!mounted) return;
    //   flushbar(
    //       context: context,
    //       title: 'Max',
    //       message:
    //           'You have exceed your max upload, please remove some images and try again.',
    //       isSuccess: false);
    // }
  }

  unPickUpdateBanner(int index) {
    pickedUpdateBanner.removeAt(index - 1);
    setState();
  }

  Future<void> updateBanner(BuildContext context, int bannerlength,
      [bool mounted = true]) async {
    CustomProgressDialog progressDialog = CustomProgressDialog(context,
        blur: 2, loadingWidget: const CustomLoader(), dismissable: false);

    try {
      if (pickedUpdateBanner.isEmpty) {
        flushbar(
            context: context,
            title: 'No Image',
            message: 'Please pick photo from your device',
            isSuccess: false);
      } else if ((pickedUpdateBanner.length + bannerlength) > 5) {
        flushbar(
            context: context,
            title: 'Max',
            message: 'Max upload, exceeded, remove some images and try again.',
            isSuccess: false);
      } else {
        int total = 0;

        progressDialog.show();
        for (var image in pickedUpdateBanner) {
          File file = File(image.path);
          final ref = firebaseStorage.ref().child('user/banner/${image.name}');
          UploadTask uploadTask = ref.putFile(file);
          final snapshot = await uploadTask.whenComplete(() {});
          final urlDownload = await snapshot.ref.getDownloadURL();
          final uid = firebaseInstance.currentUser!.uid;

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
                return 0;
              });
        }
        progressDialog.dismiss();
        if (total == pickedUpdateBanner.length) {
          await refreshUserDetail();
          pickedUpdateBanner = [];
          setState();

          if (!mounted) return;
          progressDialog.dismiss();
          flushbar(
              context: context,
              title: 'Success',
              message: 'Image uploaded successfully',
              isSuccess: true);
        }
      }
    } catch (e) {
      flushbar(
          context: context,
          title: 'Error',
          message: 'Error occured',
          isSuccess: false);
    }
  }

  Future<void> refreshUserDetail() async {
    final uid = firebaseInstance.currentUser!.uid;
    await userCollection.doc(uid).get().then((value) {
      if (value.exists) {
        cachedUserDetail = UsersDetailModel.fromJson(value.data()!);
        print('The user detail ${cachedUserDetail!.bannerPic!}');
        setState();
      }
    });
  }

  Future<void> changeProfilePic(BuildContext context,
      [bool mounted = true]) async {
    CustomProgressDialog progressDialog = CustomProgressDialog(context,
        blur: 2, loadingWidget: const CustomLoader(), dismissable: false);

    try {
      XFile? image =
          await changeProfilePicker.pickImage(source: ImageSource.gallery);

      if (image != null) {
        File file = File(image.path);
        progressDialog.show();
        final ref = firebaseStorage.ref().child('user/profile/${image.name}');
        UploadTask uploadTask = ref.putFile(file);
        final snapshot = await uploadTask.whenComplete(() {});
        final urlDownload = await snapshot.ref.getDownloadURL();
        final uid = firebaseInstance.currentUser!.uid;

        await userCollection
            .doc(uid)
            .update({'photoUrl': urlDownload}).then((value) async {
          await refreshUserDetail();
          progressDialog.dismiss();
          if (!mounted) return;
          Navigator.of(context).pop();
          flushbar(
              context: context,
              title: 'Success',
              message: 'Profile image uploaded successfully',
              isSuccess: true);
        }).catchError((error) {
          progressDialog.dismiss();

          flushbar(
              context: context,
              title: 'Error',
              message: error.toString(),
              isSuccess: false);
        });
      }
    } catch (e) {
      progressDialog.dismiss();
      flushbar(
          context: context,
          title: 'Error',
          message: 'Error occured, try again',
          isSuccess: false);
    }
  }

  Future<void> deleteProfileImage(BuildContext context, String imageIrl,
      [bool mounted = true]) async {
    print(imageIrl);

    CustomProgressDialog progressDialog = CustomProgressDialog(context,
        blur: 2, loadingWidget: const CustomLoader(), dismissable: false);
    try {
      final uid = firebaseInstance.currentUser!.uid;
      //First filter out the name from the url
      final readUrl = imageIrl.split('%');
      final url2 = readUrl.last.split('?');
      final url3 = url2.first.replaceAll('2F', '');

      progressDialog.show();
      await userCollection.doc(uid).update({'photoUrl': ''});
      final ref = firebaseStorage.ref().child('user/profile/$url3');
      await ref.delete();
      await refreshUserDetail();
      if (!mounted) return;
      progressDialog.dismiss();
      flushbar(
          context: context,
          title: 'Success',
          message: 'Image deleted successfully',
          isSuccess: false);
    } on FirebaseException catch (e) {
      progressDialog.dismiss();
      flushbar(
          context: context,
          title: 'Error',
          message: e.message.toString(),
          isSuccess: false);
      print("Failed with error '${e.code}': ${e.message}");
    } catch (e) {
      progressDialog.dismiss();
      flushbar(
          context: context,
          title: 'Error',
          message: 'Error occured, try again',
          isSuccess: false);
    }
  }

  Future<void> sendfeedback(
    BuildContext context,
  ) async {
    final uid = firebaseInstance.currentUser!.uid;
    await lethereYou(context,
        data: {
          'userId': uid,
          'email':
              fdEmailController.text.isNotEmpty ? fdEmailController.text : '',
          'feedback': feedbackController.text
        },
        collectionReference: feedbackCollection);

    fdEmailController.clear();
    feedbackController.clear();
    setState();
  }

  Future<void> sendReport(BuildContext context, String postId) async {
    final uid = firebaseInstance.currentUser!.uid;
    await lethereYou(context,
        data: {
          'userId': uid,
          "postId": postId,
          'email':
              rpEmailController.text.isNotEmpty ? rpEmailController.text : '',
          'feedback': reportController.text
        },
        collectionReference: reportCollection);

    rpEmailController.clear();
    reportController.clear();
    setState();
  }

  Future<void> lethereYou(BuildContext context,
      {Map<String, dynamic>? data,
      CollectionReference<Map<String, dynamic>>? collectionReference}) async {
    CustomProgressDialog progressDialog = CustomProgressDialog(context,
        blur: 2, loadingWidget: const CustomLoader(), dismissable: false);

    try {
      progressDialog.show();
      await collectionReference!.doc().set(data!).then((value) {
        progressDialog.dismiss();

        flushbar(
            context: context,
            title: 'Success',
            message: 'Operation done successfully',
            isSuccess: true);
      }).catchError((error) {
        progressDialog.dismiss();

        flushbar(
            context: context,
            title: 'Error',
            message: error.toString(),
            isSuccess: false);
      });
    } on FirebaseException catch (e) {
      progressDialog.dismiss();
      flushbar(
          context: context,
          title: 'Error',
          message: e.message.toString(),
          isSuccess: false);
      print("Failed with error '${e.code}': ${e.message}");
    } catch (e) {
      progressDialog.dismiss();
      flushbar(
          context: context,
          title: 'Error',
          message: 'Error occured, try again',
          isSuccess: false);
    }
  }

  void setUserMatch() {
    int count = 0;
    for (var element in selectedUser!.interest!) {
      if (cachedUserDetail!.interest!.contains(element)) {
        count = count + 20;
      }
      userPercentMatch = count;
      // setState();
    }
  }

  // bool isNameEdit = false;

  final pNameEditController = TextEditingController();
  final pAbountMeEditController = TextEditingController();
  final pJobEditController = TextEditingController();
  final pAgeEditController = TextEditingController();
  final pTemperamentEditController = TextEditingController();
  String? pRelogion;
  String? pGeonoty;
  String? pTemperament;
  String? pChioce;
  String? pReadiness;
  String? pPreference;

  bool isOtherSelected = false;

  void setOtherInitValue() {
    isOtherSelected = false;
  }

  void setOtherSelected(bool value) {
    isOtherSelected = value;

    setState();
  }

  void editName(BuildContext context) {
    if (pNameEditController.text != cachedUserDetail!.fullName!) {
      editProfile(context, {'fullName': pNameEditController.text});
    }
  }

  void editAboutMe(BuildContext context) {
    if (pAbountMeEditController.text != cachedUserDetail!.aboutMe!) {
      editProfile(context, {'aboutMe': pAbountMeEditController.text});
    }
  }

  void editJob(BuildContext context) {
    if (pJobEditController.text != cachedUserDetail!.job!) {
      editProfile(context, {'job': pJobEditController.text});
    }
  }

  void editAge(BuildContext context) {
    if (pAgeEditController.text != '${cachedUserDetail!.age!}') {
      editProfile(context, {'age': int.parse(pAgeEditController.text)});
    }
  }

  void editReligion(BuildContext context, String value) {
    if (value == cachedUserDetail!.religion) return;
    editProfile(context, {'religion': value});
  }

  void editGeonoty(BuildContext context, String value) {
    if (value == cachedUserDetail!.genoType) return;
    editProfile(context, {'genoType': value});
  }

  void editTemperament(BuildContext context, String value) {
    if (value == cachedUserDetail!.temperament) return;
    editProfile(context, {'temperament': value});
    setOtherSelected(false);
  }

  void editChoice(BuildContext context, String value) {
    if (value == cachedUserDetail!.choice) return;
    editProfile(context, {'choice': value});
  }

  void editMarraigeReadiness(BuildContext context, String value) {
    if (value == cachedUserDetail!.marriageRadyness) return;
    editProfile(context, {'marriageRadyness': value});
  }

  void editPreference(BuildContext context, String value) {
    if (value == cachedUserDetail!.preference) return;
    editProfile(context, {'preference': value});
  }

  void editCounty(BuildContext context, String value) {
    if (value == cachedUserDetail!.country) return;
    editProfile(context, {'country': value});
  }

  setInitTextEditingController() {
    pNameEditController.text = cachedUserDetail!.fullName!;
    pAbountMeEditController.text = cachedUserDetail!.aboutMe!;
    pJobEditController.text = cachedUserDetail!.job!;
    pAgeEditController.text = '${cachedUserDetail!.age!}';
    // pRelogion = cachedUserDetail!.religion!;
  }

  Future<void> pickDateOfBirth(BuildContext context) async {
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
        initialDate: DateTime(1900),
        firstDate: DateTime(1900),
        lastDate: DateTime(2100));

    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      date = newDateFormat.format(selectedDate!);
      final formateDate = date!.split('-');
      bioDay = formateDate[0];

      bioMonth = formateDate[1];
      bioYear = formateDate[2];

      print('selectedDate $selectedDate');
      print('date $date');
      setState();
    }
  }

  Future<void> updateBioData(BuildContext context) async {
    print(genderType);
    print('The date $date');
    if (genderType != null && date != null) {
      updateUserData(context,
          data: {
            'birthDay': bioDay,
            'birthMonth': bioMonth,
            'birthYear': bioYear,
            'gender': genderType,
            'displayName': bioNameController.text.split(' ').first,
            'fullName': bioNameController.text
          },
          route: const PreferenceScreen());
    } else {
      if (date == null) {
        flushbar(
            context: context,
            title: 'Date of birth Required',
            message: 'Please select your date of birth',
            isSuccess: false);
      } else if (genderType == null) {
        flushbar(
            context: context,
            title: 'Gender Required',
            message: 'Please select gender',
            isSuccess: false);
      }
    }
  }

  Future<void> editProfile(BuildContext context, Map<Object, Object> data,
      [bool mounted = true]) async {
    try {
      final uid = firebaseInstance.currentUser!.uid;
      await userCollection.doc(uid).update(data).then((value) async {
        await refreshUserDetail();
        if (!mounted) return;
        flushbar(
            context: context,
            title: 'Success',
            message: 'Update made',
            isSuccess: true);
      }).catchError((error) {
        flushbar(
            context: context,
            title: 'Error',
            message: error.toString(),
            isSuccess: false);
      });
    } catch (e) {
      flushbar(
          context: context,
          title: 'Error',
          message: e.toString(),
          isSuccess: false);
    }
  }

  num calProfilePercent() {
    num percent = 0;
    if (cachedUserDetail!.fullName!.isNotEmpty) {
      percent = percent + 4.1667;
    }
    if (cachedUserDetail!.email!.isNotEmpty) {
      percent = percent + 4.1667;
    }
    if (cachedUserDetail!.photoUrl!.isNotEmpty) {
      percent = percent + 4.1667;
    }
    if (cachedUserDetail!.phoneNumber!.isNotEmpty) {
      percent = percent + 4.1667;
    }
    if (cachedUserDetail!.country!.isNotEmpty) {
      percent = percent + 4.1667;
    }
    if (cachedUserDetail!.city!.isNotEmpty) {
      percent = percent + 4.1667;
    }
    if (cachedUserDetail!.religion!.isNotEmpty) {
      percent = percent + 4.1667;
    }
    if (cachedUserDetail!.genoType!.isNotEmpty) {
      percent = percent + 4.1667;
    }
    if (cachedUserDetail!.temperament!.isNotEmpty) {
      percent = percent + 4.1667;
    }
    if (cachedUserDetail!.choice!.isNotEmpty) {
      percent = percent + 4.1667;
    }
    if (cachedUserDetail!.bannerPic!.isNotEmpty) {
      percent = percent + 4.1667;
    }
    if (cachedUserDetail!.age! > 0) {
      percent = percent + 4.1667;
    }
    if (cachedUserDetail!.birthDay!.isNotEmpty) {
      percent = percent + 4.1667;
    }
    if (cachedUserDetail!.birthMonth!.isNotEmpty) {
      percent = percent + 4.1667;
    }
    if (cachedUserDetail!.birthYear!.isNotEmpty) {
      percent = percent + 4.1667;
    }
    if (cachedUserDetail!.lat! > 0 || cachedUserDetail!.lng! > 0) {
      percent = percent + 4.1667;
    }
    if (cachedUserDetail!.course!.isNotEmpty) {
      percent = percent + 4.1667;
    }
    if (cachedUserDetail!.schoolName!.isNotEmpty) {
      percent = percent + 4.1667;
    }
    if (cachedUserDetail!.marriageRadyness!.isNotEmpty) {
      percent = percent + 4.1667;
    }
    if (cachedUserDetail!.aboutMe!.isNotEmpty) {
      percent = percent + 4.1667;
    }
    if (cachedUserDetail!.preference!.isNotEmpty) {
      percent = percent + 4.1667;
    }
    if (cachedUserDetail!.job!.isNotEmpty) {
      percent = percent + 4.1667;
    }
    if (cachedUserDetail!.images!.isNotEmpty) {
      percent = percent + 4.1667;
    }
    if (cachedUserDetail!.interest!.isNotEmpty) {
      percent = percent + 4.1667;
    }

    return percent;
  }

  Future<void> setShowAgeButton(bool value) async {
    await getIt.get<LocalStorage>().setShowAge(value);
    setState();
  }

  Future<void> setShowDistanceButton(bool value) async {
    await getIt.get<LocalStorage>().setShowDistance(value);
    setState();
  }

  Future<void> setShowGenotyButton(bool value) async {
    await getIt.get<LocalStorage>().setShowGenotype(value);
    setState();
  }

  void setHomeShow() {
    isHomeShowGrid = !isHomeShowGrid;
    setState();
  }

  // List<UsersDetailModel> getFilterSearch() =>
  //     searchEmpty ? userList : userList.filterSearch(religionTerm, countryTerm);

  String? filterCountry;
  String? filterCity;
  String? filterReligion;
  num? ageStart;
  num? ageEnd;
  bool isFiltering = false;

  Future<void> setFilterData(
      {String? fCountry,
      String? fCity,
      String? fReligion,
      num? aStart,
      num? aEnd}) async {
    filterCountry = fCountry ?? 'zxzpzkz';
    filterCity = fCity ?? 'zxzxzxok';
    filterReligion = fReligion ?? 'zxmkxl';
    ageStart = aStart ?? 0;
    ageEnd = aEnd ?? 0;
    isFiltering = true;
    setState();
  }

  void resetFilterBool() {
    isFiltering = false;
    setState();
  }

  List<UsersDetailModel> serchList() => !isFiltering
      ? userList
      : userList.filterSearch(
          country: filterCountry,
          city: filterCity,
          religion: filterReligion,
          startAge: ageStart,
          endAge: ageEnd);
}
