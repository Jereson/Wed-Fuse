import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:get/get.dart';
import 'choose_account_class.dart';

class ChooseAccountModel extends StreamViewModel {
  final List<ChooseAccountClass> _accountDetails = [];

  var firebaseTransHistory = FirebaseFirestore.instance
      .collection("user_bank_account")
      .doc(FirebaseAuth.instance.currentUser?.uid)
      .collection("account");

  addBankAccount({
    required String bankName,
    required String accountNumber,
    required String accountName,
    required BuildContext context,
  }) {
    var bankDetails = ChooseAccountClass(
        bankName: bankName,
        accountNumber: accountNumber,
        accountName: accountName,
        id: DateTime.now().millisecond.toString(),
        userId: FirebaseAuth.instance.currentUser!.uid);
    firebaseTransHistory.add({
      "bankName": bankDetails.bankName,
      "accountNumber": bankDetails.accountNumber,
      "accountName": bankDetails.accountName,
      "id": bankDetails.id,
      "userId": bankDetails.userId,
    }).then((value) {
      Navigator.pop(context);
    });
  }

  transactionHisForWithdrawal(
      {required String amount,
      required String bankName,
      required String accountNumber,
      required String amountWithdraw,
      required num newCoinBalance,
      required BuildContext context,
      required String accountName}) {
    FirebaseFirestore.instance
        .collection("withdrawal")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("withdrawal_list")
        .add({
      "bank_name": bankName,
      "account_number": accountNumber,
      "account_name": accountName,
      "amount_withdraw":amountWithdraw,
      "id": DateTime.now().millisecond.toString(),
      "type": "Withdrawal",

    }).then((value) {
      FirebaseFirestore.instance
          .collection("transaction_history")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("history")
          .add({
        "amount": amount,
        "coin": "",
        "creatdAt": DateTime.now().toString(),
        "friendId": "",
        "id": DateTime.now().millisecond.toString(),
        "status": "pending",
        "type": "Withdrawal",
        "userId": FirebaseAuth.instance.currentUser!.uid
      }).then((value) {
        FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).update({
          "coinBalance":newCoinBalance
        });
      }).then((value) {
        Navigator.pop(context);
      });
    });
  }

  List<ChooseAccountClass> get accountDetails => _accountDetails;

  @override
  Stream<List<ChooseAccountClass>> get stream => getDe();

  Future<void> createAccount({
    required String bankName,
    required String accountNumber,
    required String accountName,
  }) async {
    var id = DateTime.now().millisecondsSinceEpoch.toString();
    var account = ChooseAccountClass(
        bankName: bankName,
        accountNumber: accountNumber,
        accountName: accountName,
        id: id,
        userId: FirebaseAuth.instance.currentUser!.uid);
    await firebaseTransHistory.doc(id).set({
      "id": account.id,
      "bankName": account.bankName,
      "userId": FirebaseAuth.instance.currentUser!.uid,
      "accountName": account.accountName,
      "accountNumber": account.accountNumber,
    });
  }

  Stream<List<ChooseAccountClass>> getDe() {
    return firebaseTransHistory.snapshots().map((event) {
      _accountDetails.clear();
      for (var doc in event.docs) {
        _accountDetails.add(ChooseAccountClass.fromJson(doc.data()));
      }
      return _accountDetails;
    });
  }
}
