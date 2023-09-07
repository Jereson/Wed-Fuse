import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ndialog/ndialog.dart';
import 'package:random_string/random_string.dart';
import 'package:wedme1/getit.dart';
import 'package:wedme1/models/friends_model.dart';
import 'package:wedme1/models/initiate_payment_model.dart';
import 'package:wedme1/models/transaction_history_model.dart';
import 'package:wedme1/models/users_detail_model.dart';
import 'package:wedme1/screens/Profile/wallet/payment_screen.dart';
import 'package:wedme1/services/auth_service.dart';
import 'package:wedme1/utils/constant_utils.dart';
import 'package:wedme1/utils/flushbar_widget.dart';
import 'package:wedme1/viewModel/base_view_model.dart';
import 'package:wedme1/widget/custom_loader.dart';

class WalletVm extends BaseViewModel {
  FriendsModel? myFriends;
  String? gitftingAMount;
  String? buyAmountInUSD;
  double? convertedAmountInNaria;
  UsersDetailModel? userDetail;
  String? generateTxRef;

  InitiatePaymentModel? initatiatePaymentResponse;

  final giftingAmountController = TextEditingController();
  final giftingFriendController = TextEditingController();

  final buyCoinAmountController = TextEditingController();

  String? recievingCoinFrindId;

  String? subscriptionType;
  int? premiumMonthType;
  int? subDays;
  String? subAmount;

  List<TransactionHistoryModel> transactionHistoryModel = [];
  bool isTxnHistryLoaded = false;

  setSelectedFriend(FriendsModel friend) {
    myFriends = friend;

    giftingFriendController.text =
        firebaseInstance.currentUser!.uid == myFriends!.senderId
            ? myFriends!.receiverName!
            : myFriends!.senderName!;

    recievingCoinFrindId =
        firebaseInstance.currentUser!.uid == myFriends!.senderId
            ? myFriends!.receiverId!
            : myFriends!.senderId!;
    setState();
  }

  convertGitfCoinOnChange() {
    if (giftingAmountController.text.isNotEmpty) {
      final convertAmount =
          num.tryParse(giftingAmountController.text)! * coinEquivalent;
      gitftingAMount = convertAmount.toStringAsFixed(2);
      setState();
    } else {
      gitftingAMount = null;
      setState();
    }
  }

  convertBuyAmoingOnChange() {
    if (buyCoinAmountController.text.isNotEmpty) {
      final convertAmount =
          num.tryParse(buyCoinAmountController.text)! * coinEquivalent;
      buyAmountInUSD = convertAmount.toStringAsFixed(2);
      setState();
    } else {
      buyAmountInUSD = null;
      setState();
    }
  }

  Future<void> getUserDetail() async {
    final uid = firebaseInstance.currentUser!.uid;
    await userCollection.doc(uid).get().then((value) {
      if (value.exists) {
        userDetail = UsersDetailModel.fromJson(value.data()!);
        setState();
      }
    }).catchError((err) {
      // print('The error ${err.toString()}');
    });
  }

