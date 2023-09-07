import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:wedme1/models/like_model.dart';

class MyMatchGridViewView extends StatelessWidget {
  const MyMatchGridViewView({Key? key, this.likeModel}) : super(key: key);
  final LikeModel? likeModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 4, right: 4, top: 6),
      padding: const EdgeInsets.only(left: 8, bottom: 10),
      decoration: BoxDecoration(
        // color: Colors.red,
        borderRadius: BorderRadius.circular(12),
        image: DecorationImage(
            image: NetworkImage(likeModel!.photoUrl!),
            // AssetImage(userModel!.image![imageIndex!]),
            fit: BoxFit.cover),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
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
                          text: '${likeModel!.userName ?? '***'},',
                          style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 16.sp,
                          )),
                          children: [
                            TextSpan(
                              text: '${likeModel!.age ?? '***'}',
                              style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                                fontSize: 16.sp,
                              )),
                            )
                          ])),
                  Icon(
                    Icons.verified,
                    color: likeModel!.isVerified!
                        ? const Color(0xFF0057FF)
                        : Colors.grey,
                    size: 12,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
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
                      likeModel!.city ?? '***',
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
          )
        ],
      ),
    );
  }
}

class WhoLikedMeGridView extends StatelessWidget {
  const WhoLikedMeGridView({Key? key, this.likeModel}) : super(key: key);
  final LikeModel? likeModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, right: 4, top: 6),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          image: DecorationImage(
              image: NetworkImage(likeModel!.photoUrl!),
              // AssetImage(userModel!.image![imageIndex!]),
              fit: BoxFit.cover),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 8, bottom: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
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
                              text: '${likeModel!.userName!},',
                              style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 16.sp,
                              )),
                              children: [
                                TextSpan(
                                  text: '${likeModel!.age!}',
                                  style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16.sp,
                                  )),
                                )
                              ])),
                      Icon(
                        Icons.verified,
                        color: likeModel!.isVerified!
                            ? const Color(0xFF0057FF)
                            : Colors.grey,
                        size: 10,
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
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
                          likeModel!.city!,
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
