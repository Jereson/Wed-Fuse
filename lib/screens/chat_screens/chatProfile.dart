import 'package:flutter/material.dart';

class ChatProfile extends StatelessWidget {
   ChatProfile({Key? key, required this.profilP, required this.fullName}) : super(key: key);
  String profilP;
  String fullName;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(backgroundColor: Colors.white,elevation: 0,),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 70,
              backgroundImage: NetworkImage(profilP),
            ),
            Text(fullName,style: const TextStyle(fontSize: 23, fontWeight: FontWeight.w600),),

          ],
        ),
      ),
    );
  }
}