  Future<void> giftCoinToFriend(BuildContext context) async {
    // print('The friend id $frinedId');

    final coinBalace = userDetail!.coinBalance!;
    final amount = num.tryParse(giftingAmountController.text);
    if (giftingAmountController.text.isNotEmpty && (coinBalace > amount!)) {
      final uid = firebaseInstance.currentUser!.uid;
      //Gift user
      final subtractMyCoin = coinBalace - amount;
//Gifting status == Pending, Completed, Refunded
      String generateHistoryId = randomAlphaNumeric(13);

      // print('The gifting: original balance $coinBalace');
      // print('The gifting: new balance $subtractMyCoin');
      // print('The gifting: amount to give $amount');
      // print('The gifting: amount to give $amount');

//Subtract gifting amoung from gifting user
      await userCollection
          .doc(uid)
          .update({'coinBalance': subtractMyCoin})
          .showCustomProgressDialog(context)
          .then(
            (value) async {
              //Gifting user
              await userCollection.doc(recievingCoinFrindId).update({
                'coinBalance': FieldValue.increment(
                    num.parse(giftingAmountController.text))
              }).then((value) async {
                //After transaction successul
                //Update history with completed
                await transsctionHistoryCollection
                    .doc(uid)
                    .collection('history')
                    .doc(generateHistoryId)
                    .set({
                  'id': generateHistoryId,
                  'coin': giftingAmountController.text,
                  'amount': gitftingAMount,
                  'userId': uid,
                  'friendId': recievingCoinFrindId,
                  'type': 'Gift',
                  'status': 'Completed',
                  'creatdAt': '${DateTime.now()}'
                }).then((value) async {
                  await getUserDetail();
                  if (context.mounted) {
                    flushbar(
                        context: context,
                        title: 'Success',
                        message: 'You have gifted a friend successfully',
                        isSuccess: true);
                  }

                  giftingAmountController.clear();
                  gitftingAMount = null;
                  setState();
                });
              }).catchError(
                (err) async {
                  //If gifting failed, return the amount to the gifting user
                  await userCollection.doc(uid).update({
                    'coinBalance': '$coinBalace',
                  }).then((value) {
                    flushbar(
                        context: context,
                        title: 'Error',
                        message: 'Gifting failed, try again',
                        isSuccess: false);
                  }).catchError(
                    (onError) async {
                      //Id refund faied history to pending
                      await transsctionHistoryCollection
                          .doc(uid)
                          .collection('history')
                          .doc(generateHistoryId)
                          .set({
                        'id': generateHistoryId,
                        'coin': giftingAmountController.text,
                        'amount': gitftingAMount,
                        'userId': uid,
                        'friendId': recievingCoinFrindId,
                        'type': 'Gift',
                        'status': 'Pending',
                        'creatdAt': '${DateTime.now()}'
                      }).then(
                        (value) => flushbar(
                            context: context,
                            title: 'Error',
                            message:
                                'Could not complete the gifting, please contact the admin',
                            isSuccess: false),
                      );
                    },
                  );
                },
              );
            },
          )
          .catchError((error) => flushbar(
              context: context,
              title: 'Error occured',
              message: error.toString(),
              isSuccess: false));

      giftingFriendController.clear();
      recievingCoinFrindId = null;
      setState();
      return;
    }

    flushbar(
        context: context,
        title: 'Insufficient Wallet',
        message: 'You have insufficient wallet balance to gift a friend',
        isSuccess: false);
  }

  // Future<void> convertCurrency(BuildContext context) async {
  //   CustomProgressDialog progressDialog = CustomProgressDialog(context,
  //       blur: 2, loadingWidget: const CustomLoader(), dismissable: false);

  //   progressDialog.show();
  //   final result =
  //       await getIt.get<AuthServics>().convertCurrency(buyAmountInUSD!);

  //   if (context.mounted) {
  //     if (result is CurrencyConversionModel) {
  //       convertedAmountInNaria = result.result! * 100;
  //       setState();

  //       initiatePayment(context);
  //     } else {
  //       progressDialog.dismiss();
  //       flushbar(
  //           context: context,
  //           title: 'Failed',
  //           message: 'Could not initiate transaction',
  //           isSuccess: false);
  //     }
  //   }
  // }

