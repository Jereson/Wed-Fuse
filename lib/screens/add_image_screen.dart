import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:wedme1/constants/colors.dart';
import 'package:wedme1/getit.dart';
import 'package:wedme1/utils/base_view_builder.dart';
import 'package:wedme1/utils/flushbar_widget.dart';
import 'package:wedme1/viewModel/banner_vm.dart';

import '../utils/styles.dart';
import '../widget/button_widget.dart';

class AddImageScreen extends StatefulWidget {
  const AddImageScreen({Key? key}) : super(key: key);

  @override
  State<AddImageScreen> createState() => _AddImageScreenState();
}

class _AddImageScreenState extends State<AddImageScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          color: Colors.black,
          icon: const Icon(Icons.arrow_back_ios),
          iconSize: 20.0,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: Colors.white,
      body: BaseViewBuilder<BannerVm>(
          model: getIt(),
          builder: (pVm, _) {
            return Padding(
              padding: const EdgeInsets.only(right: 37, left: 37),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 2.h,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Add Images",
                        style: Styles.headLineStyle2,
                      ),
                      SizedBox(
                        height: 1.5.h,
                      ),
                      Text(
                          'Add an image to your profile so people can see how you look like',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w300)),
                      SizedBox(
                        height: 2.h,
                      ),

                      // Stack(
                      //   children: [
                      //     const Padding(
                      //       padding: EdgeInsets.only(right: 8),
                      //       child: SizedBox(
                      //         height: 220,
                      //         width: 133,
                      //         child: Image(
                      //           image: AssetImage(
                      //               "assets/images/rectangle_image_bg.png"),
                      //         ),
                      //       ),
                      //     ),
                      //     Positioned(
                      //         right: -12,
                      //         bottom: -10,
                      //         child: IconButton(
                      //             onPressed: () {},
                      //             icon: const Icon(
                      //               Icons.cancel,
                      //             )))
                      //   ],
                      // ),
                      SizedBox(
                        width: 5.w,
                      ),
                      pVm.pickedBanner.isEmpty
                          ? Center(
                              child: Container(
                                height: 200,
                                width: 133,
                                decoration: BoxDecoration(
                                    color: kPrimaryColor.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(1),
                                    image: const DecorationImage(
                                        image: AssetImage(
                                            "assets/images/image_rectangle.png"),
                                        fit: BoxFit.fill)),
                                child: Center(
                                  child: Text("Add Image",
                                      style: TextStyle(
                                        color: Styles.grayColor,
                                        fontSize: 14.sp,
                                      )),
                                ),
                              ),
                            )
                          : SizedBox(
                              height: 200,
                              child: ListView.builder(
                                  itemCount: pVm.pickedBanner.length,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    return Stack(
                                      children: [
                                        DottedBorder(
                                          radius: const Radius.circular(10),
                                          color: kPrimaryColor,
                                          strokeWidth: 2,
                                          dashPattern: const [4, 4],
                                          child: Container(
                                            height: 200,
                                            width: 133,
                                            decoration: BoxDecoration(
                                                color: kPrimaryColor
                                                    .withOpacity(0.1),
                                                borderRadius:
                                                    BorderRadius.circular(1),
                                                image: DecorationImage(
                                                    image: FileImage(File(pVm
                                                        .pickedBanner[index]
                                                        .path)),
                                                    // image: AssetImage(
                                                    //     "assets/images/image_rectangle.png"),
                                                    fit: BoxFit.cover)),
                                          ),
                                        ),
                                        Positioned(
                                            right: -12,
                                            bottom: -10,
                                            child: IconButton(
                                                onPressed: () =>
                                                    pVm.unPickBanner(index),
                                                icon: const Icon(
                                                  Icons.cancel,
                                                )))
                                      ],
                                    );
                                  }),
                            ),

                      SizedBox(height: 2.h),
                      ChoosePhotoButtonWidget(
                          size: 250.sp,
                          text: "Add Photos from Gallery",
                          press: () => pVm.pickBannerFromGalary(context)),
                      SizedBox(height: 2.h),
                      ChoosePhotoButtonWidget(
                          size: 250.sp,
                          text: "Take Photo",
                          press: () => pVm.pickBannerFromCamera(context))
                    ],
                  ),
                  ProceedButtonWidget(
                    size: size,
                    text: 'Proceed',
                    press: () {
                      pVm.pickedBanner.isNotEmpty
                          ? pVm.uploadBanner(context)
                          : flushbar(
                              context: context,
                              title: 'Image Required',
                              message: 'Please pick your images',
                              isSuccess: false);
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //       builder: (context) => const CongratulationScreen()),
                      // );
                    },
                  ),
                  SizedBox(height: 0.2.h),
                ],
              ),
            );
          }),
    );
  }
}
