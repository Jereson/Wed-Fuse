import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ndialog/ndialog.dart';
import 'package:random_string/random_string.dart';
import 'package:wedme1/getit.dart';
import 'package:wedme1/models/friends_model.dart';
import 'package:wedme1/models/like_model.dart';
import 'package:wedme1/models/notification_model.dart';
import 'package:wedme1/services/auth_service.dart';
import 'package:wedme1/utils/flushbar_widget.dart';
import 'package:wedme1/viewModel/base_view_model.dart';
import 'package:wedme1/viewModel/profile_vm.dart';
import 'package:wedme1/widget/custom_loader.dart';

class UserReactionVm extends BaseViewModel {
  bool isLikeAnimate = false;
  bool isUnlikeAnimate = false;
  bool isStorylineAnimate = false;
  LikeModel? likeModel;
  LikeModel? whoLikedMeModel;
  List<LikeModel> myMatchList = [];
  List<LikeModel> whoLikedMeList = [];
  bool isLikeGrid = false;

  bool isWhoLikeMeLoading = false;
  bool isMyMatchLoading = false;

  bool hasChatedBefore = false;

  String? userChatId;

  TextEditingController chatController = TextEditingController();

  List<NotificationModel> notificationModel = [];
  bool notificationLoaded = false;

  List<FriendsModel> friendsModel = [];
  FriendsModel? myFriends;
  bool isFriendLoaded = false;

  bool isFriendRequestSent = false;

  setIslikeGridView() {
    isLikeGrid = !isLikeGrid;
    setState();
  }

  Future<void> likeUser({
   required String? likedUid,
  required  String? likedPhotoUrl,
  required  String? likedUserName,
  required  num? likedLat,
   required num? likedLng,
  required  num? likedAge,
  required  String? likedCity,
   required bool isVerified

  }) async {
    //Animte like icon
    animateLike();
    final user = firebaseInstance.currentUser;

    final whoIlikeCol =
        whoILikeCollection.doc(user!.uid).collection('likes').doc(likedUid);
    final myDoc = await whoIlikeCol.get();

    if (!myDoc.exists) {
      final userColl = userCollection.doc(user.uid);
      final doc = await userColl.get();

      //Add user to my like doc
      await whoIlikeCol.set({
        'uid': likedUid,
        'photoUrl': likedPhotoUrl,
        'userName': likedUserName,
        'lat': likedLat,
        'lng': likedLng,
        'age': likedAge,
        'city': likedCity,
        'isVerified':isVerified
      });

//Notify the liked user
      final whoLikedMe =
          whoLikeMeCollection.doc(likedUid).collection('likes').doc(user.uid);
      await whoLikedMe.set({
        'uid': user.uid,
        'photoUrl': doc.data()!['photoUrl'],
        'userName': doc.data()!['displayName'],
        'lat': doc.data()!['lat'],
        'lng': doc.data()!['lng'],
        'age': doc.data()!['age'],
        'city': doc.data()!['city'],
        'isVerified': doc.data()!['isVerified']
      });
    }
  }

  Future<void> dislikeUser(String otherUid) async {
    animateUnlike();
    final uid = firebaseInstance.currentUser!.uid;
    final userColl = userCollection.doc(uid);
    final doc = await userColl.get();

    List<dynamic> dislike = await doc.data()!['dislike'];
    List<dynamic> like = await doc.data()!['like'];

    if (!dislike.contains(otherUid)) {
      await userColl.update({
        'dislike': FieldValue.arrayUnion([otherUid])
      });

      if (like.contains(otherUid)) {
        await userColl.update({
          'like': FieldValue.arrayRemove([otherUid])
        });
      }
    }
  }

  Future<void> chatUser({
    required String? receiverId,
    required String? message,
    String? chatId,
    String? messageId,
    required String? receiverPhotoUlr,
    required String? chatType,
  }) async {
    // String generateChatId = randomAlphaNumeric(14);
    final user = firebaseInstance.currentUser;
    String generateChatId1 = user!.uid + receiverId!;
    // final messageId = randomAlphaNumeric(14);
    final messageId = DateTime.now().millisecondsSinceEpoch.toString();
    // String generateChatId2 = receiverId + user.uid;

    // final collection =
    //     chatCollection.where('usersId', arrayContains: [user.uid, receiverId]);

    // final collection1 = chatCollection.doc(generateChatId1);
    // final collection2 = chatCollection.doc(generateChatId2);
    // final doc = await collection1.get();

    if (chatId == 'no chatid') {
      print('Chat already exist');
      await chatCollection
          .doc(generateChatId1)
          .collection('message')
          .doc(messageId)
          .set({
        'chatId': generateChatId1,
        'messageId': messageId,
        // 'usersId': [user.uid, receiverId],
        'senderId': user.uid,
        'receiverId': receiverId,
        'receiverPhotoUlr': receiverPhotoUlr,
        'chatsBody': [
          {
            'sender': user.uid,
            'receiver': receiverId,
            'date': DateTime.now(),
            'message': message,
            'chatType': chatType //text, voice,
          }
        ]
      });
      userChatId = generateChatId1;
      setState();
    } else {
      print('Chat already already exist');
      await chatCollection
          .doc(chatId)
          .collection('message')
          .doc(messageId)
          .update({
        'chatsBody': FieldValue.arrayUnion([
          {
            'sender': user.uid,
            'receiver': receiverId,
            'date': DateTime.now(),
            'message': message,
            'chatType': chatType
          }
        ])
      });
    }
  }

