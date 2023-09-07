import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'LeaveGroup.dart';
import 'deleteGroup.dart';

class RowOfCall extends StatelessWidget {
  const RowOfCall({
    super.key,required this.groupId, required this.userId
  });
  final String groupId;
  final String userId;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          children: const [
            CircleAvatar(
              radius: 30,
              backgroundColor: Colors.white,
              backgroundImage: AssetImage("assets/images/img_4.png"),
            ),
             SizedBox(height: 8,),
            Text("Call",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 12,color: Color(0xFF8A8A8A)),),
          ],
        ),
        Column(
          children: const [
            CircleAvatar(
              radius: 30,
              backgroundColor: Colors.white,
              backgroundImage: AssetImage("assets/images/img_5.png"),
            ),
             SizedBox(height: 8,),
            Text("Video Call",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 12,color: Color(0xFF8A8A8A)),),
          ],
        ),
        InkWell(
          onTap: () {
            if(userId==FirebaseAuth.instance.currentUser!.uid){
              _showAlertDialog(
                context: context,);
            }else{
              Navigator.push(context, MaterialPageRoute(builder: (context) => LeaveGroup(groupId: groupId,),));

            }

            // Navigator.push(context, MaterialPageRoute(builder: (context) => LeaveGroup(groupId: groupId,),));

          },
          child: Column(
            children: const [
              CircleAvatar(
                radius: 30,
                backgroundColor: Colors.white,
                backgroundImage: AssetImage("assets/images/img_6.png"),
              ),
              SizedBox(height: 8,),
              Text("Leave",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 12,color: Color(0xFF8A8A8A)),),
            ],
          ),
        ),
      ],
    );
  }
  void _showAlertDialog(
      {required BuildContext context,}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(0))),
          // title:  Text(''),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Action",
                    style: TextStyle(fontSize: 16),
                  ),
                  InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Image.asset(
                        "assets/images/img_14.png",
                        height: 14,
                        width: 14,
                      )),
                ],
              ),
              const Divider(),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => DeleteGroup(groupId: groupId,),));

                        },
                        child: Container(
                            height: 49,
                            decoration: const BoxDecoration(color: Colors.red,borderRadius: BorderRadius.all(Radius.circular(10))),
                            child: const Center(child: Text("Delete",style: TextStyle(color: Colors.white),))),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => LeaveGroup(groupId: groupId,),));

                        },
                        child: Container(
                            height: 49,
                            decoration: const BoxDecoration(color: Colors.white,borderRadius: BorderRadius.all(Radius.circular(10)),border: Border(left: BorderSide(color: Colors.red),top:BorderSide(color: Colors.red),bottom: BorderSide(color: Colors.red),right: BorderSide(color: Colors.red), )),
                            child: const Center(child: Text("Leave",style: TextStyle(color: Colors.red),))),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const SizedBox(height: 10),
              const SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }
}
