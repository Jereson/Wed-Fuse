import 'package:datepicker_dropdown/datepicker_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:wedme1/getit.dart';
import 'package:wedme1/utils/base_view_builder.dart';
import 'package:wedme1/utils/form_utils.dart';
import 'package:wedme1/screens/preference_screen.dart';
import 'package:wedme1/viewModel/auth_vm.dart';
import 'package:wedme1/viewModel/profile_vm.dart';
import 'package:wedme1/widget/button_widget.dart';
import 'package:sizer/sizer.dart';
import '../constants/colors.dart';
import '../utils/styles.dart';
import '../widget/text_input.dart';

class BioDataScreen extends StatefulWidget {
  const BioDataScreen({Key? key}) : super(key: key);

  @override
  State<BioDataScreen> createState() => _BioDataScreenState();
}

class _BioDataScreenState extends State<BioDataScreen> {
  // final FirebaseDatabase _database = FirebaseDatabase.instance;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Styles.whiteColor,
        resizeToAvoidBottomInset: false,
        body: BaseViewBuilder<ProfileViewModel>(
            model: getIt(),
            builder: (pVm, _) {
              return Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.only(right: 37, left: 37),
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(height: 2.h),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Bio data \nInfo",
                              style: Styles.headLineStyle2,
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Text(
                                'Complete the onboarding process by providing the details below',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w300)),
                            const SizedBox(
                              height: 4,
                            ),
                            TextFormField(
                                controller: pVm.bioNameController,
                                decoration: noBorderTextInputDecoration
                                    .copyWith(hintText: 'Full name'
                                        // suffixIcon: const Icon(Icons.na)
                                        ),
                                validator: (value) {
                                  if (value!.isEmpty ||
                                      value.split(' ').length < 2) {
                                    return 'Invalid fullname';
                                  }
                                  return null;
                                }),
                            SizedBox(height: 2.h),
                            Text(
                              "Birthday",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w400),
                            ),
                            SizedBox(height: 2.h),
                            // DropdownDatePicker(
                            //   inputDecoration: InputDecoration(
                            //       border: OutlineInputBorder(
                            //           borderRadius: BorderRadius.circular(
                            //               10))), // optional
                            //   // isDropdownHideUnderline: true, // optional
                            //   isFormValidator: true,
                            //   startYear: 1900, // optional
                            //   endYear: 2100, // optional
                            //   width: 10, // optional

                            //   // selectedDay: 14, // optional
                            //   // selectedMonth: 10, // optional
                            //   // selectedYear: 1990, // optional
                            //   boxDecoration: const BoxDecoration(
                            //     color: kEditextColor,
                            //   ), // optional

                            //   dayFlex: 2, // optional
                            //   hintDay: 'DD', // optional
                            //   hintMonth: 'MM', // optional
                            //   hintYear: 'YY', // optional
                            //   textStyle: const TextStyle(
                            //       fontSize: 12, fontWeight: FontWeight.w700),
                            //   hintTextStyle:
                            //       const TextStyle(color: Colors.grey),
                            //   isExpanded: true,

                            //   onChangedDay: (day) {
                            //     pVm.selectBirthDay(day!);
                            //   },
                            //   //onSaved: (value) => _birthday = value,
                            //   onChangedMonth: (month) {
                            //     pVm.selectBirthMonth(month!);
                            //   },
                            //   onChangedYear: (year) {
                            //     pVm.selectBirthYear(year!);
                            //   },
                            // ),
                            GestureDetector(
                              onTap: () {
                                pVm.pickDateOfBirth(context);
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  _customDateWidget(pVm.bioMonth ?? 'MM',
                                      pVm.bioMonth == null ? 0.2 : 1),
                                  _customDateWidget(pVm.bioDay ?? 'DD',
                                      pVm.bioDay == null ? 0.2 : 1),
                                  _customDateWidget(pVm.bioYear ?? 'YY',
                                      pVm.bioYear == null ? 0.2 : 1),
                                ],
                              ),
                            ),

                            SizedBox(
                              height: 2.h,
                            ),
                            Text(
                              "Gender",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w400),
                            ),
                            SizedBox(
                              height: 2.h,
                            ),
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () => pVm.selectGender('Male'),
                                  child: Container(
                                    height: 6.h,
                                    width: 13.h,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 1,
                                            color: pVm.maleSelected
                                                ? kPrimaryColor
                                                : Colors.transparent),
                                        color: pVm.maleSelected
                                            ? kPrimaryColor
                                            : kEditextColor,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Visibility(
                                            visible: pVm.maleSelected,
                                            child: const Icon(Icons.circle,
                                                size: 12, color: Colors.white),
                                          ),
                                          SizedBox(width: 1.h),
                                          Text("Male",
                                              style: Styles.textStyle.copyWith(
                                                  color: pVm.maleSelected
                                                      ? Colors.white
                                                      : Colors.black,
                                                  fontSize: 14.sp)),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 2.h),
                                InkWell(
                                  onTap: () => pVm.selectGender('Female'),
                                  child: Container(
                                    height: 6.h,
                                    width: 13.h,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 1,
                                            color: pVm.femaleSelected
                                                ? kPrimaryColor
                                                : Colors.transparent),
                                        color: pVm.femaleSelected
                                            ? kPrimaryColor
                                            : kEditextColor,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Visibility(
                                            visible: pVm.femaleSelected,
                                            child: const Icon(Icons.circle,
                                                size: 12, color: Colors.white),
                                          ),
                                          SizedBox(width: 1.h),
                                          Text("Female",
                                              style: Styles.textStyle.copyWith(
                                                  color: pVm.femaleSelected
                                                      ? Colors.white
                                                      : Colors.black,
                                                  fontSize: 14.sp)),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        ProceedButtonWidget(
                          size: size,
                          text: 'Proceed',
                          press: () {
                            if (!_formKey.currentState!.validate()) return;
                            pVm.updateBioData(context);
                            // _submitForm;
                          },
                        ),
                        SizedBox(height: 0.2.h),
                      ],
                    ),
                  ),
                ),
              );
            }));
  }

  Widget _customDateWidget(String text, double opacity) {
    return Container(
        height: 52,
        width: MediaQuery.of(context).size.width * 0.25,
        decoration: BoxDecoration(
            color: kEditextColor,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: TextStyle(
                  fontSize: 16, color: Colors.black.withOpacity(opacity)),
            ),
            Icon(Icons.keyboard_arrow_down_outlined,
                color: Colors.black.withOpacity(opacity)),
          ],
        ));
  }
}
