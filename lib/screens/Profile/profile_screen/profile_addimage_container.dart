import 'package:flutter/material.dart';

import '../../../utils/styles.dart';



class ProfileScreenAddimageContainer extends StatelessWidget {
  const ProfileScreenAddimageContainer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: 80,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          image: const DecorationImage(
              image: AssetImage("assets/images/image_rectangle.png"),
              fit: BoxFit.fill)),
      child: Center(
        child: Text("Add Image",
            style: TextStyle(
              color: Styles.grayColor,
              fontSize: 14.0,
            )),
      ),
    );
  }
}
