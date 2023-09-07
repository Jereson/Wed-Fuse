import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:routemaster/routemaster.dart';

import '../../../constants/utils.dart';
import '../../../models/userModel.dart';

import '../../../provider/Storageprovider.dart';
import '../../Auth/Controller/googleController.dart';
import '../profileRepository/profileRepository.dart';

final userProfileProvider = StreamProvider((ref) {
  final userProfileController = ref.watch(userProfileControllerProvider.notifier);
  return userProfileController.getUsers();
});

final userProfileControllerProvider = StateNotifierProvider<UserProfileController, bool>((ref) {
  final userProfileRepository = ref.watch(userProfileRepositoryProvider);
  final storageRepository = ref.watch(storageRepositoryProvider);
  return UserProfileController(
    userProfileRepository: userProfileRepository,
    storageRepository: storageRepository,
    ref: ref,
  );
});

final searchUserProvider = StreamProvider.family((ref, String query) {
  return ref.watch(userProfileControllerProvider.notifier).searchUser(query);
});

class UserProfileController extends StateNotifier<bool> {
  final UserProfileRepository _userProfileRepository;
  final Ref _ref;
  final StorageRepository _storageRepository;
  UserProfileController({
    required UserProfileRepository userProfileRepository,
    required Ref ref,
    required StorageRepository storageRepository,
  })  : _userProfileRepository = userProfileRepository,
        _ref = ref,
        _storageRepository = storageRepository,
        super(false);

  void editProfiles({
    required File? profileFile,
    required BuildContext context,
    required String name,
    required String aboutMe,
    required String course,
    required String love,
    required String location,
    required String marriageReadyNess,
    required String religion,
    required String genotype,
    required String temperament,
    required String choice,

  }) async {
    state = true;
    UserModel user = _ref.read(userProvider)!;

    if (profileFile != null ) {
      final res = await _storageRepository.storeFile(
        path: 'users/profile',
        id: user.userId!,
        file: profileFile,

      );
     
    }



   
    final res = await _userProfileRepository.editProfile(user);
    state = false;
    res.fold(
          (l) => showSnackBar(context, l.message),
          (r) {
        _ref.read(userProvider.notifier).update((state) => user);
        Routemaster.of(context).pop();
      },
    );
  }



  Stream<List<UserModel>> getUsers() {
    return _userProfileRepository.getUsers();
  }

  Stream<List<UserModel>> searchUser(String query) {
    return _userProfileRepository.searchUser(query);
  }

  void editlocation({required double lat, required double long, required BuildContext context}) {}
}