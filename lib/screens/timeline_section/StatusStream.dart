// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// import 'live_item.dart';
//
// class FromInsideStatus extends StatelessWidget {
//   const FromInsideStatus({Key? key, }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder(
//         stream:  FirebaseFirestore.instance
//             .collection("Status").doc("aVsNbyRDS7ObC1Mz7hUX").collection("EachStatus").snapshots(),
//         builder:  (_,
//             AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
//             snapshot) {
//           if (snapshot.hasData && snapshot.data == null) {
//             return  Center(
//               child: Container(child: const CircularProgressIndicator()),
//             );
//           }else{
//             return Container(
//               child: ListView.builder(
//
//                 //  physics: new NeverScrollableScrollPhysics(),
//                 itemCount: snapshot.data?.docs.length,
//                 reverse: false,
//                 scrollDirection: Axis.horizontal,
//                 itemBuilder: (context, index) {
//
//                   if(snapshot.data==null||ConnectionState==ConnectionState.waiting){
//                     return const CircularProgressIndicator();
//                   }
//                   DocumentSnapshot ds = snapshot.data!.docs[index];
//
//                   if (snapshot.data == null||ConnectionState==ConnectionState.waiting) {
//                     return const Text("");
//                   } else {
//                     // final storyItems = snapshot.data!.docs
//                     //     .map((doc) => StoryItem.text(
//                     //   title: doc.data()['name'],
//                     //   backgroundColor: Colors.red,
//                     // )).toList();
//                     return SingleChildScrollView(
//
//                       child: Container(
//                         padding: const EdgeInsets.only(left: 2, right: 2, top: 15, bottom: 15),
//                         child: Card(
//                           borderOnForeground: true,
//                           elevation: 2,
//                           child: Container(
//
//                             child:  ds["staus"].toString().isEmpty?Container(): InkWell(
//                               onTap: () {
//                                 Navigator.push(context, MaterialPageRoute(builder: (context) => Whatsaoow(
//                                   name : ds["staus"].toString(),
//                                 ),));
//                               },
//                               child: Text(ds["staus"],style: const TextStyle(
//                                   fontWeight: FontWeight.w500
//                               ),),
//                             ),
//                           ),
//                         ),
//                       ),
//                     );
//                   }
//                 },
//               ),
//             );}
//         }
//     );
//   }
// }
