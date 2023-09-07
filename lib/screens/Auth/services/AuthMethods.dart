import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:riverpod/riverpod.dart';
import 'package:wedme1/constants/contants.dart';

import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

import '../../../constants/failure.dart';
import '../../../constants/firebaseContants.dart';
import '../../../constants/type_defs.dart';
import '../../../constants/utils.dart';
import '../../../models/userModel.dart';
import '../../../provider/firestoreprovider.dart';
import '../../../utils/otp.dart';
import '../../bio_data_screen.dart';
import '../../email_recovery_screen.dart';
import '../screen/phone_no_otp_screen.dart';

final authRepositoryProvider = Provider((ref) => AuthRepository(
    auth: ref.read(authProvider),
    firestore: ref.read(firestoreProvider),
    googleSignIn: ref.read(googleSignProvider)));

class FirebaseAuthMethods {
  final FirebaseAuth _auth;

  FirebaseAuthMethods(this._auth);

  User get user => _auth.currentUser!;

  Stream<User?> get authState => FirebaseAuth.instance.authStateChanges();

  // PHONE SIGN IN
  Future<void> phoneSignIn(
    BuildContext context,
    String phoneNumber,
  ) async {
    TextEditingController codeController = TextEditingController();
    // FOR ANDROID, IOS
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      //  Automatic handling of the SMS code
      verificationCompleted: (PhoneAuthCredential credential) async {
        // !!! works only on android !!!
        await _auth.signInWithCredential(credential);
      },
      // Displays a message when verification fails
      verificationFailed: (e) {
        showSnackBar(context, e.message!);
      },
      // Displays a dialog box when OTP is sent
      codeSent: ((String verificationId, int? resendToken) async {
        showOTPDialog(
          codeController: codeController,
          context: context,
          onPressed: () async {
            PhoneAuthCredential credential = PhoneAuthProvider.credential(
              verificationId: verificationId,
              smsCode: codeController.text.trim(),
            );

            // !!! Works only on Android, iOS !!!
            await _auth.signInWithCredential(credential);
            Navigator.of(context).pop(); // Remove the dialog box
          },
        );
      }),
      codeAutoRetrievalTimeout: (String verificationId) {
        // Auto-resolution timed out...
      },
    );
  }

  // SIGN OUT
  Future<void> signOut(BuildContext context) async {
    try {
      await _auth.signOut();
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!); // Displaying the error message
    }
  }
}

class AuthRepository {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;
  final GoogleSignIn _googleSignIn;

  AuthRepository({
    required FirebaseAuth auth,
    required FirebaseFirestore firestore,
    required GoogleSignIn googleSignIn,
  })  : _auth = auth,
        _firestore = firestore,
        _googleSignIn = googleSignIn;

  CollectionReference get _users =>
      _firestore.collection(FirebaseConstants.usersCollection);

  Stream<User?> get authStateChange => _auth.authStateChanges();

