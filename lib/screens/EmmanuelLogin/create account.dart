import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUp extends StatelessWidget {
   SignUp({Key? key}) : super(key: key);

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormField(
            controller: email,
          ),
          TextFormField(
            controller: password,
          ),
          ElevatedButton(onPressed: () {
            FirebaseAuth.instance.createUserWithEmailAndPassword(email: email.text.trim(), password: password.text.trim());
          }, child: Text("CreateA")),
        Divider(),

        TextFormField(
          controller: email,
        ),
        TextFormField(
          controller: password,
        ),
        ElevatedButton(onPressed: () {
          FirebaseAuth.instance.signInWithEmailAndPassword(email: email.text.trim(), password: password.text.trim());
        }, child: Text("Login")),
        ],
      ),
    );
  }
}
