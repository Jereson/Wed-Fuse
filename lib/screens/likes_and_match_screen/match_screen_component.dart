// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:sizer/sizer.dart';

// import '../../models/user_model.dart';
// import '../../widget/un_upgraded_match_list_item.dart';
// import '../../widget/upgraded_match_list_item.dart';

// // Widget nonupgradedMatchAndLikesList({String? title}) {
// //   final List<UserModel> userModel = UserModel.userList;
// //   if (userModel.isNotEmpty) {
// //     return 
// //   } else {
// //     return const Text(" Empty list");
// //   }
// // }

// Widget upgradedMatchAndLikesList({String? title}) {
//   final List<UserModel> userModel = UserModel.userList;
//   if (userModel.isNotEmpty) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         Text(
//           title!,
//           style: GoogleFonts.poppins(
//             textStyle: TextStyle(
//               fontWeight: FontWeight.w200,
//               color: Colors.black,
//               fontSize: 14.sp,
//             ),
//           ),
//         ),
//         const SizedBox(
//           height: 4,
//         ),
//         Expanded(
//           child: GridView.builder(
//             physics: const BouncingScrollPhysics(),
//             itemCount: userModel.length,
//             gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 2, crossAxisSpacing: 1.0, mainAxisSpacing: 1.0),
//             itemBuilder: ((context, index) {
//               return GestureDetector(
//                 onTap: () {},
//                 child: UpgradedUserItem(
//                   userModel: userModel[index],
//                   imageIndex: 0,
//                 ),
//               );
//             }),
//           ),
//         )
//       ],
//     );
//   } else {
//     return const Text(" Empty list");
//   }
// }
