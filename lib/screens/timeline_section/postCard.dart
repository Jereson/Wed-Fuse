import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:wedme1/models/discover_model.dart';

import '../../constants/colors.dart';

class DiscoverItem extends StatelessWidget {
  const DiscoverItem({Key? key, this.timeLineModel}) : super(key: key);
  final DiscoverModel? timeLineModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: const Color(0XFF1ECCD7),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8, top: 12),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundImage: AssetImage(timeLineModel!.senderImg!),
                      ),
                      const SizedBox(width: 7),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            timeLineModel!.senderName!,
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            timeLineModel!.timestamp!,
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                fontSize: 10.sp,
                                color: const Color.fromARGB(255, 24, 21, 21),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      (timeLineModel!.imgContent!.isEmpty)
                          ? Text(
                        timeLineModel!.distance!,
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 8.sp,
                              color: kPrimaryColor),
                        ),
                      )
                          : const Icon(Icons.more_vert),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Text(
                timeLineModel!.textContent!,
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    fontWeight: FontWeight.w300,
                    fontSize: 12.sp,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              (timeLineModel!.imgContent!.isEmpty ||
                  timeLineModel!.contentType! == "textonly")
                  ? Container()
                  : Image.asset(timeLineModel!.imgContent!),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        timeLineModel!.timeAgo!,
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w300,
                            color: Colors.red[600],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Image.asset(
                        "assets/icons/coin.png",
                        height: 18,
                        width: 18,
                      ),
                      const SizedBox(width: 7),
                      Image.asset(
                        "assets/icons/black_love.png",
                        height: 18,
                        width: 18,
                      ),
                      const SizedBox(width: 7),
                      Image.asset(
                        "assets/icons/dis_settings.png",
                        width: 18,
                        height: 18,
                      ),
                      const SizedBox(width: 7),
                      Image.asset(
                        "assets/icons/dis_chat.png",
                        height: 18,
                        width: 18,
                      )
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
