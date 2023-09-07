import 'package:flutter/material.dart';

class ShowTimeLinePicture extends StatelessWidget {
  const ShowTimeLinePicture({Key? key,required this.listImage}) : super(key: key);

  final String listImage;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Container(
              height: 482,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all( Radius.circular(0)),
                  image: DecorationImage(image: NetworkImage(listImage),fit: BoxFit.cover)),
            ),
          ],
        ),
      ),
    );
  }
}
