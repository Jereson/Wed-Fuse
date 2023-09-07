import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wedme1/getit.dart';
import 'package:wedme1/models/users_detail_model.dart';
import 'package:wedme1/screens/home_page/detail_homepage.dart';
import 'package:wedme1/utils/local_storage_utils.dart';
import 'package:wedme1/viewModel/profile_vm.dart';

class HomeShowGridView extends StatefulWidget {
  const HomeShowGridView({Key? key, this.userDetail, required this.indexTwo}) : super(key: key);
  final UsersDetailModel? userDetail;
    final int indexTwo;

  @override
  State<HomeShowGridView> createState() => _HomeShowGridViewState();
}

class _HomeShowGridViewState extends State<HomeShowGridView> {
  List banerImages = [];
  bool? showDistance;
  bool? showAge;
  // final CarouselController _controller = CarouselController();
  @override
  void initState() {
    banerImages = widget.userDetail!.bannerPic!.isEmpty
        ? widget.userDetail!.altBannerPic!
        : widget.userDetail!.bannerPic!;

    showDistance = getIt.get<LocalStorage>().getShowDistance() ?? false;
    showAge = getIt.get<LocalStorage>().getShowAge() ?? false;

    print('show bbbb  $showAge');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        getIt.get<ProfileViewModel>().setSelectedUser(widget.userDetail!);
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return DetailHomescreen(index: widget.indexTwo);
        }));
      },
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              color: Colors.red,
              height: 160,
              width: double.infinity,
              // width: ,
              child: CachedNetworkImage(
                imageUrl: banerImages[0],
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    const CupertinoActivityIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
              bottom: 16,
              left: 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      RichText(
                          overflow: TextOverflow.clip,
                          textAlign: TextAlign.end,
                          textDirection: TextDirection.rtl,
                          maxLines: 1,
                          textScaleFactor: 1,
                          text: TextSpan(
                              text:
                                  '${widget.userDetail!.fullName!.split(' ').first},',
                              style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 16.sp,
                              )),
                              children: [
                                TextSpan(
                                  text: '${widget.userDetail!.age!}',
                                  style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16.sp,
                                  )),
                                )
                              ])),
                      const SizedBox(width: 5),
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
                      const Image(
                        image: AssetImage("assets/icons/house_white_icon.png"),
                        height: 10,
                        width: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 6),
                        child: Text(
                          widget.userDetail!.city!.isNotEmpty
                              ? widget.userDetail!.city!
                              : "*****",
                          style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w200,
                            fontSize: 12.sp,
                          )),
                        ),
                      ),
                    ],
                  ),
                  if (!showDistance!)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Image(
                            image: AssetImage("assets/icons/loc_white_icon.png"),
                            height: 10,
                            width: 10),
                        Padding(
                          padding: const EdgeInsets.only(left: 6),
                          child: Text(
                            '12 miles away',
                            style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w200,
                              fontSize: 11.sp,
                            )),
                          ),
                        ),
                        SizedBox(
                          width: 8.w,
                        ),
                        const Image(
                            image: AssetImage("assets/icons/info_icon.png"),
                            height: 10,
                            width: 10),
                        SizedBox(
                          width: 1.h,
                        ),
                      ],
                    ),
                ],
              ))
        ],
      ),
    );
  }
}
