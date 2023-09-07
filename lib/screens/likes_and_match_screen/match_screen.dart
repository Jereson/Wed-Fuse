import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:wedme1/getit.dart';
import 'package:wedme1/utils/base_view_builder.dart';
import 'package:wedme1/viewModel/profile_vm.dart';
import 'package:wedme1/viewModel/user_reaction.dart';
import 'package:wedme1/widget/un_upgraded_match_list_item.dart';
import 'package:wedme1/widget/upgraded_match_list_item.dart';
import 'package:wedme1/widget/who_like_me_widget.dart';

class MatchScreen extends StatefulWidget {
  const MatchScreen({Key? key}) : super(key: key);

  @override
  State<MatchScreen> createState() => _MatchScreenState();
}

class _MatchScreenState extends State<MatchScreen> {
  // bool isClick = false;
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final profile = getIt.get<ProfileViewModel>();

    return SafeArea(
      child: BaseViewBuilder<UserReactionVm>(
          model: getIt(),
          initState: (init) {
            init.getWhoILike();
          },
          builder: (uVm, _) {
            return Scaffold(
              appBar: PreferredSize(
                preferredSize: const Size.fromHeight(150),
                child: Padding(
                  padding: const EdgeInsets.only(right: 18, left: 20),
                  child: Column(
                    children: [
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                radius: 22,
                                backgroundImage: NetworkImage(
                                    profile.cachedUserDetail!.photoUrl!),
                                child: Stack(
                                  children: [
                                    Positioned(
                                      bottom: -10,
                                      right: -10,
                                      child: CircleAvatar(
                                        radius: 18,
                                        backgroundColor: Colors.transparent,
                                        child: Icon(
                                          Icons.verified,
                                          color: getIt
                                                  .get<ProfileViewModel>()
                                                  .cachedUserDetail!
                                                  .isVerified!
                                              ? const Color(0xFF0057FF)
                                              : Colors.grey,
                                          size: 10,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: size.width / 5,
                              ),
                              SizedBox(
                                child: Image.asset(
                                  'assets/images/webfuse-logo.png',
                                  height: 100,
                                  width: 100,
                                ),
                              ),
                            ],
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: IconButton(
                                onPressed: () => uVm.setIslikeGridView(),
                                icon: Icon(
                                  uVm.isLikeGrid
                                      ? Icons.grid_view_rounded
                                      : Icons.format_list_bulleted,
                                  size: 28,
                                  color: Colors.black,
                                )),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: DefaultTabController(
                      length: 2,
                      initialIndex: 0,
                      child: Builder(builder: (context) {
                        final TabController tabController =
                            DefaultTabController.of(context);
                        tabController.addListener(() {
                          if (!tabController.indexIsChanging) {
                            setState(() {
                              currentIndex = tabController.index;
                            });
                          }
                        });
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Container(
                              alignment: Alignment.topCenter,
                              child: TabBar(
                                  onTap: (value) {},
                                  isScrollable: true,
                                  indicatorColor: Colors.red,
                                  labelStyle:
                                      const TextStyle(color: Colors.black),
                                  tabs: [
                                    Tab(
                                      child: Text(
                                        "Your Match",
                                        style: GoogleFonts.poppins(
                                            textStyle: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16,
                                        )),
                                      ),
                                    ),
                                    Tab(
                                      child: Text(
                                        "See Who likes You",
                                        style: GoogleFonts.poppins(
                                            textStyle: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16,
                                        )),
                                      ),
                                    )
                                  ]),
                            ),
                            SizedBox(height: 2.h),
                            const Expanded(
                              child: TabBarView(
                                  physics: BouncingScrollPhysics(),
                                  dragStartBehavior: DragStartBehavior.down,
                                  children: [
                                    MyMatchWidget(),
                                    WhoLikedMeWidget(),
                                  ]),
                            )
                          ],
                        );
                      }),
                    ),
                  )
                ],
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerFloat,
              floatingActionButton: currentIndex == 1 &&
                      (!profile.validateSubscriptionStus(
                              profile.cachedUserDetail!.subscriptionDueDate!) ||
                          !profile.cachedUserDetail!.isVerified! ||
                          profile.cachedUserDetail!.subscriptionType! ==
                              'freemium')
                  ? Container(
                      color: Colors.transparent,
                      height: 45,
                      width: 250,
                      child: FloatingActionButton(
                        splashColor: const Color(0xFFFDFD96),
                        backgroundColor:
                            const Color(0xFFFDFD96).withOpacity(0.8),
                        focusColor: const Color(0xFFFDFD96),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.horizontal(
                            right: Radius.circular(30),
                            left: Radius.circular(30),
                          ),
                        ),
                        onPressed: () {
                          // addFeedFunction();
                        },
                        child: Text(
                          'Upgrade Account to View',
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    )
                  : SizedBox.fromSize(),
            );
          }),
    );
  }
}

class MyMatchWidget extends StatelessWidget {
  const MyMatchWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseViewBuilder<UserReactionVm>(
      model: getIt(),
      initState: (init) {
        init.getWhoILike();
      },
      builder: (uVm, _) {
        return uVm.likeModel == null && !uVm.isMyMatchLoading
            ? const Center(
                child: CupertinoActivityIndicator(),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'These are people that match with you',
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        fontWeight: FontWeight.w200,
                        color: Colors.black,
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
                  uVm.myMatchList.isEmpty
                      ? const Expanded(
                          child: Center(
                            child: Text('You do not have match yet'),
                          ),
                        )
                      : Expanded(
                          child: !uVm.isLikeGrid
                              ? ListView.builder(
                                  physics: const BouncingScrollPhysics(),
                                  itemCount: uVm.myMatchList.length,
                                  itemBuilder: ((context, index) {
                                    return MyMatchListView(
                                      likeModel: uVm.myMatchList[index],
                                    );
                                  }))
                              : GridView.builder(
                                  physics: const BouncingScrollPhysics(),
                                  itemCount: uVm.myMatchList.length,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          crossAxisSpacing: 1.0,
                                          mainAxisSpacing: 1.0),
                                  itemBuilder: ((context, index) {
                                    return GestureDetector(
                                      onTap: () {},
                                      child: MyMatchGridViewView(
                                        likeModel: uVm.myMatchList[index],
                                      ),
                                    );
                                  }),
                                ),
                        )
                ],
              );
      },
    );
  }
}
