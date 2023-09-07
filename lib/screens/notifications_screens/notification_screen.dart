import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wedme1/constants/colors.dart';
import 'package:wedme1/getit.dart';
import 'package:wedme1/utils/base_view_builder.dart';
import 'package:wedme1/viewModel/user_reaction.dart';
import 'package:wedme1/utils/string_utils.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xFFF9F9F9),
        elevation: 0.0,
        title: Text(
          'Notification',
          style: GoogleFonts.inter(
              color: const Color(0xFF010101),
              fontSize: 29,
              fontWeight: FontWeight.w600),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.more_vert_outlined,
                color: Colors.black,
              ))
        ],
      ),
      body: BaseViewBuilder<UserReactionVm>(
          model: getIt(),
          initState: (init) {
            init.getUserNotification();
          },
          builder: (uVm, _) {
            return !uVm.notificationLoaded
                ? const Center(
                    child: CupertinoActivityIndicator(),
                  )
                : uVm.notificationModel.isEmpty
                    ? const Center(
                        child: Text("You don't have notification yet"),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.all(20),
                        itemCount: uVm.notificationModel.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  uVm.notificationModel[index].date!.toDate,
                                  style: GoogleFonts.inter(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12,
                                      color: const Color(0xFF222222)),
                                ),
                                const SizedBox(height: 8),
                                Stack(
                                  children: [
                                    Container(
                                      alignment: Alignment.center,
                                      // padding: const EdgeInsets.all(10),
                                      height: 110,
                                      decoration: const BoxDecoration(
                                          color: Colors.white),
                                      child: Row(children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          child: Container(
                                            height: 44,
                                            width: 44,
                                            decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: kPrimaryColor),
                                            child: CachedNetworkImage(
                                              imageUrl: uVm
                                                  .notificationModel[index]
                                                  .image!,
                                              progressIndicatorBuilder: (context,
                                                      url, downloadProgress) =>
                                                  const CupertinoActivityIndicator(),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      const Icon(
                                                          Icons.broken_image),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 13),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            RichText(
                                              text: TextSpan(
                                                text: uVm
                                                    .notificationModel[index]
                                                    .userName,
                                                children: [
                                                  TextSpan(
                                                      text:
                                                          ' ${uVm.notificationModel[index].message}',
                                                      style: GoogleFonts.inter(
                                                          fontSize: 11))
                                                ],
                                                style: GoogleFonts.inter(
                                                    color: Colors.black,
                                                    fontSize: 13,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ),
                                            Text(
                                              uVm.notificationModel[index].date!
                                                  .toTime,
                                              style: GoogleFonts.inter(
                                                  fontSize: 11,
                                                  color:
                                                      const Color(0xFF464646)),
                                            ),
                                            const SizedBox(width: 30),
                                            const SizedBox(
                                              height: 33,
                                              width: 70,
                                            ),
                                          ],
                                        ),
                                      ]),
                                    ),
                                    if (uVm.notificationModel[index].type ==
                                        'giftCoin')
                                      Positioned(
                                          top: 1,
                                          right: 1,
                                          child: Container(
                                            alignment: Alignment.center,
                                            height: 24,
                                            width: 24,
                                            decoration: const BoxDecoration(
                                                image: DecorationImage(
                                                    image: AssetImage(
                                                        'assets/images/money-recive.png'),
                                                    fit: BoxFit.fill)),
                                            child: const Text(
                                              'C',
                                              style: TextStyle(
                                                  color: kPrimaryColor,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                          )),
                                    Positioned(
                                        bottom: 10,
                                        right: 15,
                                        child: Row(
                                          children: [
                                            GestureDetector(
                                              onTap: () => uVm.rejectRequest(
                                                  context,
                                                  uVm.notificationModel[index]
                                                      .userId!,
                                                  uVm.notificationModel[index]
                                                      .id!),
                                              child: Container(
                                                alignment: Alignment.center,
                                                height: 33,
                                                width: 70,
                                                decoration: BoxDecoration(
                                                  color: uVm
                                                              .notificationModel[
                                                                  index]
                                                              .status!
                                                              .toLowerCase() ==
                                                          'rejected'
                                                      ? kPrimaryColor
                                                      : Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  border: Border.all(
                                                      color: uVm
                                                                  .notificationModel[
                                                                      index]
                                                                  .status!
                                                                  .toLowerCase() ==
                                                              'rejected'
                                                          ? kPrimaryColor
                                                          : const Color(
                                                              0xFF3D3D3D),
                                                      width: 0.5),
                                                ),
                                                child: Text(
                                                  'Reject',
                                                  style: GoogleFonts.inter(
                                                      fontSize: 11,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: uVm
                                                                  .notificationModel[
                                                                      index]
                                                                  .status!
                                                                  .toLowerCase() ==
                                                              'rejected'
                                                          ? Colors.white
                                                          : const Color(
                                                              0xFF3D3D3D)),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 10),
                                            GestureDetector(
                                              onTap: uVm
                                                          .notificationModel[
                                                              index]
                                                          .status!
                                                          .toLowerCase() ==
                                                      'accepted'
                                                  ? null
                                                  : () => uVm.acceptRequest(
                                                      context,
                                                      uVm
                                                          .notificationModel[
                                                              index]
                                                          .userId!,
                                                      uVm
                                                          .notificationModel[
                                                              index]
                                                          .id!),
                                              child: Container(
                                                alignment: Alignment.center,
                                                height: 33,
                                                width: 70,
                                                decoration: BoxDecoration(
                                                    color: uVm
                                                                .notificationModel[
                                                                    index]
                                                                .status!
                                                                .toLowerCase() ==
                                                            'rejected'
                                                        ? Colors.white
                                                        : uVm
                                                                    .notificationModel[
                                                                        index]
                                                                    .status!
                                                                    .toLowerCase() ==
                                                                'accepted'
                                                            ? Colors.green
                                                            : kPrimaryColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    border: Border.all(
                                                        color: uVm
                                                                    .notificationModel[
                                                                        index]
                                                                    .status!
                                                                    .toLowerCase() ==
                                                                'rejected'
                                                            ? const Color(
                                                                0xFF3D3D3D)
                                                            : uVm.notificationModel[index]
                                                                        .status!
                                                                        .toLowerCase() ==
                                                                    'accepted'
                                                                ? Colors.green
                                                                : kPrimaryColor,
                                                        width: 0.5)),
                                                child: Text(
                                                  uVm.notificationModel[index]
                                                              .status!
                                                              .toLowerCase() ==
                                                          'accepted'
                                                      ? 'Accepted'
                                                      : 'Accept',
                                                  style: GoogleFonts.inter(
                                                      fontSize: 11,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: uVm
                                                                  .notificationModel[
                                                                      index]
                                                                  .status!
                                                                  .toLowerCase() ==
                                                              'rejected'
                                                          ? const Color(
                                                              0xFF3D3D3D)
                                                          : const Color(
                                                              0xFFFFFFFF)),
                                                ),
                                              ),
                                            )
                                          ],
                                        ))
                                  ],
                                )
                              ],
                            ),
                          );
                        });
          }),
    );
  }
}
