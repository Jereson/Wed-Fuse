// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:ndialog/ndialog.dart';
// import 'package:wedme1/getit.dart';
// import 'package:wedme1/models/userModel.dart';
// import 'package:wedme1/screens/bio_data_screen.dart';
// import 'package:wedme1/screens/email_otp_screen.dart';
// import 'package:wedme1/screens/email_recovery_screen.dart';
// import 'package:wedme1/screens/phone_number_screen.dart';
// import 'package:wedme1/screens/preliminary/dashboard.dart';
// import 'package:wedme1/screens/preliminary/progress_loading_screen.dart';
// import 'package:wedme1/services/auth_service.dart';
// import 'package:wedme1/utils/constant_utils.dart';
// import 'package:wedme1/utils/error_code.dart';
// import 'package:wedme1/utils/flushbar_widget.dart';
// import 'package:wedme1/utils/response_utils.dart';
// import 'package:wedme1/viewModel/base_view_model.dart';
// import 'package:wedme1/widget/custom_loader.dart';
// import '../screens/Auth/screen/phone_no_otp_screen.dart';
// import '../screens/Profile/profile_screen/profile_screen.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ndialog/ndialog.dart';
import 'package:wedme1/getit.dart';
import 'package:wedme1/models/userModel.dart';
import 'package:wedme1/screens/bio_data_screen.dart';
import 'package:wedme1/screens/email_otp_screen.dart';
import 'package:wedme1/screens/email_recovery_screen.dart';
import 'package:wedme1/screens/phone_number_screen.dart';
import 'package:wedme1/screens/preliminary/dashboard.dart';
import 'package:wedme1/screens/preliminary/progress_loading_screen.dart';
import 'package:wedme1/services/auth_service.dart';
import 'package:wedme1/utils/constant_utils.dart';
import 'package:wedme1/utils/error_code.dart';
import 'package:wedme1/utils/flushbar_widget.dart';
import 'package:wedme1/utils/response_utils.dart';
import 'package:wedme1/viewModel/base_view_model.dart';
import 'package:wedme1/widget/custom_loader.dart';
import '../screens/Auth/screen/phone_no_otp_screen.dart';
import '../screens/Profile/profile_screen/profile_screen.dart';

class AuthViewModel extends BaseViewModel {
  final authPhoneController = TextEditingController();
  // final otpController = TextEditingController();
  final verifyOptController = TextEditingController();
  final recoveryEmailController = TextEditingController();
  final signinPhoneController = TextEditingController();

  String? verificitionId;
  String? phoneVerfySms;
  String countryCode = '234';
  // final googleSignin = GoogleSignIn();
  UserModel? _userModel;

  UserModel? get usermodel => _userModel;
  User? _user;
  User? get user => _user;
  // GoogleSignInAccount? googleSignInAccount;
  // GoogleSignInAccount? googleLoginAccount;

  setCountryCode(String phoneCode) {
    countryCode = phoneCode;
    setState();
  }

