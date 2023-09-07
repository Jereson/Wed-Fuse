import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../getit.dart';
import '../../../viewModel/profile_vm.dart';
import '../../home_page/detail_homepage.dart';
import '../CommentPost.dart';
import '../SharePost.dart';
import '/screens/Posts/screen/commentscreen.dart';

class SharedPost extends ConsumerWidget {
  SharedPost(
      {Key? key,
        required this.imgUrl,
        required this.profileImageUrl,
        required this.userName,
        required this.dateUpload,
        required this.countN,
        required this.like,
        required this.index,
        required this.listImage,
        required this.shareCountShow,
        required this.sharedTextPose,
        required this.sharedDateUpload,
        required this.id,
        required this.shareShare,
        required this.share,
        required this.currentImageUrl,
        required this.shareComments,
        required this.sharedListImage,
        required this.sharedUserName,
        required this.date,
        required this.comments,
        required this.iconOnPressed,
        required this.textPose})
      : super(key: key);

  final String imgUrl;
  final String profileImageUrl;
  final String userName;
  final String shareCountShow;
  final String shareComments;
  final String sharedTextPose;
  final String sharedDateUpload;
  final String currentImageUrl;
  final String sharedUserName;
  final String shareShare;
  final int like;
  final String dateUpload;
  final String textPose;
  final String id;
  final String date;
  List countN;
  final List listImage;
  final List sharedListImage;
  final int comments;
  final int index;
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
                        backgroundImage: NetworkImage(currentImageUrl),
                      ),
                      const SizedBox(width: 7),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            // onTap: () {
                            //
                            //  // getIt.get<ProfileViewModel>().setSelectedUser(userDetail!);
                            //   Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                            //     return  DetailHomescreen(index: index,);
                            //   }));
                            // },
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
              Text(textPose),
              const SizedBox(height: 5),
              Container(
               padding: const EdgeInsets.all(8),
               decoration: BoxDecoration(
                 borderRadius: BorderRadius.circular(12),
                 border: Border.all(
                   color: const Color(0XFF1ECCD7),
                 ),
               ),
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
                             backgroundImage: NetworkImage(profileImageUrl),
                           ),
                           const SizedBox(width: 7),
                           Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               GestureDetector(
                                 // onTap: () {
                                 //
                                 //   // getIt.get<ProfileViewModel>().setSelectedUser(userDetail!);
                                 //   Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                                 //     return  DetailHomescreen(index: index,);
                                 //   }));
                                 // },
                                 child: Text(
                                   sharedUserName,
                                   style: GoogleFonts.poppins(
                                     textStyle: const TextStyle(
                                       fontSize: 15,
                                       fontWeight: FontWeight.w500,
                                     ),
                                   ),
                                 ),
                               ),
                               Text(
                                 sharedDateUpload,
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
                           // IconButton(
                           //   onPressed: (){},
                           //   icon: const Icon(
                           //     Icons.more_vert_rounded,
                           //   ),
                           // ),
                         ],
                       ),
                     ],
                   ),
                   const SizedBox(height: 5),
                   if (isTypeImage) Row(
                     children: [
                       Container(
                           width: MediaQuery.of(context).size.width*0.75,
                           child: Text(sharedTextPose)),
                     ],
                   ),
                   const SizedBox(height: 10),
                   if(sharedListImage.isEmpty)
                     Container()
                   else if(sharedListImage.length<=3)SizedBox(
                     height: 248,
                     width: double.infinity,
                     child:sharedListImage.length==1?  Column(
                       children: [
                         Padding(
                           padding: const EdgeInsets.all(2.0),
                           child: Container(
                             height: 158,
                             decoration: BoxDecoration(
                                 borderRadius: const BorderRadius.all( Radius.circular(16)),
                                 image: DecorationImage(image: NetworkImage(sharedListImage[0]),fit: BoxFit.cover)),
                           ),
                         ),

                       ],
                     ):sharedListImage.length==2?Column(
                       children: [
                         Row(
                           mainAxisAlignment: MainAxisAlignment.center,
                           children: [
                             Expanded(
                               child: Padding(
                                 padding: const EdgeInsets.all(2.0),
                                 child: Container(
                                   height: 200,
                                   decoration: BoxDecoration(
                                       borderRadius: const BorderRadius.only(topLeft: Radius.circular(16),bottomLeft: Radius.circular(16)),
                                       image: DecorationImage(image: NetworkImage(sharedListImage[0]),fit: BoxFit.cover)),
                                 ),
                               ),
                             ),
                             Expanded(
                               child: Padding(
                                 padding: const EdgeInsets.all(2.0),
                                 child: Container(
                                   height: 200,
                                   decoration: BoxDecoration(
                                       borderRadius: const BorderRadius.only(topRight: Radius.circular(16),bottomRight:Radius.circular(16) ),
                                       image: DecorationImage(image: NetworkImage(sharedListImage[1]),fit: BoxFit.cover)),
                                 ),
                               ),
                             ),
                           ],
                         ),

                       ],
                     ):Column(
                       children: [
                         Row(
                           mainAxisAlignment: MainAxisAlignment.center,
                           children: [
                             Expanded(
                               child: Padding(
                                 padding: const EdgeInsets.all(2.0),
                                 child: Container(
                                   height: 124,
                                   decoration: BoxDecoration(
                                       borderRadius: const BorderRadius.only(topLeft: Radius.circular(16)),
                                       image: DecorationImage(image: NetworkImage(sharedListImage[0]),fit: BoxFit.cover)),
                                 ),
                               ),
                             ),
                             Expanded(
                               child: Padding(
                                 padding: const EdgeInsets.all(2.0),
                                 child: Container(
                                   height: 124,
                                   decoration: BoxDecoration(
                                       borderRadius: const BorderRadius.only(topRight: Radius.circular(16)),
                                       image: DecorationImage(image: NetworkImage(sharedListImage[1]),fit: BoxFit.cover)),
                                 ),
                               ),
                             ),
                           ],
                         ),
                         Expanded(
                           child: Padding(
                             padding: const EdgeInsets.all(2.0),
                             child: Container(
                               height: 124,
                               decoration: BoxDecoration(
                                   borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(16),bottomRight: Radius.circular(16)),
                                   image: DecorationImage(image: NetworkImage(sharedListImage[2]),fit: BoxFit.cover)),
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
                   // Row(
                   //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   //   children: [
                   //     Text(
                   //       "$shareCountShow likes",
                   //       style: GoogleFonts.poppins(
                   //         textStyle: const TextStyle(
                   //             fontWeight: FontWeight.w600,
                   //             fontSize: 13,
                   //             color: Colors.black),
                   //       ),
                   //     ),
                   //     Row(
                   //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   //       children: [
                   //         Text(
                   //           "$shareComments comments",
                   //           style: GoogleFonts.poppins(
                   //             textStyle: const TextStyle(
                   //                 fontWeight: FontWeight.w600,
                   //                 fontSize: 13,
                   //                 color: Colors.black),
                   //           ),
                   //         ),
                   //         const SizedBox(width: 24),
                   //         Text(
                   //           "$shareShare share",
                   //           style: GoogleFonts.poppins(
                   //             textStyle: const TextStyle(
                   //                 fontWeight: FontWeight.w600,
                   //                 fontSize: 13,
                   //                 color: Colors.black),
                   //           ),
                   //         ),
                   //       ],
                   //     ),
                   //   ],
                   // ),
                   const SizedBox(height: 24),
                   // Row(
                   //   children: [
                   //     Image.asset(
                   //       "assets/icons/img.png",
                   //       height: 18,
                   //       width: 18,
                   //     ),
                   //     const SizedBox(width: 23),
                   //     Image.asset(
                   //       "assets/icons/img_1.png",
                   //       height: 18,
                   //       width: 18,
                   //     ),
                   //     const SizedBox(width: 23),
                   //     Image.asset(
                   //       "assets/icons/img_2.png",
                   //       height: 18,
                   //       width: 18,
                   //     ),
                   //     const SizedBox(width: 7),
                   //   ],
                   // ),
                 ],
               ),

             ),
              const SizedBox(height: 10),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${countN.length} likes",
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
                              likes: countN.length.toString(),
                              postText: textPose,
                              profileImage: profileImageUrl,
                              listImage: sharedListImage,
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
              Row(
                children: [
                  StatefulBuilder(builder: (context, setState) {
                    return                   InkWell(
                      onTap: () async {
                        setState((){
                          if(countN.contains(FirebaseAuth.instance.currentUser!.uid)){
                            FirebaseFirestore.instance
                                .collection('discoverModel')
                                .doc(id)
                                .update({
                              'counter': FieldValue.arrayRemove([FirebaseAuth.instance.currentUser!.uid])
                            });
                          }else{
                            FirebaseFirestore.instance
                                .collection('discoverModel')
                                .doc(id)
                                .update({
                              'counter': FieldValue.arrayUnion([FirebaseAuth.instance.currentUser!.uid])
                            });
                          }
                        });

                      },
                      child:countN.contains(FirebaseAuth.instance.currentUser!.uid)? const Icon(CupertinoIcons.heart_fill,color: Colors.red,):const Icon(CupertinoIcons.heart,color: Colors.red,),
                    );
                  },),
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
                          likes: countN.length.toString(),
                          postText: textPose,
                          profileImage: profileImageUrl,
                          listImage: sharedListImage,
                          id: id,
                          // postId: id,
                        );
                      }));
                      //print(id);
                    },
                    child: Image.asset(
                      "assets/icons/img_1.png",
                      height: 18,
                      width: 18,
                    ),
                  ),
                  const SizedBox(width: 23),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SharePost(
                              countShow: countN.length.toString(),
                              comments: comments.toString(),
                              share: share.toString(), textPost: textPose, imageUrl: profileImageUrl, name: userName, time: dateUpload, listImage: listImage, id: id,
                            ),
                          ));
                    },
                    child: Image.asset(
                      "assets/icons/img_2.png",
                      height: 18,
                      width: 18,
                    ),
                  ),
                  const SizedBox(width: 7),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
