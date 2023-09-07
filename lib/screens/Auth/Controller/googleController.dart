import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wedme1/provider/firestoreprovider.dart';

import '../../../constants/utils.dart';
import '../../../models/userModel.dart';
import '../../../provider/profileprovider.dart';
import '../services/AuthMethods.dart';

final userProvider = StateProvider<UserModel?>((ref) {
  return;
});

//   final firestore = ref.read(firestoreProvider);
//   final auth = ref.read(authProvider);

//   final profile = ProfileRepository(firestore, auth.currentUser?.uid ?? "");

//   return await profile.getProfile();


final authControllerProvider = StateNotifierProvider<AuthController, bool>(
    (ref) => AuthController(
        authRepository: ref.watch(authRepositoryProvider), ref: ref));

final authStateChangeProvider = StreamProvider((ref) {
  final authController = ref.watch(authControllerProvider.notifier);
  return authController.authStateChange;
});

final getUserDataProvider = StreamProvider.family((ref, String uid) {
  final authController = ref.watch(authControllerProvider.notifier);
  return authController.getUserData(uid);
});
final userDataAuthProvider = FutureProvider((ref) {
  final authController = ref.watch(authControllerProvider.notifier);
  return authController.getUserDatas();
});

class AuthController extends StateNotifier<bool> {
  final Ref _ref;
  final AuthRepository _authRepository;

  AuthController({required Ref ref, required AuthRepository authRepository})
      : _authRepository = authRepository,
        _ref = ref,
        super(false);

  Stream<User?> get authStateChange => _authRepository.authStateChange;

  void signInWithGoogle(BuildContext context) async {
    state = true;
    final user = await _authRepository.signInWithGoogle();
    state = false;
    user.fold(
      (l) => showSnackBar(context, l.message),
      (userModel) =>
          _ref.read(userProvider.notifier).update((state) => userModel),
    );
  }

  void signInWithFacebook(BuildContext context) async {
    state = true;
    final user = await _authRepository.signInWithFacebook();
    state = false;
    user.fold(
      (l) => showSnackBar(context, l.message),
      (userModel) =>
          _ref.read(userProvider.notifier).update((state) => userModel),
    );
  }

  void signInWithPhone(BuildContext context, String phoneNumber) {
    // _authRepository.signInWithPhone(context, phoneNumber);
  }

  void verifyOTP(BuildContext context, String verificationId, String userOTP) {
    _authRepository.verifyOTP(
      context: context,
      verificationId: verificationId,
      userOTP: userOTP,
    );
  }

  Stream<UserModel> getUserData(String uid) {
    return _authRepository.getUserData(uid);
  }

  void setUserState(bool isOnline) {
    _authRepository.setUserState(isOnline);
  }

  Future<UserModel?> getUserDatas() async {
    UserModel? user = await _authRepository.getCurrentUserData();
    return user;
  }

  void logout() async {
    _authRepository.logOut();
  }
}