  Future<String> getChatID(String receiverId) async {
    final uid = firebaseInstance.currentUser!.uid;
    String chatId1 = uid + receiverId;
    String chatId2 = receiverId + uid;

    var snapshot1 = await chatCollection.doc(chatId1).get();

    var snapshot2 = await chatCollection.doc(chatId2).get();
    if (snapshot1.exists) {
      userChatId = snapshot1.id;
      setState();
    } else if (snapshot2.exists) {
      userChatId = snapshot2.id;
      setState();
    } else {
      userChatId = 'no chatid';
      setState();
    }
    return userChatId!;
  }

  Stream<QuerySnapshot> getChatById(String id) {
    return chatCollection.doc(id).collection('message').snapshots();
  }

  animateLike() {
    isLikeAnimate = true;
    setState();
    Timer(const Duration(milliseconds: 500), () {
      isLikeAnimate = false;
      setState();
    });
  }

  animateUnlike() {
    isUnlikeAnimate = true;
    setState();
    Timer(const Duration(milliseconds: 500), () {
      isUnlikeAnimate = false;
      setState();
    });
  }

  animateSotrylineLike() {
    isStorylineAnimate = true;
    setState();
    Timer(const Duration(milliseconds: 500), () {
      isStorylineAnimate = false;
      setState();
    });
  }

  Stream<QuerySnapshot> getStoryline(String userId) {
    final stream = storylineCollection.doc(userId).collection('myStoryline');

    return stream.snapshots(includeMetadataChanges: true);
  }

  Future<void> storylineViewCount(String userId, String docId) async {
    final currentUserId = firebaseInstance.currentUser!.uid;
    final doc =
        storylineCollection.doc(userId).collection('myStoryline').doc(docId);
    final getDoc = await doc.get();
    List<dynamic> viewedList = getDoc.data()!['viewedList'];

    if (!viewedList.contains(userId)) {
      doc.update({
        'viewCount': FieldValue.increment(1),
        'viewedList': FieldValue.arrayUnion([currentUserId])
      });
    } else {
      print('Storyline already viewed');
    }
  }

  Future<void> likeStolyline(String userId, String docId) async {
    animateSotrylineLike();
    final currentUserId = firebaseInstance.currentUser!.uid;
    final doc =
        storylineCollection.doc(userId).collection('myStoryline').doc(docId);
    final getDoc = await doc.get();
    List<dynamic> like = getDoc.data()!['like'];

    if (!like.contains(userId)) {
      doc.update({
        'like': FieldValue.arrayUnion([currentUserId])
      });
    } else {
      print('Storyline already likes');
    }
  }

  // Stream<QuerySnapshot> getWhoLike() {
  //   final uid = firebaseInstance.currentUser!.uid;
  //   final whoILike =
  //       whoILikeCollection.doc(uid).collection('likes').snapshots();
  //   // whoILike.first[]{}

  //   return whoILike;
  // }

  Future<List<LikeModel>> getWhoILike() async {
    final uid = firebaseInstance.currentUser!.uid;
    isMyMatchLoading = false;
    final collection =
        whoILikeCollection.doc(uid).collection('likes').get().then((value) {
      isMyMatchLoading = true;
      setState();
      myMatchList = [];
      for (var doc in value.docs) {
        likeModel = LikeModel.fromJson(doc.data());
        myMatchList.add(likeModel!);
        setState();
      }

      return myMatchList;
    });

    return collection;
  }

  Future<List<LikeModel>> getWhoLikedMe() async {
    final uid = firebaseInstance.currentUser!.uid;
    isWhoLikeMeLoading = false;
    // setState();
    final collection = await whoLikeMeCollection
        .doc(uid)
        .collection('likes')
        .get()
        .then((value) {
      whoLikedMeList = [];
      isWhoLikeMeLoading = true;
      setState();
      for (var doc in value.docs) {
        whoLikedMeModel = LikeModel.fromJson(doc.data());
        whoLikedMeList.add(whoLikedMeModel!);

        setState();
      }

      return whoLikedMeList;
    });
    return collection;
  }

