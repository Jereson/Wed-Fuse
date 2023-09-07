// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:sizer/sizer.dart';
// import 'package:wedme1/constants/colors.dart';


// import '../../../constants/loader.dart';
// import '../Controller/googleController.dart';




// class FacebookAuthButton extends ConsumerWidget {
//   const FacebookAuthButton({Key? key}) : super(key: key);

//   // void signInWihFacebook( BuildContext context, WidgetRef ref){
//   //     ref.read(authControllerProvider.notifier).signInWithFacebook(context);

//   // }


//   @override
//   Widget build(BuildContext context, WidgetRef ref) {


//     return Padding(
//       padding: const EdgeInsets.only(bottom: 16.0, left: 24, right: 24),
//       child: OutlinedButton(
//         style: ButtonStyle(
//           backgroundColor: MaterialStateProperty.all(Colors.white),
//           shape: MaterialStateProperty.all(
//             RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(40),
//             ),
//           ),
//         ),
//         onPressed: ()  {

//           // signInWihFacebook(context, ref);
//           },
//         child: Padding(
//           padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
//           child: Row(
//             mainAxisSize: MainAxisSize.max,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               const Image(
//                 image: AssetImage("assets/icons/fb_icon.png"),
//                 height: 30.0,
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(left: 10),
//                 child: Text(
//                   'Sign Up with Facebook',
//                   style: TextStyle(
//                     fontSize: 15.sp,
//                     color: kPrimaryBlack,
//                     fontWeight: FontWeight.w300,
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
