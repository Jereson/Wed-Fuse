import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:clipboard/clipboard.dart';
import 'package:share_plus/share_plus.dart';
import 'SelectUsers.dart';

class AddMembersGetLink extends StatelessWidget {
  const AddMembersGetLink({super.key, required this.addedUser, required this.addId,required this.adminBtn});
  final List addedUser;
  final String addId;
  final String adminBtn;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16, top: 16),
      child: Container(
        height: 52,
        padding: const EdgeInsets.only(left: 16, right: 16),
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            border: Border.all(color: Colors.grey)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            adminBtn==FirebaseAuth.instance.currentUser!.uid?
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>  SelectUsers(addedUser: addedUser, addId:addId,),
                    ));
              },
              child: Row(
                children: [
                  Container(
                    height: 20,
                    width: 20,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/images/img_7.png"))),
                  ),
                  const Text(
                    "Add Members",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ):Row(
              children: [
                Container(
                  height: 20,
                  width: 20,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/images/img_7.png"))),
                ),
                const Text(
                  "Add Members",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),
              ],
            ),
            InkWell(
              onTap: () async {

                final dynamicLinkParams = DynamicLinkParameters(
                  link: Uri.parse(
                      "https://www.wedme.com/marriageInvite?groupId="),
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
                );

                Uri? buildLink = await FirebaseDynamicLinks.instance
                    .buildLink(dynamicLinkParams);

                FlutterClipboard.copy(buildLink.toString()).then(( value ) => print('copied')).then((value) {

                });
                _showAlertDialog(context: context,);

              },
              child: const Text(
                "Get link",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF426BFF)),
              ),
            )
          ],
        ),
      ),
    );
  }
  void _showAlertDialog({
    required BuildContext context,
    }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor:Colors.white,
          shape: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(0))),
          // title:  Text(''),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("", style: TextStyle(fontSize: 16),),
                  InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text("X", style: TextStyle(fontSize: 20),)),

                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'Done!',
                    style: TextStyle(fontSize: 16,color: Color(0xFF068C1C)),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'Your link has been copied to \nyour clipboard',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
              const SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }
}
