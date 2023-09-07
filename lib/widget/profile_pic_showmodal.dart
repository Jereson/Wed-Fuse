import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wedme1/constants/colors.dart';
import 'package:wedme1/getit.dart';
import 'package:wedme1/screens/Profile/profile_photo_view.dart';
import 'package:wedme1/utils/base_view_builder.dart';
import 'package:wedme1/utils/flushbar_widget.dart';
import 'package:wedme1/viewModel/profile_vm.dart';

class ProfilePicShowModal extends StatelessWidget {
  final String profilePic;
  const ProfilePicShowModal({super.key, required this.profilePic});

  @override
  Widget build(BuildContext context) {
    return BaseViewBuilder<ProfileViewModel>(
        model: getIt(),
        builder: (pVm, _) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.38,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.of(context)
                        .pushReplacement(MaterialPageRoute(builder: (context) {
                      return ProfilePhotView(
                          imageUrl: pVm.cachedUserDetail!.photoUrl!);
                    })),
                    child: Center(
                      child: Column(
                        children: [
                          const SizedBox(height: 10),
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.red,
                                border:
                                    Border.all(color: kPrimaryColor, width: 2),
                                borderRadius: BorderRadius.circular(40)),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(40),
                              child: Container(
                                height: 70,
                                width: 70,
                                decoration: BoxDecoration(
                                    // border: Border.all(color: kPrimaryColor, width: 2),
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(40)),
                                child: CachedNetworkImage(
                                  imageUrl: pVm.cachedUserDetail!.photoUrl!,
                                  progressIndicatorBuilder:
                                      (context, url, downloadProgress) =>
                                          const CupertinoActivityIndicator(),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.broken_image),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'View Profile Photo',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),
                  _customButton('Change profile photo', () {
                    print('The profile image $profilePic');
                    pVm.changeProfilePic(context);
                  }),
                  _customButton('New profile photo', () {
                    // ignore: unnecessary_null_comparison
                    if (profilePic.isEmpty || profilePic == null) {
                      pVm.changeProfilePic(context);
                    } else {
                      flushbar(
                          context: context,
                          title: 'Profile Image Exist',
                          message:
                              'Profile image already exist, consider removing the existing one before uplaoding another',
                          isSuccess: false,
                          duration: 8);
                    }
                  }),
                  // _customButton('Import from Facebook', () {}),
                  // _customButton('Import From Drive', () {}),
                  _customButton('Remove profile photo', () {
                    // ignore: unnecessary_null_comparison
                    if (profilePic.isNotEmpty || profilePic == null) {
                      pVm.deleteProfileImage(context, profilePic);
                    } else {
                      flushbar(
                          context: context,
                          title: 'No profile image',
                          message: 'Profile image dose not exist',
                          isSuccess: false,
                          duration: 8);
                    }
                  }, true),
                ]),
          );
        });
  }

  Widget _customButton(String title, VoidCallback callback,
      [bool isRemove = false]) {
    return GestureDetector(
      onTap: callback,
      child: Container(
          height: 40,
          color: Colors.white,
          padding: const EdgeInsets.only(left: 20),
          alignment: Alignment.centerLeft,
          child: Text(title,
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: !isRemove ? Colors.black : kPrimaryColor),
              ))),
    );
  }
}
