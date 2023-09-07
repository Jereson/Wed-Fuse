import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '/getit.dart';
import '/models/users_detail_model.dart';
import '/screens/home_page/detail_homepage.dart';
import '/viewModel/profile_vm.dart';

class GroupChatUserItem extends StatefulWidget {
  final UsersDetailModel? userDetail;
  final int indexTwo;
  final String idCurrent;
  final admin;
  const GroupChatUserItem({Key? key, this.userDetail,required this.admin, required this.indexTwo, required this.idCurrent}) : super(key: key);

  @override
  State<GroupChatUserItem> createState() => _GroupChatUserItemState();
}

class _GroupChatUserItemState extends State<GroupChatUserItem> {

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () {
        getIt.get<ProfileViewModel>().setSelectedUser(widget.userDetail!);
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return  DetailHomescreen(index: widget.indexTwo,);
        }));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CircleAvatar(
              radius: 27,
              backgroundImage: NetworkImage(widget.userDetail!.photoUrl!),
            ),
            const SizedBox(width: 20,),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.userDetail!.fullName!,style: const TextStyle(color: Colors.black,fontSize: 14),),

                widget.userDetail!.userId==FirebaseAuth.instance.currentUser!.uid?  const Text("You",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w500,color: Color(0xFF929292)),):
                const Text("Active",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w500,color: Color(0xFF929292)),),
              ],
            )
          ],
        ),
              widget.admin== widget.userDetail!.userId?  const Text("Organiser",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w500,color: Color(0xFF929292)),):
 const Icon(Icons.arrow_forward_ios_sharp,size: 20,),
        ]),
      ),
    );
  }
}
