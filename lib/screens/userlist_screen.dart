// // import 'package:flutter/material.dart';
// // import 'package:flutter_riverpod/flutter_riverpod.dart';

// // import '../constants/error.dart';
// // import '../constants/loader.dart';
// // import '../widget/user_list_item.dart';
// // import 'Profile/profileController/profileController.dart';

// // class UserListScreen extends ConsumerWidget {
// //   UserListScreen({Key? key}) : super(key: key);

// //   @override
// //   Widget build(BuildContext context,WidgetRef ref) {
// //     Size size = MediaQuery.of(context).size;
// //     return ref.watch(userProfileProvider).when(
// //         data: (data) {
// //           return ListView.builder(
// //               itemCount: data.length,
// //               physics: const BouncingScrollPhysics(),
// //               itemBuilder: ((context, index) {
// //                 final userModels = data[index];

// //                 return GestureDetector(

// //                   child: SizedBox(
// //                     height: 550,
// //                     child:     UserItem(
// //                       userModel: userModels,

// //                     ),
// //                   ),
// //                 );
// //               }));
// //         },
// //         error: (error, stackTrace) => ErrorText(
// //       error: error.toString(),
// //     ),
// //     loading: () => const loader(),
// //     );
// //   }
// // }

// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// import '../constants/error.dart';
// import '../constants/loader.dart';
// import '../widget/user_list_item.dart';
// import 'Profile/profileController/profileController.dart';

// class UserListScreen extends ConsumerWidget {
//   UserListScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context,WidgetRef ref) {
//     Size size = MediaQuery.of(context).size;
//     return ref.watch(userProfileProvider).when(
//         data: (data) {
//           return ListView.builder(
//               itemCount: data.length,
//               physics: const BouncingScrollPhysics(),
//               itemBuilder: ((context, index) {
//                 final userModels = data[index];

//                 return GestureDetector(

//                   child: SizedBox(
//                     height: 550,
//                     child:     UserItem(
//                       userModel: userModels,

//                     ),
//                   ),
//                 );
//               }));
//         },
//         error: (error, stackTrace) => ErrorText(
//       error: error.toString(),
//     ),
//     loading: () => const loader(),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// import '../constants/error.dart';
// import '../constants/loader.dart';
// import '../widget/user_list_item.dart';
// import 'Profile/profileController/profileController.dart';

// class UserListScreen extends ConsumerWidget {
//   UserListScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context,WidgetRef ref) {
//     Size size = MediaQuery.of(context).size;
//     return ref.watch(userProfileProvider).when(
//         data: (data) {
//           return ListView.builder(
//               itemCount: data.length,
//               physics: const BouncingScrollPhysics(),
//               itemBuilder: ((context, index) {
//                 final userModels = data[index];

//                 return GestureDetector(

//                   child: SizedBox(
//                     height: 550,
//                     child:     UserItem(
//                       userModel: userModels,

//                     ),
//                   ),
//                 );
//               }));
//         },
//         error: (error, stackTrace) => ErrorText(
//       error: error.toString(),
//     ),
//     loading: () => const loader(),
//     );
//   }
// }

import 'package:flutter/material.dart';
import '../widget/user_list_item.dart';

class UserListScreen extends StatelessWidget {
  const UserListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 5,
        physics: const BouncingScrollPhysics(),
        itemBuilder: ((context, index) {
          return GestureDetector(
            child:  SizedBox(
              height: 550,
              child: UserItem(indexTwo: index,),
            ),
          );
        }));
  }
}