  void signInWithPhon(BuildContext context, String phoneNumber) async {
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await _auth.signInWithCredential(credential);
        },
        verificationFailed: (e) {
          throw Exception(e.message);
        },
        codeSent: ((String verificationId, int? resendToken) async {
          //  Navigator.push(
          //    context,
          //    MaterialPageRoute(builder: (context) =>  PhoneOtpScreen(verificationId: verificationId,),),
          //  );
        }),
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } on FirebaseAuthException catch (e) {
      print(e.message);
    }
  }

  FutureEither<UserModel> verifyOTP({
    required BuildContext context,
    required String verificationId,
    required String userOTP,
  }) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: userOTP,
      );
      UserCredential PhoneuserCredential =
          await _auth.signInWithCredential(credential);

      UserModel? userModel;
      if (PhoneuserCredential.additionalUserInfo!.isNewUser) {
        print('newuser');
        UserModel userModel = UserModel(
            displayName: "displayName",
            fullName: "fullName",
            email: "email",
            photoUrl: "photoUrl",
            bannerPic: "bannerPic",
            phoneNumber: "phoneNumber",
            signUpMethod: "signUpMethod",
            authverified: 'false',
            createdAt: 'DateTime.now()',
            countryCode: "countryCode",
            identityType: "identityType",
            identityLink: "identityLink",
            country: "country",
            userId: "userId",
            isVerified: true,
            isOnline: true,
            // isAuthenticated: true,
            age: 12,
            balance: 12,
            city: "",
            course: "course",
            schoolName: "schoolName",
            marriageRadyness: "marriageReadyNess",
            aboutMe: "aboutMe",
            love: "love",
            religion: "religion",
            genoType: "genotype",
            temperament: "temperament",
            choice: "choice",
            lat: 12,
            lng: 12,
            images: [],
            interest: [],
            storylineCount: 0,
            storylineUrls: []);

        await _users.doc(PhoneuserCredential.user!.uid).set(userModel.toJson());
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => BioDataScreen()),
            (route) => false);
      } else {
        userModel = await getUserData(PhoneuserCredential.user!.uid).first;
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => BioDataScreen()),
            (route) => false);
      }
      return right(userModel!);
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  FutureEither<UserModel> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      final googleAuth = await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      UserModel? userModel;

      if (userCredential.additionalUserInfo!.isNewUser) {
        UserModel userModel = UserModel(
          displayName: "displayName",
          fullName: "fullName",
          email: "email",
          photoUrl: "photoUrl",
          bannerPic: "bannerPic",
          phoneNumber: "phoneNumber",
          signUpMethod: "signUpMethod",
          authverified: 'false',
          createdAt: 'DateTime.now()',
          countryCode: "countryCode",
          identityType: "identityType",
          identityLink: "identityLink",
          country: "country",
          userId: "userId",
          isVerified: true,
          isOnline: true,
          // isAuthenticated: true,
          age: 12,
          balance: 12,
          city: "",
          course: "course",
          schoolName: "schoolName",
          marriageRadyness: "marriageReadyNess",
          aboutMe: "aboutMe",
          love: "love",
          religion: "religion",
          genoType: "genotype",
          temperament: "temperament",
          choice: "choice",
          lat: 12,
          lng: 12,
          images: [],
          interest: [],
          storylineCount: 0,
          storylineUrls: [],
        );

        await _users.doc(userCredential.user!.uid).set(userModel.toJson());
      } else {
        userModel = await getUserData(userCredential.user!.uid).first;
      }
      return right(userModel!);
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  Stream<UserModel> getUserData(String uid) {
    return _users.doc(uid).snapshots().map(
        (event) => UserModel.fromJson(event.data() as Map<String, dynamic>));
  }

  Future<UserModel?> getCurrentUserData() async {
    var userData = await _users.doc(_auth.currentUser?.uid).get();

    UserModel? user;
    if (userData.data() != null) {
      user = UserModel.fromJson(userData.data() as Map<String, dynamic>);
    }
    return user;
  }

  void setUserState(bool isOnline) async {
    await _users.doc(_auth.currentUser!.uid).update({
      'isOnline': isOnline,
    });
  }

  // FACEBOOK SIGN IN
  FutureEither<UserModel> signInWithFacebook() async {
    try {
      final LoginResult loginResult = await FacebookAuth.instance.login();

      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(loginResult.accessToken!.token);

      await _auth.signInWithCredential(facebookAuthCredential);
      UserCredential facebookusercredential =
          await _auth.signInWithCredential(facebookAuthCredential);
      UserModel? userModel;
      if (facebookusercredential.additionalUserInfo == null) {
        userModel = UserModel(
          images: [],
          interest: [],
          storylineCount: 0,
          storylineUrls: [],
          displayName: "displayName",
          fullName: "fullName",
          email: "email",
          photoUrl: "photoUrl",
          bannerPic: "bannerPic",
          phoneNumber: "phoneNumber",
          signUpMethod: "signUpMethod",
          authverified: 'false',
          createdAt: 'DateTime.now()',
          countryCode: "countryCode",
          identityType: "identityType",
          identityLink: "identityLink",
          country: "country",
          userId: "userId",
          isVerified: true,
          isOnline: true,
          // isAuthenticated: true,
          age: 12,
          balance: 12,
          city: "",
          course: "course",
          schoolName: "schoolName",
          marriageRadyness: "marriageReadyNess",
          aboutMe: "aboutMe",
          love: "love",
          religion: "religion",
          genoType: "genotype",
          temperament: "temperament",
          choice: "choice",
          lat: 12,
          lng: 12,
        );
        await _users
            .doc(facebookusercredential.user!.uid)
            .set(userModel.toJson());
      } else {
        userModel = await getUserData(facebookusercredential.user!.uid).first;
      }
      return right(userModel);
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  void logOut() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }
}
