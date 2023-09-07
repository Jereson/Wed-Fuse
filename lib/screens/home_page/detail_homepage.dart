import 'package:animator/animator.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wedme1/constants/colors.dart';
import 'package:wedme1/getit.dart';
import 'package:wedme1/screens/chat_screens/conversation_screen.dart';
import 'package:wedme1/utils/base_view_builder.dart';
import 'package:wedme1/utils/local_storage_utils.dart';
import 'package:wedme1/viewModel/profile_vm.dart';
import 'package:wedme1/viewModel/user_reaction.dart';
import 'package:wedme1/widget/storylinewidget.dart';
import '../../utils/styles.dart';
import '../../widget/button_widget.dart';

class DetailHomescreen extends StatefulWidget {
  final int index;

  const DetailHomescreen({Key? key, required this.index}) : super(key: key);

  @override
  State<DetailHomescreen> createState() => _DetailHomescreenState();
}

class _DetailHomescreenState extends State<DetailHomescreen> {
  int currentIndex = 0;
  String chatRid(String user1, String user2) {
    if (user1[0].toLowerCase().codeUnits[0] >
        user2.toLowerCase().codeUnits[0]) {
      return "$user1$user2";
    } else {
      return "$user2$user1";
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // final pVm.selectedUser = getIt.get<ProfileViewModel>().pVm.selectedUser;
    final showDistance = getIt.get<LocalStorage>().getShowDistance() ?? false;
    final showAge = getIt.get<LocalStorage>().getShowAge() ?? false;
    return SafeArea(
      child: BaseViewBuilder<ProfileViewModel>(
          model: getIt(),
          initState: (init) {
            init.setUserMatch();
          },
          builder: (pVm, _) {
            List banerImages = pVm.selectedUser!.bannerPic!.isEmpty
                ? pVm.selectedUser!.altBannerPic!
                : pVm.selectedUser!.bannerPic!;
            return BaseViewBuilder<UserReactionVm>(
                model: getIt(),
                builder: (uVm, _) {
                  return Scaffold(
                      body: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Stack(children: [
                              Container(
                                height: 300.0,
                                width: double.infinity,
                                decoration: const BoxDecoration(boxShadow: [
                                  BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 2.0,
                                      offset: Offset(
                                        0.0,
                                        10.0,
                                      ))
                                ]),
                                // color: Colors.white,
                                child: Container(
                                  foregroundDecoration: const BoxDecoration(
                                      gradient: LinearGradient(
                                          colors: [
                                            Colors.black,
                                            Colors.transparent
                                          ],
                                          begin: Alignment.bottomCenter,
                                          end: Alignment.topCenter,
                                          tileMode: TileMode.mirror,
                                          stops: [0.0, 0.5])),
                                  child: Container(
                                    foregroundDecoration: const BoxDecoration(
                                        gradient: LinearGradient(
                                            colors: [
                                              Colors.black,
                                              Colors.transparent
                                            ],
                                            begin: Alignment.bottomCenter,
                                            end: Alignment.topCenter,
                                            tileMode: TileMode.mirror,
                                            stops: [0.0, 0.5])),
                                    child: CarouselSlider(
                                        items: banerImages.map((image) {
                                          return SizedBox(
                                            width: double.infinity,
                                            child: CachedNetworkImage(
                                              imageUrl: image,
                                              progressIndicatorBuilder: (context,
                                                      url, downloadProgress) =>
                                                  const CupertinoActivityIndicator(),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      const Icon(Icons.error),
                                              fit: BoxFit.cover,
                                            ),
                                          );
                                        }).toList(),
                                        options: CarouselOptions(
                                          height: 300,
                                          aspectRatio: 1,
                                          viewportFraction: 1,
                                          initialPage: 0,
                                          enableInfiniteScroll: false,
                                          reverse: false,
                                          autoPlay: false,
                                          autoPlayInterval:
                                              const Duration(seconds: 3),
                                          autoPlayAnimationDuration:
                                              const Duration(milliseconds: 800),
                                          // autoPlayCurve: Curves.fastOutSlowIn,
                                          enlargeCenterPage: false,
                                          enlargeFactor: 1,
                                          onPageChanged:
                                              (carouselIndex, reason) {
                                            setState(() {
                                              currentIndex = carouselIndex;
                                            });
                                          },
                                          scrollDirection: Axis.horizontal,
                                        )),
                                  ),

                                  // child: Padding(
                                  //   padding: const EdgeInsets.only(
                                  //       left: 4, bottom: 5),
                                  //   child: Column(
                                  //     mainAxisAlignment:
                                  //         MainAxisAlignment.spaceBetween,
                                  //     children: [
                                  //       Column(
                                  //         mainAxisAlignment:
                                  //             MainAxisAlignment.start,
                                  //         children: [
                                  //           Padding(
                                  //             padding: const EdgeInsets.only(
                                  //                 right: 20, top: 15),
                                  //             child: Row(
                                  //               mainAxisAlignment:
                                  //                   MainAxisAlignment
                                  //                       .spaceBetween,
                                  //               children: [
                                  // GestureDetector(
                                  //   onTap: (() {
                                  //     Navigator.of(context)
                                  //         .pop();
                                  //   }),
                                  //   child: const Image(
                                  //     image: AssetImage(
                                  //         "assets/icons/back_button.png"),
                                  //     height: 36,
                                  //     width: 36,
                                  //   ),
                                  // ),
                                  //                 Padding(
                                  //                   padding: EdgeInsets.only(
                                  //                       left: 58.0),
                                  //                   child: const Image(
                                  //                       image: AssetImage(
                                  //                           "assets/icons/active_dash_pic.png")),
                                  //                 ),
                                  //                 const Padding(
                                  //                   padding: EdgeInsets.only(
                                  //                       left: 4),
                                  //                   child: Image(
                                  //                       image: AssetImage(
                                  //                           "assets/icons/non_active_dash.png")),
                                  //                 ),
                                  //               ],
                                  //             ),
                                  //           ),
                                  //         ],
                                  //       ),
                                  //     ],
                                  //   ),
                                  // ),
                                ),
                              ),
                              Positioned(
                                top: 10,
                                left: 10,
                                child: GestureDetector(
                                  onTap: (() {
                                    Navigator.of(context).pop();
                                  }),
                                  child: const Image(
                                    image: AssetImage(
                                        "assets/icons/back_button.png"),
                                    height: 36,
                                    width: 36,
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 10,
                                right: 10,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children:
                                      banerImages.asMap().entries.map((entry) {
                                    return Container(
                                      width: 30.0,
                                      height: 2.0,
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 8.0, horizontal: 4.0),
                                      decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(
                                              currentIndex == entry.key
                                                  ? 0.9
                                                  : 0.4)),
                                    );
                                  }).toList(),
                                ),
                              ),
                              Positioned(
                                bottom: 20,
                                left: 15,
                                child: Row(
                                  children: [
                                    RichText(
                                        overflow: TextOverflow.clip,
                                        textAlign: TextAlign.end,
                                        textDirection: TextDirection.rtl,
                                        maxLines: 1,
                                        textScaleFactor: 1,
                                        text: TextSpan(
                                            text: pVm.selectedUser!.fullName!
                                                    .isNotEmpty
                                                ? pVm.selectedUser!.fullName!
                                                    .split(' ')
                                                    .first
                                                : 'User',
                                            style: GoogleFonts.poppins(
                                                textStyle: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 26,
                                            )),
                                            children: [
                                              const WidgetSpan(
                                                  alignment:
                                                      PlaceholderAlignment
                                                          .baseline,
                                                  baseline:
                                                      TextBaseline.alphabetic,
                                                  child: SizedBox(
                                                    width: 2,
                                                  )),
                                              if (showAge)
                                                TextSpan(
                                                  text:
                                                      ', ${pVm.selectedUser!.age}',
                                                  style: GoogleFonts.poppins(
                                                      textStyle: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 20,
                                                  )),
                                                )
                                            ])),
                                    const SizedBox(width: 4),
                                    Transform.translate(
                                      offset: const Offset(0, 3),
                                      child: Icon(
                                        Icons.verified,
                                        size: 19,
                                        color: pVm.selectedUser!.isVerified!
                                            ? Colors.blue
                                            : Colors.grey,
                                      ),
                                    )
                                    // Image.asset(
                                    //   "assets/icons/blue_tick.png",
                                    //   height: 20,
                                    //   width: 20,
                                    // ),
                                  ],
                                ),
                              ),
                              if (showDistance)
                                Positioned(
                                  bottom: 20,
                                  right: 10,
                                  child: MilesButtonWidget(
                                      size: size / 5,
                                      text: "31 miles",
                                      press: () {}),
                                )
                            ]),
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Column(
                                    children: [
                                      customRow(
                                        'red_box_icon',
                                        pVm.selectedUser!.job!.isNotEmpty
                                            ? pVm.selectedUser!.job!
                                            : "*******",
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          customRow(
                                            'graduate_icon',
                                            pVm.selectedUser!.schoolName!
                                                    .isNotEmpty
                                                ? pVm.selectedUser!.schoolName!
                                                : "******",
                                          ),
                                          Align(
                                            alignment: Alignment.centerRight,
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10),
                                              decoration: BoxDecoration(
                                                  color: Colors.black,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          50)),
                                              child: Text(
                                                '${pVm.userPercentMatch}% Match',
                                                style: GoogleFonts.poppins(
                                                    textStyle: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w300,
                                                  fontSize: 12,
                                                )),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),

                                      customRow(
                                        'red_location',
                                        pVm.selectedUser!.city!.isNotEmpty
                                            ? ' ${pVm.selectedUser!.city!}'
                                            : " ******",
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          customRow('red_love',
                                              ' ${pVm.selectedUser!.age} years'),
                                          //Check if user is already invisted
                                          (!pVm.cachedUserDetail!.inviteList!
                                                          .contains(pVm
                                                              .selectedUser!
                                                              .userId) &&
                                                      !pVm.selectedUser!
                                                          .inviteList!
                                                          .contains(pVm
                                                              .cachedUserDetail!
                                                              .userId)) &&
                                                  !uVm.isFriendRequestSent
                                              ? GestureDetector(
                                                  onTap: () {
                                                    // String token ='ctsEYUzpSHCayVgLTnxpa8:APA91bFiZs2U0hGMtdOh-1QAjyqJNsg6EoCHRt2MTfMHGUnrUdxvgU-WparjqstLdRNRKkkcYn6Nu3XW033-q1tyjzhVo_1-CAPFuDEP7rX4rlJOAfyKmOO-llP9fSE5q4z8kQvYEdj8'
                                                    // fQrjCiNETDaE27LQf9eUhs:APA91bG27WWHcotn-xtivJtiixBtQninDEKscLE6pSi6Cd2Lx4OiXL0V0qMeWL9ZUqscYeCsMGIMajbbXc2aNvdqfJL2laS8LntQbwDo5neNtJuNQXvrIgYYR3-bV5u3l68Wzk5uymj7', 'Send Invite', 'You are mine friend
                                                    uVm.inviteFriend(context,
                                                        userId: pVm
                                                            .selectedUser!
                                                            .userId!,
                                                        // 'qihGXx29paYuVEASzcfgDWLF9CD3',

                                                        fcbToken: pVm
                                                            .selectedUser!
                                                            .fcbToken!,
                                                        receiverName: pVm
                                                            .selectedUser!
                                                            .fullName!,
                                                        receiverPhoto: pVm
                                                            .selectedUser!
                                                            .photoUrl!,
                                                        receiverPhone: pVm
                                                            .selectedUser!
                                                            .phoneNumber!);
                                                  },
                                                  child: Align(
                                                    alignment:
                                                        Alignment.centerRight,
                                                    child: CircleAvatar(
                                                      radius: 16,
                                                      backgroundColor:
                                                          kPrimaryColor,
                                                      child: Image.asset(
                                                          "assets/icons/white_person_icon.png"),
                                                    ),
                                                  ),
                                                )
                                              : Align(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: CircleAvatar(
                                                    radius: 16,
                                                    backgroundColor:
                                                        Colors.grey,
                                                    child: Image.asset(
                                                        "assets/icons/white_person_icon.png"),
                                                  ),
                                                ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          const Image(
                                            image: AssetImage(
                                                "assets/icons/logo_icon.png"),
                                            height: 15,
                                            width: 15,
                                          ),
                                          const SizedBox(
                                            width: 2,
                                          ),
                                          Text(
                                            'Marriage readiness is ',
                                            style: GoogleFonts.poppins(
                                                textStyle: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w300,
                                              fontSize: 12,
                                            )),
                                          ),
                                          Text(
                                            pVm.selectedUser!.marriageRadyness!
                                                    .isNotEmpty
                                                ? ' ${pVm.selectedUser!.marriageRadyness!}'
                                                : " *****",
                                            style: GoogleFonts.poppins(
                                                textStyle: TextStyle(
                                              color: kPrimaryColor,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 11,
                                            )),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 20),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "About Me",
                                            style: GoogleFonts.poppins(
                                                textStyle: TextStyle(
                                              color: kPrimaryColor,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 18,
                                            )),
                                          ),
                                          const SizedBox(
                                            height: 1,
                                          ),
                                          Align(
                                            alignment: Alignment.bottomLeft,
                                            child: Text(
                                              pVm.selectedUser!.aboutMe!
                                                      .isNotEmpty
                                                  ? pVm.selectedUser!.aboutMe!
                                                  : "*****",
                                              style: GoogleFonts.poppins(
                                                  textStyle: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w300,
                                                fontSize: 12,
                                              )),
                                            ),
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 2,
                                      ),

                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Interest",
                                              style: GoogleFonts.poppins(
                                                  textStyle: TextStyle(
                                                color: kPrimaryColor,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 18,
                                              )),
                                            ),
                                            Wrap(
                                              children: pVm
                                                  .selectedUser!.interest!
                                                  .map(
                                                (interest) {
                                                  return Container(
                                                    height: 34,
                                                    margin: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 2,
                                                        vertical: 8),
                                                    child: Container(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          vertical: 5,
                                                          horizontal: 12),
                                                      decoration: BoxDecoration(
                                                        color: Styles.textColor,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(18),
                                                      ),
                                                      child: Text(
                                                        interest,
                                                        style:
                                                            GoogleFonts.poppins(
                                                          textStyle: TextStyle(
                                                            color: Styles
                                                                .whiteColor,
                                                            fontSize: 14,
                                                            fontStyle: FontStyle
                                                                .normal,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                          ),
                                                        ),
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ).toList(),
                                            ),
                                          ],
                                        ),
                                      ),

                                      //story line screen

                                      const SizedBox(height: 10),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "Storyline",
                                          style: GoogleFonts.poppins(
                                              textStyle: const TextStyle(
                                            color: kPrimaryColor,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 18,
                                          )),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                uVm.isLikeAnimate
                                    ? Animator(
                                        duration:
                                            const Duration(milliseconds: 300),
                                        tween: Tween(begin: 0.2, end: 1),
                                        curve: Curves.elasticInOut,
                                        cycles: 0,
                                        builder: (BuildContext? context,
                                                AnimatorState? animatorState,
                                                Widget? child) =>
                                            Transform.scale(
                                              scale: animatorState!.value!
                                                  .toDouble(),
                                              child: const Icon(
                                                Icons.favorite,
                                                size: 80,
                                                color: kPrimaryColor,
                                              ),
                                            ))
                                    : const Offstage(),
                                uVm.isUnlikeAnimate
                                    ? Animator(
                                        duration:
                                            const Duration(milliseconds: 300),
                                        tween: Tween(begin: 0.2, end: 1),
                                        curve: Curves.elasticInOut,
                                        cycles: 0,
                                        builder: (BuildContext? context,
                                                AnimatorState? animatorState,
                                                Widget? child) =>
                                            Transform.scale(
                                              scale: animatorState!.value!
                                                  .toDouble(),
                                              child: const Icon(
                                                Icons.thumb_down,
                                                size: 80,
                                                color: kPrimaryColor,
                                              ),
                                            ))
                                    : const Offstage()
                              ],
                            ),
                            StoryLineScreen(
                              name: pVm.selectedUser!.fullName!.isEmpty
                                  ? 'User'
                                  : pVm.selectedUser!.fullName,
                              userId: pVm.selectedUser!.userId,
                            ),
                          ],
                        ),
                      ),
                      backgroundColor: Colors.white,
                      floatingActionButtonLocation:
                          FloatingActionButtonLocation.centerFloat,
                      floatingActionButton: Padding(
                        padding: const EdgeInsets.only(left: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            acctionButton('cancel_icon', () {
                              uVm.dislikeUser(pVm.selectedUser!.userId!);
                            }),
                            acctionButton('love_icon', () {
                              uVm.likeUser(
                                  likedUid: pVm.selectedUser!.userId!,
                                  likedPhotoUrl:
                                      pVm.selectedUser!.photoUrl!.isNotEmpty
                                          ? pVm.selectedUser!.photoUrl!
                                          : '',
                                  likedUserName: pVm.selectedUser!.displayName!,
                                  likedLat: pVm.selectedUser!.lat!,
                                  likedLng: pVm.selectedUser!.lng!,
                                  likedAge: pVm.selectedUser!.age!,
                                  likedCity: pVm.selectedUser!.city!,isVerified: pVm.selectedUser!.isVerified! );
                            }),
                            acctionButton('chat_icon', () async {
                              FirebaseFirestore.instance.collection("blockUser").doc(FirebaseAuth.instance.currentUser!.uid).get().then((value) {
                                if(value.exists){

                                }else{
                                  FirebaseFirestore.instance.collection("blockUser").doc(FirebaseAuth.instance.currentUser!.uid).set({
                                    "whoBlcck":[]
                                  });
                                }
                              });

                              FirebaseFirestore.instance.collection("blockUser").doc( pVm.selectedUser?.userId).get().then((value) {
                                if(value.exists){

                                }else{
                                  FirebaseFirestore.instance.collection("blockUser").doc( pVm.selectedUser?.userId).set({
                                    "whoBlcck":[]
                                  });
                                }
                              });


                              String roomId = chatRid(
                                  pVm.firebaseInstance.currentUser!.uid,
                                  pVm.selectedUser!.userId!);
                              await Navigator.of(context)
                                  .push(MaterialPageRoute(
                                      builder: ((context) => ConversationScreen(
                                          callId: pVm.selectedUser!.userId!+FirebaseAuth.instance.currentUser!.uid,
                                          profilePix:
                                              pVm.selectedUser!.photoUrl!,
                                          userNameD:
                                              pVm.selectedUser!.fullName!,
                                          online: "Online",
                                          chatID: roomId,
                                          ide: pVm.selectedUser!.userId!,
                                          count: '1',
                                          block: false, coin: pVm.cachedUserDetail!.coinBalance!.toString(),balance: pVm.cachedUserDetail!.balance!.toString(),))))
                                  .then((value) {});
                            }),
                          ],
                        ),
                      ));
                });
          }),
    );
  }

  Widget customRow(String url, String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Image(
          image: AssetImage(
            "assets/icons/$url.png",
          ),
          height: 15,
          width: 15,
        ),
        const SizedBox(width: 8.0),
        Text(
          title,
          style: GoogleFonts.poppins(
              textStyle: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w300,
            fontSize: 12,
          )),
        ),
      ],
    );
  }

  Widget acctionButton(String image, VoidCallback callback) {
    return GestureDetector(
      onTap: callback,
      child: Image.asset(
        "assets/icons/$image.png",
        height: 80,
        width: 90,
      ),
    );
  }
}
