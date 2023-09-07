

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_provider2/country_provider2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:stacked/stacked.dart';

import '../users_detail_model.dart';
class UsersModel extends BaseViewModel {

  UsersDetailModel? userAccount;



  dsNow() {
    FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      userAccount = UsersDetailModel.fromJson(value.data()!);
      notifyListeners();
    });
  }
}