  Future<void> initiatePayment(
      BuildContext context, String amount, String source) async {
    CustomProgressDialog progressDialog = CustomProgressDialog(context,
        blur: 2, loadingWidget: const CustomLoader(), dismissable: false);
//'$convertedAmountInNaria',
    progressDialog.show();
    generateTxRef = randomAlphaNumeric(13);
    setState();
    // print('The generated payment Id $generateTxRef');
    final result = await getIt.get<AuthServics>().initiatePayment(
        // amount: '$buyAmountInUSD',
        amount: amount,
        userId: userDetail!.userId!,
        email: userDetail!.email!,
        phone: userDetail!.phoneNumber!,
        name: userDetail!.fullName!,
        generateTxRef: generateTxRef!);
    progressDialog.dismiss();

    if (context.mounted) {
      if (result is InitiatePaymentModel) {
        initatiatePaymentResponse = result;
        setState();

        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => PaymentScreen(
                  source: source,
                )));
      } else {
        progressDialog.dismiss();
        flushbar(
            context: context,
            title: 'Failed',
            message: 'Could not initiate transaction',
            isSuccess: false);
      }
    }
  }

  Future<void> topupUserCoin(BuildContext context) async {
    final uid = firebaseInstance.currentUser!.uid;
    String generateHistoryId = randomAlphaNumeric(13);
    await userCollection
        .doc(uid)
        .update({
          'coinBalance':
              FieldValue.increment(num.tryParse(buyCoinAmountController.text)!)
        })
        .showCustomProgressDialog(context)
        .then((value) async {
          await transsctionHistoryCollection
              .doc(uid)
              .collection('history')
              .doc(generateHistoryId)
              .set({
            'id': generateHistoryId,
            'coin': buyCoinAmountController.text,
            'amount': buyAmountInUSD,
            'userId': uid,
            'friendId': '',
            'type': 'BuyCoin',
            'status': 'Completed',
            'creatdAt': '${DateTime.now()}'
          });
          await getUserDetail();
          if (context.mounted) {
            Navigator.of(context).pop();
            flushbar(
                context: context,
                title: 'Success',
                message: 'Transation completed',
                isSuccess: true);
            buyAmountInUSD = null;
            buyCoinAmountController.clear();
            setState();
          }
        })
        .catchError((onError) async {
          Navigator.of(context).pop();
          flushbar(
              context: context,
              title: 'Error',
              message:
                  'Could not complete transaction, please contact the admin',
              isSuccess: false,
              duration: 10);
          await transsctionHistoryCollection
              .doc(uid)
              .collection('history')
              .doc(generateHistoryId)
              .set({
            'id': generateHistoryId,
            'coin': buyCoinAmountController.text,
            'amount': buyAmountInUSD,
            'userId': uid,
            'friendId': '',
            'type': 'BuyCoin',
            'status': 'Pending',
            'creatdAt': '${DateTime.now()}'
          });
        });
  }

  void setSubscriptionType(String sub) {
    subscriptionType = sub;

    setState();
  }

  void setPremiumMonthType(String amount, int days, int month) {
    premiumMonthType = month;
    subDays = days;
    subAmount = amount;

    setState();
  }

  void resetPremiumMonthType() {
    premiumMonthType = null;
    subDays = null;
    subAmount = null;
  }

  Future premiumSubscription(BuildContext context) async {
    final subsctiotionStartDate = DateTime.now();
    final subscriptionDueDate =
        subsctiotionStartDate.add(Duration(days: subDays!));

    final uid = firebaseInstance.currentUser!.uid;
    await userCollection
        .doc(uid)
        .update({
          "subscriptionDuration": '$premiumMonthType month',
          "subsctiotionStartDate": '$subsctiotionStartDate',
          "subscriptionDueDate": '$subscriptionDueDate',
          "subscriptionAmont": subAmount,
          "subscriptionType": subscriptionType,
          "currencyType": '\$',
          "isVerified": true,
        })
        .showCustomProgressDialog(context)
        .then((value) {
          Navigator.of(context).pop();
          flushbar(
              context: context,
              title: 'Success',
              message: 'Subscription successful',
              isSuccess: true);
        })
        .catchError((onError) {
          flushbar(
              context: context,
              title: 'Failed',
              message:
                  'Could not complete subscription, please contact Wedfuse',
              isSuccess: true);
        });
  }

  Future<void> getTransactionHistory() async {
    final uid = firebaseInstance.currentUser!.uid;
    await transsctionHistoryCollection
        .doc(uid)
        .collection('history')
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        transactionHistoryModel = [];
        for (var doc in value.docs) {
          final txn = TransactionHistoryModel.fromJson(doc.data());
          transactionHistoryModel.insert(0, txn);
        }
      }

      transactionHistoryModel.reversed.toList();
      isTxnHistryLoaded = true;
      setState();
    });
  }
}



// var now = new DateTime.now();
// var t = now.add(new Duration(days: 1));

// dt1.isBefore(dt2)
// dt1.compareTo(dt2)

//premium Type
//freemium
//premium
//proPremium


//subscriptionType
//subsctiotionSatrtDate
//subscriptionDueDate
//subscriptionAmont
//currencyType


