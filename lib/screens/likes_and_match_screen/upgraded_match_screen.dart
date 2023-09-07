// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:sizer/sizer.dart';

// import '../../models/user_model.dart';
// import '../../widget/app_bar_widget.dart';
// import '../../widget/upgraded_match_list_item.dart';

// class UpgradedMatchScreen extends StatefulWidget {
//   const UpgradedMatchScreen({Key? key}) : super(key: key);

//   @override
//   State<UpgradedMatchScreen> createState() => _UpgradedMatchScreenState();
// }

// class _UpgradedMatchScreenState extends State<UpgradedMatchScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: CustomAppbar.matchScreenAppBar(
//         context: context,
//       ),
//       body: Container(
//         color: Colors.white,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Expanded(
//               child: DefaultTabController(
//                 length: 2,
//                 initialIndex: 0,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.stretch,
//                   children: [
//                     Container(
//                       alignment: Alignment.topCenter,
//                       child: const TabBar(
//                           isScrollable: true,
//                           indicatorColor: Colors.red,
//                           labelStyle: TextStyle(color: Colors.black),
//                           tabs: [
//                             Tab(
//                               child: Text(
//                                 "Your Match",
//                                 style: TextStyle(color: Colors.black),
//                               ),
//                             ),
//                             Tab(
//                               child: Text(
//                                 "See Who likes You",
//                                 style: TextStyle(color: Colors.black),
//                               ),
//                             )
//                           ]),
//                     ),
//                     SizedBox(height: 2.h),
//                     Expanded(
//                         child: TabBarView(
//                             physics: const BouncingScrollPhysics(),
//                             dragStartBehavior: DragStartBehavior.down,
//                             children: [
//                           matchAndLikesList(
//                               title: "This are people that match with you"),
//                           matchAndLikesList(
//                               title: "View people who have liked your profile"),
//                         ]))
//                   ],
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

// Widget matchAndLikesList({String? title}) {
//   final List<UserModel> userModel = UserModel.userList;
//   if (userModel.isNotEmpty) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         Text(title!),
//         Expanded(
//           child: GridView.builder(
//             itemCount: userModel.length,
//             gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 2, crossAxisSpacing: 4.0, mainAxisSpacing: 4.0),
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
