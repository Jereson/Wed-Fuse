import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:wedme1/models/like_model.dart';
import 'button_widget.dart';

class MyMatchListView extends StatelessWidget {
  const MyMatchListView({
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
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: const BoxDecoration(
                            color: Colors.grey, shape: BoxShape.circle),
                        child: CachedNetworkImage(
                          imageUrl: likeModel!.photoUrl!,
                          fit: BoxFit.cover,
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