  Future<void> inviteFriend(BuildContext context,
      {required String userId,
      required String fcbToken,
      required String receiverName,
      required String receiverPhoto,
      required String receiverPhone}) async {
    isFriendRequestSent = true;
    setState();
    final cachedUser = getIt.get<ProfileViewModel>().cachedUserDetail;
    final noticeId = randomAlphaNumeric(14);
    final date = DateTime.now();
    await notificationCollection.doc(noticeId).set({
      'id': noticeId,
      'senderId': cachedUser!.userId,
      'userId': userId,
      'type': 'friendRequest', //friendReuest, weddingInvite, giftCoin
      'status': 'Pending', //Pending, Accepted,Rejected,
      'userName': cachedUser.fullName!.split(' ').first,
      'message': 'Sent you a friend request',
      'date': '$date',
      'image': cachedUser.photoUrl
    }).then((value) async {
      await AuthServics().sendFCM(fcbToken, 'Friend Request',
          '${cachedUser.fullName!.split(' ').first} sent you a friend request');
      //Create firend collection
      //Add the both user id to list
      await friendCollection.doc(noticeId).set({
        'id': noticeId,
        'member': [cachedUser.userId, userId],
        'senderId': firebaseInstance.currentUser!.uid,
        'senderName': cachedUser.fullName!.split(' ').first,
        'senderPhoto': cachedUser.photoUrl,
        'senderPhone': cachedUser.phoneNumber,
        'receiverId': userId,
        'receiverName': receiverName,
        'receiverPhoto': receiverPhoto,
        'receiverPhone': receiverPhone,
        'status': 'Pending', //Pending, Accepted,Rejected,
        'date': '$date',
      });

      //Update the two user invite list
      await userCollection.doc(firebaseInstance.currentUser!.uid).update({
        'inviteList': FieldValue.arrayUnion([userId])
      });
      await userCollection.doc(userId).update({
        'inviteList': FieldValue.arrayUnion([firebaseInstance.currentUser!.uid])
      });

      if (context.mounted) {
        flushbar(
            context: context,
            title: '',
            message: 'Friend request sent',
            isSuccess: true);
      }
    });
  }

  Future<void> getMyFriends() async {
    await friendCollection
        .where('member', arrayContainsAny: [firebaseInstance.currentUser!.uid])
        .where('status', isEqualTo: 'Accepted')
        .get()
        .then((value) {
          isFriendLoaded = true;
          print('Getting friend 1 $isFriendLoaded');
          setState();
          if (value.docs.isNotEmpty) {
            friendsModel = [];
            for (var doc in value.docs) {
              myFriends = FriendsModel.fromJson(doc.data());
              friendsModel.add(myFriends!);
            }
            setState();
          }
        });
        
    isFriendLoaded = true;
           
    setState();
  }

  Future<void> getUserNotification() async {
    await notificationCollection
        .where('userId', isEqualTo: firebaseInstance.currentUser!.uid)
        .get()
        .then((value) {
      if (value.docChanges.isNotEmpty) {
        notificationModel = [];

        for (var doc in value.docs) {
          final notificationData = NotificationModel.fromJson(doc.data());
          notificationModel.insert(0, notificationData);
        }
      }

      notificationModel.reversed.toList();

      // print(notificationModel.reversed);
      notificationLoaded = true;
      setState();
    });
  }

  Future<void> acceptRequest(
      BuildContext context, String userId, String notificationId,
      [bool mounted = true]) async {
    CustomProgressDialog progressDialog = CustomProgressDialog(context,
        blur: 2, loadingWidget: const CustomLoader(), dismissable: false);
    //pending, Accepted,rejected

    progressDialog.show();
    await userCollection.doc(firebaseInstance.currentUser!.uid).update({
      'friends': FieldValue.arrayUnion([userId])
    }).then((value) async {
      await userCollection.doc(userId).update({
        'friends': FieldValue.arrayUnion([firebaseInstance.currentUser!.uid])
      });
      await friendCollection.doc(notificationId).update({'status': 'Accepted'});

      await notificationCollection
          .doc(notificationId)
          .update({'status': 'Accepted'});
      await getUserNotification();
      if (!mounted) return;
      progressDialog.dismiss();
      flushbar(
          context: context,
          title: 'Accepted',
          message: 'Friend request accepted successfully',
          isSuccess: true);
    }).catchError((onError) {
      if (!mounted) return;
      progressDialog.dismiss();
      flushbar(
          context: context,
          title: 'Error',
          message: 'Error occured',
          isSuccess: false);
    });
  }

  Future<void> rejectRequest(
      BuildContext context, String userId, String notificationId,
      [bool mounted = true]) async {
    CustomProgressDialog progressDialog = CustomProgressDialog(context,
        blur: 2, loadingWidget: const CustomLoader(), dismissable: false);
    //pending, Accepted,rejected

    progressDialog.show();
    await userCollection.doc(firebaseInstance.currentUser!.uid).update({
      'friends': FieldValue.arrayRemove([userId])
    }).then((value) async {
      await userCollection.doc(userId).update({
        'friends': FieldValue.arrayRemove([firebaseInstance.currentUser!.uid])
      });

      await friendCollection.doc(notificationId).update({'status': 'Rejected'});

      await notificationCollection
          .doc(notificationId)
          .update({'status': 'Rejected'});
      await getUserNotification();
      if (!mounted) return;
      progressDialog.dismiss();
      flushbar(
          context: context,
          title: 'Accepted',
          message: 'Friend request rejected successfully',
          isSuccess: true);
    }).catchError((onError) {
      if (!mounted) return;
      progressDialog.dismiss();
      flushbar(
          context: context,
          title: 'Error',
          message: 'Error occured',
          isSuccess: false);
    });
  }
}


