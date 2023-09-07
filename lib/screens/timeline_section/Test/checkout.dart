import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../time_line_screen.dart';

class LoginE extends StatelessWidget {
   LoginE({Key? key}) : super(key: key);

  TextEditingController emailcontroller =TextEditingController();
  TextEditingController passwordcontroller =TextEditingController();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormField(
            controller: emailcontroller,
          ),
          TextFormField(
            controller: passwordcontroller,
          ),
          ElevatedButton(onPressed: () async {
           await FirebaseAuth.instance.signInWithEmailAndPassword(email: emailcontroller.text.trim(), password: passwordcontroller.text.trim()).then((value){
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => TimeLineScreen(),));
            } );
          }, child: Text("Login")),
        ],
      ),
    );
  }
}
