import 'package:flutter/material.dart';

class CommentPostColumOne extends StatelessWidget {
  const CommentPostColumOne({
    super.key,
    required this.name,
    required this.time,
    required this.share,
    required this.profileImage,
    required this.comment,
    required this.likes,
    required this.postText,
    required this.listImage,
  });

  final String name;
  final String time;
  final String share;
  final String postText;
  final String profileImage;
  final String comment;
  final String likes;
  final List listImage;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(profileImage),
                  ),
                  const SizedBox(
                    width: 18,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(name,style: const TextStyle(fontWeight: FontWeight.w600),),
                      Text(time,style: const TextStyle(fontWeight: FontWeight.w500,fontSize: 10,color: Colors.grey),),
                    ],
                  ),
                ],
              ),
              const Icon(Icons.more_vert_outlined)
            ],
          ),

          Column(
            children: [
              Row(
                children: [
                  SizedBox(
                      width: 300,
                      child: Text(postText)),
                ],
              ),
              if(listImage.isEmpty)
                Container() else if(listImage.length<=3)SizedBox(
                height: 248,
                width: double.infinity,
                child:listImage.length==1?  Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Container(
                        height: 158,
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all( Radius.circular(16)),
                            image: DecorationImage(image: NetworkImage(listImage[0]),fit: BoxFit.cover)),
                      ),
                    ),

                  ],
                ):listImage.length==2?Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Container(
                              height: 200,
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(16),bottomLeft: Radius.circular(16)),
                                  image: DecorationImage(image: NetworkImage(listImage[0]),fit: BoxFit.cover)),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Container(
                              height: 200,
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(topRight: Radius.circular(16),bottomRight:Radius.circular(16) ),
                                  image: DecorationImage(image: NetworkImage(listImage[1]),fit: BoxFit.cover)),
                            ),
                          ),
                        ),
                      ],
                    ),

                  ],
                ):Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Container(
                              height: 124,
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(16)),
                                  image: DecorationImage(image: NetworkImage(listImage[0]),fit: BoxFit.cover)),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Container(
                              height: 124,
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(topRight: Radius.circular(16)),
                                  image: DecorationImage(image: NetworkImage(listImage[1]),fit: BoxFit.cover)),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Container(
                          height: 124,
                          decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(16),bottomRight: Radius.circular(16)),
                              image: DecorationImage(image: NetworkImage(listImage[2]),fit: BoxFit.cover)),
                        ),
                      ),
                    ),

                  ],
                ),
              ),
            ],
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("$likes likes"),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("$comment comments"),
                  const SizedBox(
                    width: 20,
                  ),
                  Text("$share share"),

                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
