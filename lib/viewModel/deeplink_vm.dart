import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:page_animation_transition/animations/bottom_to_top_transition.dart';
import 'package:page_animation_transition/page_animation_transition.dart';
import 'package:share_plus/share_plus.dart';
import 'package:wedme1/screens/Auth/screen/login_screen.dart';
import 'package:wedme1/screens/Auth/screen/welcome_screen.dart';
import 'package:wedme1/screens/preliminary/progress_loading_screen.dart';
import 'package:wedme1/utils/flushbar_widget.dart';
import 'package:wedme1/viewModel/base_view_model.dart';

class DynamicDeepLinkModelView extends BaseViewModel {
  Uri? buildLink;
  Uri? deepLink;
  String? linkStatus = 'idle';
  bool isInvite = false;

  

  Future<void> createDynamicLink() async {
    // final groupId = firebaseInstance.currentUser!.uid;
    String groupId = 'abcdefgh';
    final dynamicLinkParams = DynamicLinkParameters(
      link: Uri.parse("https://www.wedme.com/marriageInvite?groupId=$groupId"),
      uriPrefix: "https://wedme.page.link",
      androidParameters: AndroidParameters(
        //TODO:: Change this link to the app play store link

        fallbackUrl: Uri.parse("https://play.google.com"),
        packageName: "com.briskita.wedme",
        minimumVersion: 30,
      ),
      //TODO:: Update the iOS proper data
      //Also change for Info.plist
      //Follow this below link to setup ios properly
      //https://firebase.flutter.dev/docs/dynamic-links/receive/
      iosParameters: const IOSParameters(
        bundleId: "com.example.app.ios",
        appStoreId: "123456789",
        minimumVersion: "1.0.1",
      ),
      // googleAnalyticsParameters: const GoogleAnalyticsParameters(
      //   source: "twitter",
      //   medium: "social",
      //   campaign: "example-promo",
      // ),
      // socialMetaTagParameters: SocialMetaTagParameters(
      //   title: "Example of a Dynamic Link",
      //   imageUrl: Uri.parse("https://example.com/image.png"),
      // ),
    );
    final dynamicLink =
        await FirebaseDynamicLinks.instance.buildShortLink(dynamicLinkParams);
    buildLink =
        await FirebaseDynamicLinks.instance.buildLink(dynamicLinkParams);
    Uri shortDynamicLink = dynamicLink.shortUrl;
    setState();
    print('The buildLink link $buildLink');
    // print('The short link $shortDynamicLink');
  }

  Future<void> shareInvite() async {
    await Share.share(
      '$buildLink',
      subject: 'Invite friends and love ones to your wedding',
    );
  }

  Future<void> sharePost() async {
    await Share.share(
      '$buildLink',
      subject: 'Download, WedMeApp to view this post',
    );
  }

  Future<void> initDynamicOnclickLink(BuildContext context,
      [bool mounted = true]) async {
    print('object 1');
    //Get initialLink when the app is on background Mode
    FirebaseDynamicLinks.instance.onLink.listen((event) {
      print('object 2');
      deepLink = event.link;
      setState();
      bool isGroupInvite = deepLink!.pathSegments.contains('marriageInvite');
      if (isGroupInvite) {
        print('object 3');
        String? groudId = deepLink!.queryParameters['groupId'];
        linkStatus = 'onclick';
        isInvite = true;
        setState();

        firebaseInstance.authStateChanges().listen((User? user) async {
          print('object 4');
          if (user == null) {
            print('object 5');
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const WelcomeScreen()),
            );
          } else {
            print('object 6');
            //TODO::: Take the user to the chatroom
            //Remove this route
            Navigator.of(context).push(PageAnimationTransition(
                page: const ProgressLoadingScreen(),
                pageAnimationType: BottomToTopTransition()));
          }
        });
        print('object 7');
        // flushbar(
        //     context: context,
        //     title: 'Install',
        //     message: 'App Already installed',
        //     isSuccess: true);
        return;
      }
    }).onError((error) {
      print('object 8');
      print('The error $error');
      flushbar(
          context: context,
          title: 'Error',
          message: error.toString(),
          isSuccess: true);
    });

    // Get any initial links when app is not open or installed
    final PendingDynamicLinkData? initialLink =
        await FirebaseDynamicLinks.instance.getInitialLink();

    if (initialLink != null && linkStatus == 'idle') {
      print('object 9');
      deepLink = initialLink.link;
      setState();
      bool isGroupInvite = deepLink!.pathSegments.contains('marriageInvite');
      if (isGroupInvite) {
        print('object 10');
        String? groudId = deepLink!.queryParameters['groupId'];
        isInvite = true;
        setState();

        firebaseInstance.authStateChanges().listen((User? user) async {
          print('object 11');
          if (user == null) {
            print('object 13');
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const WelcomeScreen()),
            );
          } else {
            print('object 14');
            //TODO::: Take the user to the chatroom
            //Remove this route
            // Navigator.of(context).push(PageAnimationTransition(
            //     page: const ProgressLoadingScreen(),
            //     pageAnimationType: BottomToTopTransition()));
          }
        });
        // flushbar(
        //     context: context,
        //     title: 'Not Install',
        //     message: 'App Not installed',
        //     isSuccess: true);
      }
      return;
    }

    if (!mounted) return;
    routeNonLinkUser(context);

    print('The initialLink $initialLink');
    print('The dedlink $deepLink');
    print('The onlclick $linkStatus');
  }

  routeNonLinkUser(BuildContext context) async {
    print('object 15');
    firebaseInstance.authStateChanges().listen((User? user) async {
      if (user == null) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      } else {
        Navigator.of(context).push(PageAnimationTransition(
            page: const ProgressLoadingScreen(),
            pageAnimationType: BottomToTopTransition()));
      }
    });
  }

  // void navigationPage(BuildContext context) {

  // }
}
