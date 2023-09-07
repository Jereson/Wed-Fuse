import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';

import 'histroy_transcation_class.dart';

class TransHisModel extends StreamViewModel {
  String formatDate(DateTime date) {
    final dayOfWeek = DateFormat('EEEE').format(date);
    final dayOfMonth = DateFormat('d').format(date);
    final month = DateFormat('MMMM').format(date);
    final hour = DateFormat('h').format(date);
    final minute = DateFormat('mm').format(date);
    final amPm = DateFormat('a').format(date);
    final suffix = _getNumberSuffix(int.parse(dayOfMonth));

    return '$dayOfWeek, $dayOfMonth$suffix $month - $hour:$minute$amPm';
  }

  String _getNumberSuffix(int dayOfMonth) {
    if (dayOfMonth >= 11 && dayOfMonth <= 13) {
      return 'th';
    }
    switch (dayOfMonth % 10) {
      case 1:
        return 'st';
      case 2:
        return 'nd';
      case 3:
        return 'rd';
      default:
        return 'th';
    }
  }

  String formattedDate = "";

  void initializeDateFormat() {
    final now = DateTime.now();
    formattedDate = formatDate(now);
    print(formattedDate); // Output: "Wednesday, 5th May - 3:25pm"
  }

  final List<TransHis> _transList = [];



  var firebaseTransHistory = FirebaseFirestore.instance
      .collection("transaction_history")
      .doc(FirebaseAuth.instance.currentUser?.uid)
      .collection("history");

  List<TransHis> get transList => _transList;

  @override
  Stream<List<TransHis>> get stream => getDe();

  Future<void> createTrans({
    required String price,
     String? friendId,
     String? status,
     required String type,
  }) async {
    initializeDateFormat(); // Initialize formattedDate before creating a transaction

    var id = DateTime.now().millisecondsSinceEpoch.toString();
    var trans = TransHis(
      time: formattedDate,
      price: price,
      id: id,
      userId: FirebaseAuth.instance.currentUser!.uid,
      amount: "200",
      createAt: formattedDate,
      friendId: friendId,
      status: status,
      type: type
    );

    await firebaseTransHistory.doc(id).set({
      "id": trans.id,
      "coin":trans.price,
      "amount":trans.price,
      "userId":FirebaseAuth.instance.currentUser!.uid,
      "createAt":"${DateTime.now()}",
      "friendId":trans.friendId,
      "time":trans.time,
      "status":trans.status,
      "type":trans.title
    });
  }

  Stream<List<TransHis>> getDe() {
    return firebaseTransHistory.snapshots().map((event) {
      _transList.clear();
      for (var doc in event.docs) {
        _transList.add(TransHis.fromJson(doc.data()));
      }
      return _transList;
    });
  }
}
