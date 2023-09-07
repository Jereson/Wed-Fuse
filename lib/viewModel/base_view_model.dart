import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:ndialog/ndialog.dart';
import 'package:wedme1/utils/flushbar_widget.dart';
import 'package:wedme1/widget/custom_loader.dart';

enum ViewState { busy, done, error, none, noInternet }

class BaseViewModel with ChangeNotifier {
  ViewState viewState = ViewState.none;
  String viewMessage = '';
  String errorMessage = '';
  bool _disposed = false;

  bool get hasEncounteredError =>
      viewState == ViewState.error || viewState == ViewState.noInternet;
  bool get isBusy => viewState == ViewState.done;

  @override
  void dispose() {
    super.dispose();
    _disposed = true;
  }

  void setState({ViewState? viewState, String? viewMessage}) {
    if (viewState != null) this.viewState = viewState;
    if (viewMessage != null) this.viewMessage = viewMessage;
    if (!_disposed) notifyListeners();
  }

  //Firebase Instance

  final firebaseInstance = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;
  final userCollection = FirebaseFirestore.instance.collection('users');
  final marriageCollection =
      FirebaseFirestore.instance.collection('marriageCertificate');
  final whoILikeCollection = FirebaseFirestore.instance.collection('whoIliked');
  final whoLikeMeCollection =
      FirebaseFirestore.instance.collection('whoLikedMe');
  final chatCollection = FirebaseFirestore.instance.collection('chats');
  final storylineCollection =
      FirebaseFirestore.instance.collection('storyline');
  final feedbackCollection = FirebaseFirestore.instance.collection('feedback');
  final reportCollection = FirebaseFirestore.instance.collection('report');
  final notificationCollection =
      FirebaseFirestore.instance.collection('notification');
  final transsctionHistoryCollection =
      FirebaseFirestore.instance.collection('transaction_history');
  final friendCollection = FirebaseFirestore.instance.collection('friends');
  final firebaseStorage = FirebaseStorage.instance;

  Future<void> updateUserData(BuildContext context,
      {Map<String, Object?>? data, Widget? route, bool mounted = true}) async {
    CustomProgressDialog progressDialog = CustomProgressDialog(context,
        blur: 2, loadingWidget: const CustomLoader(), dismissable: false);

    try {
      progressDialog.show();
      final uid = firebaseInstance.currentUser!.uid;
      await userCollection.doc(uid).update(data!).then((value) {
        if (!mounted) return;
        progressDialog.dismiss();
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => route!),
        );
      }).catchError((error) {
        progressDialog.dismiss();
        flushbar(
            context: context,
            title: 'Error',
            message: error.toString(),
            isSuccess: false);
      });
    } catch (e) {
      progressDialog.dismiss();
      flushbar(
          context: context,
          title: 'Error',
          message: e.toString(),
          isSuccess: false);
    }
  }

  String? amountValidator(String? value) {
    if (value!.trim().isEmpty) {
      return 'Field required';
    } else if (value == '0' || value[0]=='0') {
      return 'Amount must be more than 0';
    } else if (value.contains(RegExp(r'[A-Z]'))) {
      return 'Invalid amount';
    } else if (value.contains(RegExp(r'[a-z]'))) {
      return 'Invalid amount';
    } else if (value.contains(RegExp(r'[#?!@$%^&*;:<>$^~`./_\\],'))) {
      return 'Invalid amount';
    } else {
      return null;
    }
  }
}
