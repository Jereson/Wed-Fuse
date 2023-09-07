import 'dart:io';

import 'package:flutter/material.dart';

class DisplayImageFromStatus extends StatefulWidget {
  const DisplayImageFromStatus({Key? key, required this.image}) : super(key: key);
  final File image;

  @override
  State<DisplayImageFromStatus> createState() => _DisplayImageFromStatusState();
}

class _DisplayImageFromStatusState extends State<DisplayImageFromStatus> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: FileImage(widget.image),),

        ),
      ),
    );
  }
}
