import 'package:blur/blur.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wedme1/getit.dart';
import 'package:wedme1/utils/base_view_builder.dart';
import 'package:wedme1/viewModel/profile_vm.dart';
import 'package:wedme1/viewModel/user_reaction.dart';
import 'package:sizer/sizer.dart';
import 'package:wedme1/models/like_model.dart';
import 'package:wedme1/widget/upgraded_match_list_item.dart';
import 'button_widget.dart';

class WhoLikedMeWidget extends StatelessWidget {
  const WhoLikedMeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseViewBuilder<ProfileViewModel>(
        model: getIt(),
        builder: (pVm, _) {
          return BaseViewBuilder<UserReactionVm>(
            model: getIt(),
            initState: (init) {
              init.getWhoLikedMe();
            },
            builder: (uVm, _) {
              return uVm.whoLikedMeModel == null && !uVm.isWhoLikeMeLoading
                  ? const Center(
                      child: CupertinoActivityIndicator(),
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'View people who have liked your profile',
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              fontWeight: FontWeight.w200,
                              color: Colors.black,
                              fontSize: 14.sp,
                            ),
                          ),
                        ),
                        uVm.whoLikedMeList.isEmpty
                            ? const Expanded(
                                child: Center(
                                  child: Text('No match yet'),
                                ),
                              )
                            : Expanded(
                                child: !uVm.isLikeGrid
                                    ? ListView.builder(
                                        physics: const BouncingScrollPhysics(),
                                        itemCount: uVm.whoLikedMeList.length,
                                        itemBuilder: ((context, index) {
                                          return !pVm.validateSubscriptionStus(pVm
                                                      .cachedUserDetail!
                                                      .subscriptionDueDate!) ||
                                                  !pVm.cachedUserDetail!
                                                      .isVerified! ||
                                                  pVm.cachedUserDetail!
                                                          .subscriptionType! ==
                                                      'freemium'
                                              ? Blur(
                                                  blur: 5,
                                                  child: WhoLikedMeListView(
                                                    likeModel: uVm
                                                        .whoLikedMeList[index],
                                                  ),
                                                )
                                              : WhoLikedMeListView(
                                                  likeModel:
                                                      uVm.whoLikedMeList[index],
                                                );
                                        }))
                                    : GridView.builder(
                                        physics: const BouncingScrollPhysics(),
                                        itemCount: uVm.whoLikedMeList.length,
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 2,
                                                crossAxisSpacing: 1.0,
                                                mainAxisSpacing: 1.0),
                                        itemBuilder: ((context, index) {
                                          return !pVm.validateSubscriptionStus(pVm
                                                      .cachedUserDetail!
                                                      .subscriptionDueDate!) ||
                                                  !pVm.cachedUserDetail!
                                                      .isVerified! ||
                                                  pVm.cachedUserDetail!
                                                          .subscriptionType! ==
                                                      'freemium'
                                              ? Blur(
                                                  blur: 20,
                                                  child: WhoLikedMeGridView(
                                                    likeModel: uVm
                                                        .whoLikedMeList[index],
                                                  ),
                                                )
                                              : WhoLikedMeGridView(
                                                  likeModel:
                                                      uVm.whoLikedMeList[index],
                                                );
                                        }),
                                      ),
                              )
                      ],
                    );
            },
          );
        });
  }
}

class WhoLikedMeListView extends StatelessWidget {
  const WhoLikedMeListView({
    Key? key,
    this.likeModel,
  }) : super(key: key);
  final LikeModel? likeModel;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(
        top: 30,
        left: 8,
      ),
      child: Column(
        children: [
          Container(
            // color: Colors.red,
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Stack(
                  children: [
                    Container(
                      // alignment: Alignment.center,
                      height: 40,
                      width: 40,
                      decoration: const BoxDecoration(
                          color: Colors.grey, shape: BoxShape.circle),
                      child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        imageUrl: likeModel!.photoUrl!,
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) =>
                                const CupertinoActivityIndicator(),
                        errorWidget: (context, url, error) => Center(
                            child: Text(
                          likeModel!.userName![0],
                          style: TextStyle(
                              fontSize: 16.sp, fontWeight: FontWeight.bold),
                        )),
                      ),
                    ),
                    Positioned(
                      bottom: -8,
                      right: -8,
                      child: CircleAvatar(
                        radius: 14,
                        backgroundColor: Colors.transparent,
                        child: Icon(
                          Icons.verified,
                          color: likeModel!.isVerified!
                              ? const Color(0xFF0057FF)
                              : Colors.grey,
                          size: 12,
                        ),
                      ),
                    ),
                  ],
                ),
                Text(
                  likeModel!.userName!,
                  style: TextStyle(fontSize: 16.sp),
                ),
                SizedBox(
                  width: 30.w,
                ),
                MilesButtonWidget(
                    size: size / 4, text: "31 miles", press: () {}),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
