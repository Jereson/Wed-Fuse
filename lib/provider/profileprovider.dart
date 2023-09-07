import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wedme1/models/userModel.dart';

class ProfileRepository {
  final FirebaseFirestore _firebaseFirestore;
  final String userId;

  ProfileRepository(this._firebaseFirestore, this.userId);

  //TODO: UPDATE PROFILE

 
}
