import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'CommentPost.dart';
import 'SharePost.dart';
import 'ShowTimeLinePicture.dart';

class DiscoverItem extends ConsumerWidget {
  const DiscoverItem(
      {Key? key,
      required this.imgUrl,
      required this.profileImageUrl,
      required this.userName,
      required this.countShow,
      required this.dateUpload,
      required this.like,
      required this.listImage,
      required this.id,
      required this.share,
      required this.date,
      required this.comments,
      required this.iconOnPressed,
      required this.textPose})
      : super(key: key);

  final String imgUrl;
  final String profileImageUrl;
  final String userName;
  final int like;
  final String dateUpload;
  final String textPose;
  final String id;
  final String date;
  final List countShow;
  final List listImage;
  final int comments;
  final int share;
  final Function()? iconOnPressed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const contentType = 'image';
    const isTypeImage = contentType == 'image';
    const isTypeText = contentType == 'text';
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundImage: NetworkImage(profileImageUrl),
                      ),
                      const SizedBox(width: 7),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            // onTap: () => navigateToUser(context),
                            child: Text(
                              userName,
                              style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                          Text(
                            dateUpload,
                            style: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                                fontSize: 15,
                                color: Color.fromARGB(255, 24, 21, 21),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          const SizedBox(height: 5),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        onPressed: iconOnPressed,
                        icon: const Icon(
                          Icons.more_vert_rounded,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 5),
              if (isTypeImage) Text(textPose),
              const SizedBox(height: 10),
              if (listImage.isEmpty)
                Container()
              else if (listImage.length <= 3)
                SizedBox(
                  height: 248,
                  width: double.infinity,
                  child: listImage.length == 1
                      ? Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            ShowTimeLinePicture(
                                          listImage: listImage[0].toString(),
                                        ),
                                      ));
                                },
                                child: Container(
                                  height: 210,
                                  decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(16)),
                                      image: DecorationImage(
                                          image: NetworkImage(listImage[0]),
                                          fit: BoxFit.cover),),
                                ),
                              ),
                            ),
                          ],
                        )
                      : listImage.length == 2
                          ? Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      ShowTimeLinePicture(
                                                    listImage:
                                                        listImage[0].toString(),
                                                  ),
                                                ));
                                          },
                                          child: Container(
                                            height: 200,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    const BorderRadius.only(
                                                        topLeft:
                                                            Radius.circular(16),
                                                        bottomLeft:
                                                            Radius.circular(
                                                                16)),
                                                image: DecorationImage(
                                                    image: NetworkImage(
                                                        listImage[0]),
                                                    fit: BoxFit.cover)),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      ShowTimeLinePicture(
                                                    listImage:
                                                        listImage[1].toString(),
                                                  ),
                                                ));
                                          },
                                          child: Container(
                                            height: 200,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    const BorderRadius.only(
                                                        topRight:
                                                            Radius.circular(16),
                                                        bottomRight:
                                                            Radius.circular(
                                                                16)),
                                                image: DecorationImage(
                                                    image: NetworkImage(
                                                        listImage[1]),
                                                    fit: BoxFit.cover)),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          : Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      ShowTimeLinePicture(
                                                    listImage:
                                                        listImage[0].toString(),
                                                  ),
                                                ));
                                          },
                                          child: Container(
                                            height: 124,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    const BorderRadius.only(
                                                        topLeft:
                                                            Radius.circular(
                                                                16)),
                                                image: DecorationImage(
                                                    image: NetworkImage(
                                                        listImage[0]),
                                                    fit: BoxFit.cover)),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      ShowTimeLinePicture(
                                                    listImage:
                                                        listImage[1].toString(),
                                                  ),
                                                ));
                                          },
                                          child: Container(
                                            height: 124,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    const BorderRadius.only(
                                                        topRight:
                                                            Radius.circular(
                                                                16)),
                                                image: DecorationImage(
                                                    image: NetworkImage(
                                                        listImage[1]),
                                                    fit: BoxFit.cover)),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  ShowTimeLinePicture(
                                                listImage:
                                                    listImage[2].toString(),
                                              ),
                                            ));
                                      },
                                      child: Container(
                                        height: 124,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                const BorderRadius.only(
                                                    bottomLeft:
                                                        Radius.circular(16),
                                                    bottomRight:
                                                        Radius.circular(16)),
                                            image: DecorationImage(
                                                image:
                                                    NetworkImage(listImage[2]),
                                                fit: BoxFit.cover)),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                ),
              if (isTypeText)
                Container(
                  alignment: Alignment.bottomLeft,
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Text(
                    '',
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${countShow.length} likes",
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                          color: Colors.black),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return CommentPost(
                              name: userName,
                              time: dateUpload,
                              share: share.toString(),
                              comment: comments.toString(),
                              likes: countShow.length.toString(),
                              postText: textPose,
                              profileImage: profileImageUrl,
                              listImage: listImage,
                              id: id,
                              // postId: id,
                            );
                          }));
                          //print(id);
                        },
                        child: Text(
                          "$comments comments",
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 13,
                                color: Colors.black),
                          ),
                        ),
                      ),
                      const SizedBox(width: 24),
                      Text(
                        "$share share",
                        style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                              color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 24),
              StatefulBuilder(builder: (context, state) {
                return Row(
                  children: [
                    InkWell(
                      onTap: () async {
                        state(() {
                          if (countShow.contains(
                              FirebaseAuth.instance.currentUser!.uid)) {
                            FirebaseFirestore.instance
                                .collection('discoverModel')
                                .doc(id)
                                .update({
                              'counter': FieldValue.arrayRemove(
                                  [FirebaseAuth.instance.currentUser!.uid])
                            });
                          } else {
                            FirebaseFirestore.instance
                                .collection('discoverModel')
                                .doc(id)
                                .update({
                              'counter': FieldValue.arrayUnion(
                                  [FirebaseAuth.instance.currentUser!.uid])
                            });
                          }
                        });
                      },
                      child: countShow
                              .contains(FirebaseAuth.instance.currentUser!.uid)
                          ? const Icon(
                              CupertinoIcons.heart_fill,
                              color: Colors.red,
                            )
                          : const Icon(
                              CupertinoIcons.heart,
                              color: Colors.red,
                            ),
                    ),
                    const SizedBox(width: 23),
                    InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return CommentPost(
                            name: userName,
                            time: dateUpload,
                            share: share.toString(),
                            comment: comments.toString(),
                            likes: countShow.length.toString(),
                            postText: textPose,
                            profileImage: profileImageUrl,
                            listImage: listImage,
                            id: id,
                            // postId: id,
                          );
                        }));
                        //print(id);
                      },
                      child: Image.asset(
                        "assets/icons/img_1.png",
                        height: 22,
                        width: 22,
                      ),
                    ),
                    const SizedBox(width: 23),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SharePost(
                                countShow: countShow.length.toString(),
                                comments: comments.toString(),
                                share: share.toString(),
                                textPost: textPose,
                                imageUrl: profileImageUrl,
                                name: userName,
                                time: dateUpload,
                                listImage: listImage,
                                id: id,
                              ),
                            ));
                      },
                      child: Image.asset(
                        "assets/icons/img_2.png",
                        height: 22,
                        width: 22,
                      ),
                    ),
                    const SizedBox(width: 7),
                  ],
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