  Future<void> signinWithPhoneNumber(BuildContext context, bool isLogin) async {
    CustomProgressDialog progressDialog = CustomProgressDialog(context,
        blur: 2, loadingWidget: const CustomLoader(), dismissable: false);

    progressDialog.show();
    await firebaseInstance.verifyPhoneNumber(
        phoneNumber: '+$countryCode${authPhoneController.text}',
        verificationCompleted: (PhoneAuthCredential credential) async {
          //Automatically pick sms token from phone if the user
          //uses phone number device
          //Then verifiy the user
          await firebaseInstance.signInWithCredential(credential).then((value) {
            progressDialog.dismiss();
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) {
              return const EmailRecoveryScreen();
            }), (route) => false);
          });
        },
        verificationFailed: (FirebaseAuthException error) {
          progressDialog.dismiss();
          firebaseErrorCode(context, error.code);
        },
        codeSent: (String vId, int? resendToken) {
          verificitionId = vId;

          setState();
          progressDialog.dismiss();
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => PhoneOtpScreen(
                  isLogin: isLogin,
                  type: 'verifyAuthOTP',
                  media: authPhoneController.text)));
          //
        },
        timeout: const Duration(seconds: 120),
        codeAutoRetrievalTimeout: (String verificationId) {
          progressDialog.dismiss();
          flushbar(
              context: context,
              title: 'Timeout',
              message: 'Timeout please try again later!',
              isSuccess: false);
        });
  }

  Future<void> verifyAuthOTP(BuildContext context, String otp, bool isLogin,
      [bool mounted = true]) async {
    CustomProgressDialog progressDialog = CustomProgressDialog(context,
        blur: 2, loadingWidget: const CustomLoader(), dismissable: false);
    try {
      progressDialog.show();

      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificitionId!, smsCode: otp);

      await firebaseInstance
          .signInWithCredential(credential)
          .then((value) async {
        final user = value.user;

        final doc = await userCollection.doc(user!.uid).get();

        // print('User detail ${user!.uid}');
        //Check if user already exist
        if (!doc.exists ||
            doc.data()!['phoneNumber'] != authPhoneController.text.trim()) {
          final fcbToken = await FirebaseMessaging.instance.getToken();
          //Register new user
          await userCollection.doc(user.uid).set({
            'displayName': '',
            'fullName': user.displayName ?? '',
            'email': user.email ?? '',
            'photoUrl': user.photoURL ?? profileAvaterUrl,
            'phoneNumber': authPhoneController.text,
            'userId': user.uid,
            'signUpMethod': 'phone',
            'authverified': user.emailVerified,
            'createdAt': user.metadata.creationTime ?? '',
            'otp': '',
            'countryCode': '',
            'country': '',
            'city': '',
            'religion': '',
            'gender': '',
            'preference': '',
            'genoType': '',
            'temperament': '',
            'choice': '',
            'bannerPic': [],
            'altBannerPic': [bannaUrl],
            'isVerified': false,
            'isOnline': false,
            'age': 0,
            'birthDay': '',
            'birthMonth': '',
            'birthYear': '',
            'lat': 0,
            'lng': 0,
            'balance': 0,
            'course': '',
            'schoolName': '',
            'marriageRadyness': '',
            'aboutMe': '',
            'love': '',
            'job': '',
            'images': [],
            'interest': [],
            'inviteList': [],
            'friends': [],
            'fcbToken': fcbToken ?? '',
            'LatestChat': '',
            'state': '',
            'interestedIn': '',
            'coinBalance': 0,
            'subscriptionDuration': '',
            'subsctiotionStartDate': '',
            'subscriptionDueDate': '',
            'subscriptionType': 'freemium',
            'subscriptionAmont': '',
            'currencyType': ''
          });
          if (!mounted) return;
          progressDialog.dismiss();
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) {
            return const EmailRecoveryScreen();
          }), (route) => false);
        } else {
          progressDialog.dismiss();
          if (isLogin) {
            print('The login is $isLogin');
            //Login user
            // firebaseInstance.signOut();
            if (!mounted) return;

            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) {
              return const MyHomePage();
            }), (route) => false);
            //Add User FCBToken

            final fcbToken = await FirebaseMessaging.instance.getToken();
            userCollection
                .doc(firebaseInstance.currentUser!.uid)
                .update({'fcbToken': fcbToken});
          } else {
            print('The login is $isLogin');
            flushbar(
                context: context,
                title: 'User exist',
                message: 'User with the account already exist',
                isSuccess: false);
            firebaseInstance.signOut();
          }
        }
      });
    } on FirebaseAuthException catch (error) {
      // otpController.clear();
      setState();
      print('The error auth ${error.code}');
      progressDialog.dismiss();
      firebaseErrorCode(context, error.code);
    } catch (e) {
      // otpController.clear();
      setState();
      progressDialog.dismiss();
      otherExeption(context, e);
    }
  }

  Future<void> signUpWithGoogle(BuildContext context,
      [bool mounted = true]) async {
    CustomProgressDialog progressDialog = CustomProgressDialog(context,
        blur: 2, loadingWidget: const CustomLoader(), dismissable: false);
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) return;
      // googleSignInAccount = googleUser;

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
      await firebaseInstance.signInWithCredential(credential);
      _user = firebaseInstance.currentUser;
      if (!mounted) return;
      progressDialog.show();
      setState();
      //Check if user already exist
      final doc = await userCollection.doc(user!.uid).get();

      if (!doc.exists) {
        //Register new user
        final fcbToken = await FirebaseMessaging.instance.getToken();
        await userCollection.doc(user!.uid).set({
          'displayName': '',
          'fullName': user!.displayName ?? '',
          'email': user!.email ?? '',
          'photoUrl': user!.photoURL ?? profileAvaterUrl,
          'phoneNumber': user!.phoneNumber ?? '',
          'userId': user!.uid,
          'signUpMethod': 'google',
          'authverified': user!.emailVerified,
          'createdAt': user!.metadata.creationTime ?? '',
          'otp': '',
          'countryCode': '',
          'identityType': '',
          'identityLink': '',
          'country': '',
          'city': '',
          'religion': '',
          'gender': '',
          'preference': '',
          'genoType': '',
          'temperament': '',
          'choice': '',
          'bannerPic': [],
          'altBannerPic': [bannaUrl],
          'isVerified': false,
          'isOnline': false,
          'age': 0,
          'birthDay': '',
          'birthMonth': '',
          'birthYear': '',
          'lat': 0,
          'lng': 0,
          'balance': 0,
          'course': '',
          'schoolName': '',
          'marriageRadyness': '',
          'aboutMe': '',
          'love': '',
          'job': '',
          'images': [],
          'interest': [],
          'inviteList': [],
          'friends': [],
          'fcbToken': fcbToken ?? '',
          'LatestChat': '',
          'state': '',
          'interestedIn': '',
          'coinBalance': 0,
          'subscriptionDuration': '',
          'subsctiotionStartDate': '',
          'subscriptionDueDate': '',
          'subscriptionType': 'freemium',
          'subscriptionAmont': '',
          'currencyType': ''
        });

        if (!mounted) return;
        progressDialog.dismiss();
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const PhoneNumberScreen()),
          (route) => false,
        );
      } else {
        firebaseInstance.signOut();
        if (!mounted) return;
        progressDialog.dismiss();
        flushbar(
            context: context,
            title: 'User exist',
            message: 'User with the account already exist',
            isSuccess: false);
      }
    } on FirebaseAuthException catch (error) {
      progressDialog.dismiss();
      firebaseErrorCode(context, error.code);
    } catch (e) {
      progressDialog.dismiss();
      otherExeption(context, e);
    }
  }

  Future<void> loginWithGoogle(BuildContext context,
      [bool mounted = true]) async {
    CustomProgressDialog progressDialog = CustomProgressDialog(context,
        blur: 2, loadingWidget: const CustomLoader(), dismissable: false);
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) return;
      // googleSignInAccount = googleUser;

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
      await firebaseInstance.signInWithCredential(credential);

      _user = firebaseInstance.currentUser;

      // if (!mounted) return;
      progressDialog.show();
      // setState();
      //Check if user already exist
      final doc = await userCollection.doc(user!.uid).get();

      print('Get the user doc ${doc.exists}');

      if (!doc.exists) {
        print(' Get the printed fine');
        // if (!mounted) return;
        progressDialog.dismiss();
        flushbar(
            context: context,
            title: 'User dose not exist',
            message: 'User with the account dose not exist',
            isSuccess: false);
        return;
      } else {
        print(' Get the printed not good');
        if (!mounted) return;
        progressDialog.dismiss();
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (context) => const ProgressLoadingScreen()),
          (route) => false,
        );

        //Add User FCBToken

        final fcbToken = await FirebaseMessaging.instance.getToken();
        userCollection
            .doc(firebaseInstance.currentUser!.uid)
            .update({'fcbToken': fcbToken});
      }
      // print('Get the end');
    } on FirebaseAuthException catch (error) {
      print('Get the firebase auth ${error.code}');
      // progressDialog.dismiss();
      firebaseErrorCode(context, error.code);
    } catch (e) {
      print('Get the other auth $e');
      // progressDialog.dismiss();
      otherExeption(context, e);
    }
  }

  Future<void> signInWithFacebook(BuildContext context,
      [bool mounted = true]) async {
    CustomProgressDialog progressDialog = CustomProgressDialog(context,
        blur: 2, loadingWidget: const CustomLoader(), dismissable: false);

    try {
      final LoginResult loginResult = await FacebookAuth.instance.login();

      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(loginResult.accessToken!.token);

      final facebookAuth = await FirebaseAuth.instance
          .signInWithCredential(facebookAuthCredential);

      progressDialog.show();

      final doc = await userCollection.doc(facebookAuth.user!.uid).get();
      if (!doc.exists) {
        if (!mounted) return;
        progressDialog.dismiss();
        flushbar(
            context: context,
            title: 'User dose not exist',
            message: 'User with the account dose not exist',
            isSuccess: false);
      } else {
        if (!mounted) return;
        progressDialog.dismiss();
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (context) => const ProgressLoadingScreen()),
          (route) => false,
        );

        //Add User FCBToken

        final fcbToken = await FirebaseMessaging.instance.getToken();
        userCollection
            .doc(firebaseInstance.currentUser!.uid)
            .update({'fcbToken': fcbToken});
      }
    } on FirebaseAuthException catch (error) {
      progressDialog.dismiss();
      firebaseErrorCode(context, error.code);
    } catch (e) {
      progressDialog.dismiss();
      otherExeption(context, e);
    }
  }

  Future<void> signUpWithFacebook(BuildContext context,
      [bool mounted = true]) async {
    CustomProgressDialog progressDialog = CustomProgressDialog(context,
        blur: 2, loadingWidget: const CustomLoader(), dismissable: false);

    try {
      final LoginResult loginResult = await FacebookAuth.instance.login();

      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(loginResult.accessToken!.token);

      final facebookAuth = await FirebaseAuth.instance
          .signInWithCredential(facebookAuthCredential);

      progressDialog.show();

      final doc = await userCollection.doc(facebookAuth.user!.uid).get();
      if (!doc.exists) {
        final fcbToken = await FirebaseMessaging.instance.getToken();
        await userCollection.doc(user!.uid).set({
          'displayName': '',
          'fullName': user!.displayName ?? '',
          'email': user!.email ?? '',
          'photoUrl': user!.photoURL ?? profileAvaterUrl,
          'phoneNumber': user!.phoneNumber ?? '',
          'userId': user!.uid,
          'signUpMethod': 'facebook',
          'authverified': true,
          'createdAt': user!.metadata.creationTime ?? '',
          'otp': '',
          'countryCode': '',
          'identityType': '',
          'identityLink': '',
          'country': '',
          'city': '',
          'religion': '',
          'gender': '',
          'preference': '',
          'temperament': '',
          'choice': '',
          'bannerPic': [],
          'altBannerPic': [bannaUrl],
          'isVerified': false,
          'isOnline': false,
          'age': 0,
          'birthDay': '',
          'birthMonth': '',
          'birthYear': '',
          'lat': 0,
          'lng': 0,
          'balance': 0,
          'course': '',
          'schoolName': '',
          'marriageRadyness': '',
          'aboutMe': '',
          'love': '',
          'job': '',
          'images': [],
          'interest': [],
          'inviteList': [],
          'friends': [],
          'fcbToken': fcbToken ?? '',
          'LatestChat': '',
          'state': '',
          'interestedIn': '',
          'coinBalance': 0,
          'subscriptionDuration': '',
          'subsctiotionStartDate': '',
          'subscriptionDueDate': '',
          'subscriptionType': 'freemium',
          'subscriptionAmont': '',
          'currencyType': ''
        });
        if (!mounted) return;
        progressDialog.dismiss();
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const PhoneNumberScreen()),
          (route) => false,
        );
      } else {
        if (!mounted) return;
        progressDialog.dismiss();
        flushbar(
            context: context,
            title: 'User exist',
            message: 'User with the account already exist',
            isSuccess: false);
      }
    } on FirebaseAuthException catch (error) {
      progressDialog.dismiss();
      firebaseErrorCode(context, error.code);
    } catch (e) {
      progressDialog.dismiss();
      otherExeption(context, e);
    }
  }

  Future<void> sendVerifyPhoneNumberOTP(BuildContext context,
      [bool mounted = true]) async {
    CustomProgressDialog progressDialog = CustomProgressDialog(context,
        blur: 2, loadingWidget: const CustomLoader(), dismissable: false);

    progressDialog.show();
    await firebaseInstance.verifyPhoneNumber(
        phoneNumber: '+$countryCode${verifyOptController.text}',
        verificationCompleted: (PhoneAuthCredential credential) async {},
        verificationFailed: (FirebaseAuthException error) {
          progressDialog.dismiss();
          firebaseErrorCode(context, error.code);
        },
        codeSent: (String vId, int? resendToken) async {
          phoneVerfySms = vId;
          setState();
          final user = firebaseInstance.currentUser;
          await userCollection.doc(user!.uid).update({'otp': vId});

          progressDialog.dismiss();
          if (!mounted) return;
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => PhoneOtpScreen(
                    type: 'updatePhoneNumber',
                    media: authPhoneController.text,
                  )));
        },
        timeout: const Duration(seconds: 120),
        codeAutoRetrievalTimeout: (String verificationId) {
          progressDialog.dismiss();
          flushbar(
              context: context,
              title: 'Timeout',
              message: 'Timeout please try again later!',
              isSuccess: false);
        });
  }

  Future<void> updatePhoneNumber(BuildContext context) async {
    CustomProgressDialog progressDialog = CustomProgressDialog(context,
        blur: 2, loadingWidget: const CustomLoader(), dismissable: false);

    try {
      progressDialog.show();
      final user = firebaseInstance.currentUser;
      if (user != null) {
        final collection = userCollection.doc(user.uid);
        final doc = await collection.get();
        // print('The userid ${user.uid}');
        if (doc.data()!['otp'] == phoneVerfySms) {
          return collection.update({
            'phoneNumber': verifyOptController.text,
            'countryCode': '',
            'otp': ''
          }).then((value) {
            progressDialog.dismiss();
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const BioDataScreen()),
              (route) => false,
            );
          }).catchError((error) {
            progressDialog.dismiss();
            flushbar(
                context: context,
                title: 'Error',
                message: error.toString(),
                isSuccess: false);
          });
        } else {
          progressDialog.dismiss();
          flushbar(
              context: context,
              title: 'Invalid',
              message: 'Invalid token, please try again',
              isSuccess: false);
        }
      }
    } catch (e) {
      progressDialog.dismiss();
      flushbar(
          context: context,
          title: 'Error',
          message: e.toString(),
          isSuccess: false);
    }
  }

  Future<void> sendEmail(BuildContext context, [bool mounted = true]) async {
    CustomProgressDialog progressDialog = CustomProgressDialog(context,
        blur: 2, loadingWidget: const CustomLoader(), dismissable: false);
    // final user = firebaseInstance.currentUser;
    String otp = '$sixDigitToken';
    progressDialog.show();
    final result = await getIt
        .get<AuthServics>()
        .sendEmail(recoveryEmailController.text, otp);

    if (result is RepoSucess) {
      // if (!mounted) return;
      final user = firebaseInstance.currentUser;
      if (user != null) {
        // print('The userid ${user.uid}');

        return userCollection.doc(user.uid).update({
          'otp': otp,
        }).then((value) {
          progressDialog.dismiss();
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return const EmailOtpScreen();
          }));
        }).catchError((error) {
          progressDialog.dismiss();
          flushbar(
              context: context,
              title: 'Error',
              message: error.toString(),
              isSuccess: false);
        });
      }
    }
  }

  Future<void> updateRecoveryEmail(BuildContext context, String otp) async {
    CustomProgressDialog progressDialog = CustomProgressDialog(context,
        blur: 2, loadingWidget: const CustomLoader(), dismissable: false);

    try {
      progressDialog.show();
      final user = firebaseInstance.currentUser;
      if (user != null) {
        // print('The userid ${user.uid}');
        final collection = userCollection.doc(user.uid);
        final doc = await collection.get();
        if (doc.data()!['otp'] == otp) {
          // progressDialog.show();
          return collection.update({
            'email': recoveryEmailController.text,
            'otp': '',
          }).then((value) {
            progressDialog.dismiss();
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return const BioDataScreen();
            }));
          }).catchError((error) {
            progressDialog.dismiss();
            flushbar(
                context: context,
                title: 'Error',
                message: error.toString(),
                isSuccess: false);
          });
        } else {
          progressDialog.dismiss();
          flushbar(
              context: context,
              title: 'Invalid',
              message: 'Invalid token, please try again',
              isSuccess: false);
        }
      }
    } catch (e) {
      progressDialog.dismiss();
      flushbar(
          context: context,
          title: 'Error',
          message: e.toString(),
          isSuccess: false);
    }
  }

  Future<void> getUserProfile(context) async {
    CustomProgressDialog progressDialog = CustomProgressDialog(context,
        blur: 2, loadingWidget: const CustomLoader(), dismissable: false);

    progressDialog.show();

    try {
      final res = await firestore
          .collection("users")
          .doc(firebaseInstance.currentUser?.uid)
          .get()
          .then((value) {
        progressDialog.dismiss();
        if (value.data() != null) {
          _userModel = UserModel.fromJson(value.data()!);
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return const ProfileScreen();
              },
            ),
          );
        } else {
          print("User not found");
          flushbar(
            context: context,
            title: 'Error',
            message: "User not found",
            isSuccess: false,
          );
          return;
        }
      }).catchError((e) {
        progressDialog.dismiss();
        flushbar(
          context: context,
          title: 'Error',
          message: e.toString(),
          isSuccess: false,
        );
        return;
      });
    } catch (e) {
      progressDialog.dismiss();
      flushbar(
        context: context,
        title: 'Error',
        message: e.toString(),
        isSuccess: false,
      );
      return;
    }

    //notifyListeners();
  }

  // Stream<DocumentSnapshot> getUserProfile1(context) {
  //   final data = firestore
  //       .collection("users")
  //       .doc(firebaseInstance.currentUser?.uid)
  //       .snapshots();

  //   return data;
  // }

  Future<void> updateField(context, Map<String, dynamic> map) async {
    CustomProgressDialog progressDialog = CustomProgressDialog(context,
        blur: 2, loadingWidget: const CustomLoader(), dismissable: false);

    progressDialog.show();

    try {
      firestore
          .collection("users")
          .doc(firebaseInstance.currentUser?.uid)
          .update(map);
      progressDialog.dismiss();
      await getUserProfile(context);
    } catch (e) {
      progressDialog.dismiss();
      flushbar(
        context: context,
        title: 'Error',
        message: e.toString(),
        isSuccess: false,
      );
    }

    setState();
  }
}
