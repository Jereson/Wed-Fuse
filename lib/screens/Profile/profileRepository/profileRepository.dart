import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

import '../../../constants/failure.dart';
import '../../../constants/firebaseContants.dart';
import '../../../constants/type_defs.dart';
import '../../../models/userModel.dart';
import '../../../provider/firestoreprovider.dart';

final userProfileRepositoryProvider = Provider((ref) {
  return UserProfileRepository(firestore: ref.watch(firestoreProvider));
});

class UserProfileRepository {
  final FirebaseFirestore _firestore;
  UserProfileRepository({required FirebaseFirestore firestore}) : _firestore = firestore;

  CollectionReference get _users => _firestore.collection(FirebaseConstants.usersCollection);


  FutureVoid editProfile(UserModel user) async {
    try {
      return right(_users.doc(user.userId).update(user.toJson()));
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  Stream<List<UserModel>> getUsers() {
    return _users
        .snapshots()
        .map(
          (event) => event.docs
          .map(
            (e) => UserModel.fromJson(
          e.data() as Map<String, dynamic>,
        ),
      )
          .toList(),
    );
  }

  Stream<List<UserModel>> searchUser(String query) {
    return _users
        .where(
      'name',
      isGreaterThanOrEqualTo: query.isEmpty ? 0 : query,
      isLessThan: query.isEmpty
          ? null
          : query.substring(0, query.length - 1) +
          String.fromCharCode(
            query.codeUnitAt(query.length - 1) + 1,
          ),
    )
        .snapshots()
        .map((event) {
      List<UserModel> users = [];
      for (var user in event.docs) {
        users.add(UserModel.fromJson(user.data() as Map<String, dynamic>));
      }
      return users;
    });
  }



}