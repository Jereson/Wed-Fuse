import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wedme1/getit.dart';
import 'package:wedme1/models/users_detail_model.dart';
import 'package:wedme1/screens/home_page/detail_homepage.dart';
import 'package:wedme1/utils/local_storage_utils.dart';
import 'package:wedme1/viewModel/profile_vm.dart';
import 'button_widget.dart';
import 'package:card_swiper/card_swiper.dart';

class UserItem extends StatefulWidget {
  final UsersDetailModel? userDetail;
  final int indexTwo;
  const UserItem({Key? key, this.userDetail, required this.indexTwo})
      : super(key: key);

  @override
  State<UserItem> createState() => _UserItemState();
}

class _UserItemState extends State<UserItem> {
  int currentIndex = 0;
  List banerImages = [];
  bool? showDistance;
  bool? showAge;
  final pVm = getIt.get<ProfileViewModel>();
  final CarouselController _controller = CarouselController();
  @override
  void initState() {
    banerImages = widget.userDetail!.bannerPic!.isEmpty
        ? widget.userDetail!.altBannerPic!
        : widget.userDetail!.bannerPic!;

    showDistance = getIt.get<LocalStorage>().getShowDistance() ?? false;
    showAge = getIt.get<LocalStorage>().getShowAge() ?? false;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        pVm.setSelectedUser(widget.userDetail!);
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return DetailHomescreen(index: widget.indexTwo);
        }));
      },
      child: Padding(
        // padding: const EdgeInsets.only(bottom: 20),

        padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 25.0),
        child: Stack(children: [
          Container(
            decoration: BoxDecoration(
                // color: Colors.transparent,
                borderRadius: BorderRadius.circular(15),
                boxShadow: pVm.isHomeShowGrid
                    ? []
                    : const [
                        BoxShadow(
                            color: Colors.black12,
                            blurRadius: 2.0,
                            offset: Offset(
                              0.0,
                              10.0,
                            ))
                      ]),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Container(
                foregroundDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    gradient: const LinearGradient(
                        colors: [Colors.black, Colors.transparent],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        tileMode: TileMode.mirror,
                        stops: [0.0, 0.5])),
                child: banerImages.length == 1
                    ? SizedBox(
                        height: MediaQuery.of(context).size.height * 0.75,
                        width: double.infinity,
                        child: CachedNetworkImage(
                          imageUrl: banerImages[0],
                          progressIndicatorBuilder:
                              (context, url, downloadProgress) =>
                                  const CupertinoActivityIndicator(),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                          fit: BoxFit.cover,
                        ),
                      )
                    : pVm.isHomeShowGrid
                        ? Swiper(
                            onIndexChanged: (value) {
                              setState(() {
                                currentIndex = value;
                              });
                            },
                            itemBuilder: (BuildContext context, int index) {
                              return SizedBox(
                                width: double.infinity,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: CachedNetworkImage(
                                    imageUrl: banerImages[index],
                                    progressIndicatorBuilder:
                                        (context, url, downloadProgress) =>
                                            const CupertinoActivityIndicator(),
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.error),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              );
                            },
                            allowImplicitScrolling: true,
                            outer: true,
                            itemCount: banerImages.length,
                            // itemHeight: 500,
                            itemWidth: MediaQuery.of(context).size.width * 0.9,
                            layout: SwiperLayout.STACK,
                          )
                        : CarouselSlider(
                            carouselController: _controller,
                            items: banerImages.map((image) {
                              return SizedBox(
                                width: double.infinity,
                                child: CachedNetworkImage(
                                  imageUrl: image,
                                  progressIndicatorBuilder:
                                      (context, url, downloadProgress) =>
                                          const CupertinoActivityIndicator(),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                  fit: BoxFit.cover,
                                ),
                              );
                            }).toList(),
                            options: CarouselOptions(
                              height: MediaQuery.of(context).size.height * 0.75,
                              aspectRatio: 1,
                              viewportFraction: 1,
                              initialPage: 0,
                              enableInfiniteScroll: false,
                              reverse: false,
                              autoPlay: false,
                              // scrollPhysics: pVm.isHomeShowGrid
                              //     ? const NeverScrollableScrollPhysics()
                              //     : const ClampingScrollPhysics(),
                              autoPlayInterval: const Duration(seconds: 3),
                              autoPlayAnimationDuration:
                                  const Duration(milliseconds: 800),
                              // autoPlayCurve: Curves.fastOutSlowIn,
                              enlargeCenterPage: false,
                              enlargeFactor: 1,
                              onPageChanged: (carouselIndex, reason) {
                                setState(() {
                                  currentIndex = carouselIndex;
                                });
                              },
                              scrollDirection: Axis.horizontal,
                            )),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 20.0,
              bottom: 20,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        widget.userDetail!.fullName!.isNotEmpty
                            ? widget.userDetail!.fullName!.split(' ').first
                            : 'User',
                        overflow: TextOverflow.fade,
                        softWrap: false,
                        style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 24,
                        )),
                      ),
                    ),
                    // if (showAge!)
                    Text(
                      ', ${widget.userDetail!.age}yr',
                      style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: 18,
                      )),
                    ),
                    Icon(
                      Icons.verified,
                      size: 19,
                      color: widget.userDetail!.isVerified!
                          ? Colors.blue
                          : Colors.grey,
                    )
                  ],
                ),
                Row(
                  children: [
                    Row(
                      children: [
                        const Image(
                          image: AssetImage("assets/icons/red_love.png"),
                          height: 15,
                          width: 13,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 2.0),
                          child: Text(
                            widget.userDetail!.marriageRadyness!.isNotEmpty
                                ? ' ${widget.userDetail!.marriageRadyness!}'
                                : ' ******',
                            style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              fontSize: 11,
                            )),
                          ),
                        ),
                      ],
                    ),
                    showDistance!
                        ? Align(
                            alignment: Alignment.centerLeft,
                            child: MilesButtonWidget(
                                size: size / 5, text: "31 miles", press: () {}),
                          )
                        : const Offstage()
                  ],
                ),
                Row(
                  children: [
                    const Image(
                      image: AssetImage("assets/icons/red_location.png"),
                      width: 13,
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 2.0),
                      child: Text(
                        widget.userDetail!.city!.isNotEmpty
                            ? widget.userDetail!.city!
                            : ' ********',
                        maxLines: 1,
                        style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontSize: 11,
                        )),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // if (pVm.isHomeShowGrid)
          //   Positioned(
          //       top: size.height * 0.35,
          //       left: 0,
          //       child: IconButton(
          //         icon: const Icon(Icons.keyboard_double_arrow_left_outlined),
          //         onPressed: () {
          //           setState(() {
          //             _controller.previousPage();
          //           });
          //         },
          //       )),
          // if (pVm.isHomeShowGrid)
          //   Positioned(
          //       top: size.height * 0.35,
          //       right: 0,
          //       child: IconButton(
          //         icon: const Icon(Icons.keyboard_double_arrow_right_outlined),
          //         onPressed: () {
          //           setState(() {
          //             _controller.nextPage();
          //           });
          //         },
          //       )),
          Positioned(
            top: 10,
            right: 10,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: banerImages.asMap().entries.map((entry) {
                return Container(
                  width: 30.0,
                  height: 2.0,
                  margin: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 4.0),
                  decoration: BoxDecoration(
                      color: Colors.white
                          .withOpacity(currentIndex == entry.key ? 0.9 : 0.4)),
                );
              }).toList(),
            ),
          )
        ]),
      ),
    );
  }
}
