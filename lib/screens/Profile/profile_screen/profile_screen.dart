import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_animation_transition/animations/bottom_to_top_transition.dart';
import 'package:page_animation_transition/page_animation_transition.dart';
import 'package:wedme1/constants/colors.dart';
import 'package:wedme1/getit.dart';
import 'package:wedme1/screens/Profile/feedback_screen.dart';
import 'package:wedme1/screens/Profile/goPremium/go_premium_home.dart';
import 'package:wedme1/screens/Profile/marriage_certitificate/marriage_certification_home_screen.dart';
import 'package:wedme1/screens/Profile/profile_screen/friend_screen.dart';
import 'package:wedme1/screens/Profile/profile_screen/report_problem.dart';
import 'package:wedme1/screens/Profile/profile_screen/verification/verification_screen.dart';
import 'package:wedme1/screens/Profile/wallet/wallet_home.dart';
import 'package:wedme1/utils/base_view_builder.dart';
import 'package:wedme1/utils/flushbar_widget.dart';
import 'package:wedme1/utils/string_utils.dart';
import 'package:wedme1/viewModel/profile_vm.dart';
import 'package:wedme1/widget/profile_pic_showmodal.dart';
import '../../../widget/profile_widget/profile_list_tiles.dart';
import 'add_city_screen.dart';
import 'edit_profile_screen.dart';
import 'package:percent_indicator/percent_indicator.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  double profilePErcent = 0;
  @override
  Widget build(BuildContext context) {
    return BaseViewBuilder<ProfileViewModel>(
        model: getIt(),
        initState: (init) {
          profilePErcent =
              init.calProfilePercent().toStringAsFixed(0).toDouble / 100;
        },
        builder: (pVm, _) {
          return Scaffold(
              appBar: AppBar(
                leadingWidth: 60,
                centerTitle: true,
                title: Text(
                  'Profile',
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                ),
                elevation: 0,
                backgroundColor: Colors.white,
                leading: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Padding(
                    padding: EdgeInsets.only(left: 20, bottom: 2),
                    child: CircleAvatar(
                      radius: 15,
                      backgroundColor: kPrimaryColor,
                      child: Icon(
                        Icons.arrow_back_rounded,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                actions: [
                  IconButton(
                      onPressed: () => Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => const FriendScreen())),
                      icon: Image.asset('assets/images/profile-2user.png')),
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: IconButton(
                      onPressed: () {
                        Navigator.of(context).push(PageAnimationTransition(
                            page: const AddCityScreen(),
                            pageAnimationType: BottomToTopTransition()));
                      },
                      color: Colors.black,
                      icon: const Icon(
                        Icons.settings,
                        size: 35,
                      ),
                    ),
                  ),
                ],
              ),
              backgroundColor: Colors.white,
              body: pVm.cachedUserDetail == null
                  ? const Center(
                      child: CupertinoActivityIndicator(),
                    )
                  : SingleChildScrollView(
                      padding:
                          const EdgeInsets.only(left: 20, right: 20, top: 18),
                      child: Column(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  showModalBottomSheet(
                                      context: context,
                                      builder: (context) {
                                        return ProfilePicShowModal(
                                          profilePic:
                                              pVm.cachedUserDetail!.photoUrl!,
                                        );
                                      });
                                },
                                child: Stack(
                                  clipBehavior: Clip.none,
                                  children: [
                                    CircularPercentIndicator(
                                      radius: 40.0,
                                      lineWidth: 10.0,
                                      percent: profilePErcent,
                                      progressColor: const Color(0xFF02A827),
                                      center: CircleAvatar(
                                        radius: 37,
                                        backgroundImage: NetworkImage(
                                            pVm.cachedUserDetail!.photoUrl!),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: -3,
                                      right: -8,
                                      child: Container(
                                        padding: const EdgeInsets.all(8),
                                        decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Color(0xFF02A827)),
                                        child: Text(
                                          '${pVm.calProfilePercent().toStringAsFixed(0)}%',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w700,
                                            color: Colors.white,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10),
                              Column(
                                children: [
                                  Text(
                                    pVm.cachedUserDetail!.fullName!
                                        .split(' ')
                                        .first,
                                    maxLines: 5,
                                    softWrap: true,
                                    overflow: TextOverflow.fade,
                                    style: GoogleFonts.poppins(
                                      textStyle: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).push(
                                        PageAnimationTransition(
                                          page: const EditProfile(),
                                          pageAnimationType:
                                              BottomToTopTransition(),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      height: 35,
                                      width: 145,
                                      decoration: BoxDecoration(
                                        color: Colors.black,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text(
                                            'Complete profile',
                                            style: GoogleFonts.lato(
                                              textStyle: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ),
                                          Image.asset(
                                              'assets/images/user-edit.png')
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              ProfileListTiles(
                                leadingText: 'Verification',
                                callback: () {
                                  //  if (!pVm.cachedUserDetail!.isVerified!) {
                                  //   flushbar(
                                  //       context: context,
                                  //       title: 'Access Denied',
                                  //       message:
                                  //           'Upgrade or update your account to premium to access to this feature',
                                  //       isSuccess: false);
                                  // } else {
                                  //   Navigator.of(context).push(MaterialPageRoute(
                                  //     builder: ((context) =>
                                  //         const VerificationScreen())));
                                  // }
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: ((context) =>
                                          const VerificationScreen())));
                                },
                              ),
                              const SizedBox(height: 10),
                              ProfileListTiles(
                                  leadingText: 'Wallet',
                                  callback: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: ((context) =>
                                                const WalletHome())));
                                  }),
                              const SizedBox(height: 10),
                              ProfileListTiles(
                                leadingText: 'Go Premium',
                                callback: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: ((context) =>
                                          const GoPremiumHome())));
                                },
                              ),
                              const SizedBox(height: 10),
                              ProfileListTiles(
                                leadingText: 'Marriage Certificate',
                                callback: () {
                                  if (!pVm.validateSubscriptionStus(pVm
                                          .cachedUserDetail!
                                          .subscriptionDueDate!) ||
                                      !pVm.cachedUserDetail!.isVerified!) {
                                    flushbar(
                                        context: context,
                                        title: 'Access Denied',
                                        message:
                                            'Upgrade or update your account to premium to access this feature',
                                        isSuccess: false);
                                  } else {
                                    Navigator.of(context).push(MaterialPageRoute(
                                        builder: ((context) =>
                                            const MariageCertificateHomeScreen())));
                                  }
                                },
                              ),
                              const SizedBox(height: 10),
                              ProfileListTiles(
                                  leadingText: 'FAQ', callback: () {}),
                              const SizedBox(height: 10),
                              ProfileListTiles(
                                leadingText: 'Report problem',
                                callback: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: ((context) =>
                                          ReportProblemScreen())));
                                },
                              ),
                              const SizedBox(height: 10),
                              ProfileListTiles(
                                leadingText: 'Feedback',
                                callback: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: ((context) =>
                                          const FeedbackScreen())));
                                },
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: TextButton(
                                    onPressed: () => pVm.logOutUser(context),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Logout',
                                          style: GoogleFonts.lato(
                                            textStyle: const TextStyle(
                                              fontSize: 18,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        Image.asset('assets/images/logout.png')
                                      ],
                                    )),
                              )
                            ],
                          ),
                        ],
                      ),
                    ));
        });
  }
}
