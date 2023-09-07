

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:stacked/stacked.dart';

import '../users_detail_model.dart';
class UsersModelFriend extends BaseViewModel {
  String friedId;

  UsersModelFriend({required this.friedId});

  UsersDetailModel? userAccount;


  dsNow() {
    FirebaseFirestore.instance
        .collection("users")
        .doc(friedId)
        .get()
        .then((value) {
      userAccount = UsersDetailModel.fromJson(value.data()!);
      notifyListeners();
    });
  }
}


