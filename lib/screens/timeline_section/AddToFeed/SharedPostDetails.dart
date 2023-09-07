import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../SharePost.dart';

class SharedPostDetails extends StatelessWidget {
  const SharedPostDetails({
    super.key,
    required this.widget,

  });

  final SharePost widget;


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(16)),
          border: Border.all(color: const Color(0xFFF2F2F2),width: 2)
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [  CircleAvatar(
                  radius: 25,
                  backgroundImage: NetworkImage(widget.imageUrl),
                ),
                  const SizedBox(width: 18,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.name,style: const TextStyle(fontSize: 12,fontWeight: FontWeight.w600),),
                      Text(widget.time,style: const TextStyle(fontSize: 10,fontWeight: FontWeight.w500,color: Color(0xFF858585)),),
                    ],
                  ),],
              ),
              const Icon(                          Icons.more_vert_rounded,
              )

            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width*0.75,
                child: Text(widget.textPost),
              ),
            ],
          ),
          widget.listImage.isEmpty?Container(): SizedBox(
            height: 200,
            child: GridView.builder(
                itemCount: widget.listImage.length,
                gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Number of columns in the grid
                  crossAxisSpacing: 1, // Spacing between columns
                  mainAxisSpacing: 0, // Spacing between rows
                ),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                      height: 124,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(
                            Radius.circular(16)),
                        image: DecorationImage(
                          image: NetworkImage(widget.listImage[index]),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  );
                }),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${widget.countShow} likes",
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                      color: Colors.black),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${widget.comments} comments",
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                          color: Colors.black),
                    ),
                  ),
                  const SizedBox(width: 24),
                  Text(
                    "${widget.share} share",
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                          color: Colors.black),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 27),
          Row(
            children: [
              Image.asset(
                "assets/icons/img.png",
                height: 18,
                width: 18,
              ),
              const SizedBox(width: 23),
              Image.asset(
                "assets/icons/img_1.png",
                height: 18,
                width: 18,
              ),
              const SizedBox(width: 23),
              Image.asset(
                "assets/icons/img_2.png",
                height: 18,
                width: 18,
              ),
              const SizedBox(width: 7),
            ],
          ),


        ],
      ),
    );
  }
}
