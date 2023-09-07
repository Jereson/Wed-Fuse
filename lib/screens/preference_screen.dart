import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:wedme1/constants/colors.dart';
import 'package:wedme1/getit.dart';
import 'package:wedme1/screens/hobbies_screen.dart';
import 'package:wedme1/utils/base_view_builder.dart';
import 'package:wedme1/utils/styles.dart';
import 'package:wedme1/viewModel/profile_vm.dart';
import '../widget/button_widget.dart';

class PreferenceScreen extends StatefulWidget {
  const PreferenceScreen({Key? key}) : super(key: key);

  @override
  State<PreferenceScreen> createState() => _PreferenceScreenState();
}

class _PreferenceScreenState extends State<PreferenceScreen> {
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
          onPressed: (() {
            Navigator.pop(context);
          }),
        ),
      ),
      backgroundColor: Colors.white,
      body: BaseViewBuilder<ProfileViewModel>(
          model: getIt(),
          builder: (pVm, _) {
            return Padding(
              padding: const EdgeInsets.only(right: 37, left: 37),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 8.0.h,
                        ),
                        Text(
                          "Preferences",
                          style: Styles.headLineStyle2,
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Text(
                            'Kindly indicate your dating preference.This helps us match you with the right person.',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w300)),
                        SizedBox(
                          height: 2.h,
                        ),
                        GestureDetector(
                          onTap: () {
                            pVm.setPrefernce(true, false, false);
                            // setState(() {
                            //   maleSelected = true;
                            //   femaleSelected = false;
                            //   everyoneSelected = false;
                            // });
                          },
                          child: Container(
                            padding: const EdgeInsets.only(left: 37, right: 37),
                            width: size.width,
                            height: 44.sp,
                            decoration: BoxDecoration(
                              color: pVm.preferredMale
                                  ? kPrimaryColor
                                  : Colors.grey[200],
                              borderRadius: const BorderRadius.horizontal(
                                right: Radius.circular(10),
                                left: Radius.circular(10),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                "Male",
                                style: Styles.buttonTextStyle.copyWith(
                                    color: pVm.preferredMale
                                        ? Colors.white
                                        : Colors.black),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        GestureDetector(
                          onTap: () {
                            pVm.setPrefernce(false, true, false);
                            // setState(() {
                            //   maleSelected = false;
                            //   femaleSelected = true;
                            //   everyoneSelected = false;
                            // });
                          },
                          child: Container(
                            padding: const EdgeInsets.only(left: 37, right: 37),
                            width: size.width,
                            height: 54,
                            decoration: BoxDecoration(
                              color: pVm.preferredFemale
                                  ? kPrimaryColor
                                  : Colors.grey[200],
                              borderRadius: const BorderRadius.horizontal(
                                right: Radius.circular(10),
                                left: Radius.circular(10),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                "Female",
                                style: Styles.buttonTextStyle.copyWith(
                                    color: pVm.preferredFemale
                                        ? Colors.white
                                        : Colors.black),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        GestureDetector(
                          onTap: () {
                            pVm.setPrefernce(false, false, true);
                          },
                          child: Container(
                            padding: const EdgeInsets.only(left: 37, right: 37),
                            width: size.width,
                            height: 44.sp,
                            decoration: BoxDecoration(
                              color: pVm.preferredEveryOne
                                  ? kPrimaryColor
                                  : Colors.grey[200],
                              borderRadius: const BorderRadius.horizontal(
                                right: Radius.circular(10),
                                left: Radius.circular(10),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                "Everyone",
                                style: Styles.buttonTextStyle.copyWith(
                                    color: pVm.preferredEveryOne
                                        ? Colors.white
                                        : Colors.black),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    ProceedButtonWidget(
                      size: size,
                      text: 'Proceed',
                      press: () {
                        pVm.updatePrefernce(context);
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //       builder: (context) => const HobbiesScreen()),
                        // );
                      },
                    ),
                    SizedBox(height: 0.1.h),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
