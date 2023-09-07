import 'package:flutter/material.dart';


class SharePostFirstRow extends StatelessWidget {
  const SharePostFirstRow({
    super.key,
    required this.photoUrl,
    required this.fullName
  });
  final String photoUrl;
  final String fullName;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 25,
          backgroundImage:
          NetworkImage(photoUrl),
        ),
        const SizedBox(width: 18,),
        Column(
          children: [
            Text(fullName,style: const TextStyle(fontSize: 12,fontWeight: FontWeight.w600),),
            const Text("",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w600),),
          ],
        ),
      ],
    );
  }
}
