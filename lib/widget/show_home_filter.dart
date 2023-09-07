import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:wedme1/constants/colors.dart';
import 'package:wedme1/getit.dart';
import 'package:wedme1/utils/base_view_builder.dart';
import 'package:wedme1/utils/form_utils.dart';
import 'package:wedme1/viewModel/profile_vm.dart';
import 'package:wedme1/widget/button_widget.dart';

class ShowHomeFilterWidget extends StatefulWidget {
  const ShowHomeFilterWidget({super.key});

  @override
  State<ShowHomeFilterWidget> createState() => _ShowHomeFilterWidgetState();
}

class _ShowHomeFilterWidgetState extends State<ShowHomeFilterWidget> {
  RangeValues _currentRangeValues = const RangeValues(17, 17);
  String? genger;
  String? county;
  String? state;
  String? religion;
  num? startAge;
  num? endAge;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final heading = GoogleFonts.inter(
        fontSize: 15,
        fontWeight: FontWeight.w500,
        color: const Color(0xFF222222));
    return BaseViewBuilder<ProfileViewModel>(
        model: getIt(),
        builder: (pVm, _) {
          return Container(
            height: 530,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(26),
                topRight: Radius.circular(26),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        margin: const EdgeInsets.only(top: 4, bottom: 20),
                        height: 2.6,
                        width: 100,
                        decoration:
                            const BoxDecoration(color: Color(0xFFAAAAAA)),
                      ),
                    ),
                    Align(
                        alignment: Alignment.topRight,
                        child: TextButton(
                          onPressed: () => pVm.resetFilterBool(),
                          child: Text('Reset',
                              style: heading.copyWith(color: kPrimaryColor)),
                        )),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Text('Age', style: heading),
                        const Spacer(),
                        Text(
                            '${_currentRangeValues.start.toStringAsFixed(0)} - ${_currentRangeValues.end.toStringAsFixed(0)}',
                            style: heading)
                      ],
                    ),
                    RangeSlider(
                        inactiveColor: kPrimaryBlack,
                        max: 80,
                        min: 17,
                        values: _currentRangeValues,
                        divisions: 5,
                        labels: RangeLabels(
                          _currentRangeValues.start.round().toString(),
                          _currentRangeValues.end.round().toString(),
                        ),
                        onChanged: (val) {
                          setState(() {
                            _currentRangeValues = val;
                            startAge = num.tryParse(
                                _currentRangeValues.start.round().toString());
                            endAge = num.tryParse(
                                _currentRangeValues.end.round().toString());
                          });
                        }),
                    const SizedBox(height: 15),
                    Text('Location:', style: heading),
                    const SizedBox(height: 10),
                    CSCPicker(
                      countryDropdownLabel: "Select country",
                      dropdownDecoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(color: const Color(0xFF7B7B7B))),
                      showCities: false,
                      onCountryChanged: (value) {
                        setState(() {
                          county = value;
                        });
                      },
                      onStateChanged: (value) {
                        setState(() {
                          state = value;
                        });    
                      },
                      onCityChanged: (value) {},
                    ),
                    const SizedBox(height: 15),
                    Text('Gender:', style: heading),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        genderButton(
                            title: 'Male',
                            size: size,
                            callback: () => setgender('Male'),
                            color: genger == 'Male' ? kPrimaryColor : null),
                        const Spacer(),
                        genderButton(
                            title: 'Female',
                            size: size,
                            callback: () => setgender('Female'),
                            color: genger == 'Female' ? kPrimaryColor : null),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Text('Religion:', style: heading),
                    const SizedBox(height: 10),
                    DropdownButtonFormField<String>(
                      value: religion,
                      icon: const Icon(Icons.keyboard_arrow_down_rounded),
                      elevation: 16,
                      dropdownColor: Colors.white,
                      style: profileFieldStyle,
                      decoration: borderTextInputDecoration.copyWith(
                          filled: false, hintText: 'Select Religion'),
                      onChanged: (String? value) {
                        setState(() {
                          religion = value;
                        });
                      },
                      items: [
                        "Atheist",
                        "Budist",
                        "Christian",
                        "Hedonist",
                        "Muslim",
                        "Traditionalist",
                        "Don't Specify"
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 20),
                    ProceedButtonWidget(
                      size: size,
                      text: 'Filter',
                      color: genger == null &&
                              county == null &&
                              state == null &&
                              religion == null &&
                              startAge == null
                          ? kPrimaryColor.withOpacity(0.1)
                          : kPrimaryColor,
                      press: genger == null &&
                              county == null &&
                              state == null &&
                              religion == null &&
                              startAge == null
                          ? () {}
                          : () async {
                              await pVm.setFilterData(
                                  fCountry: county,
                                  fCity: state,
                                  fReligion: religion,
                                  aStart: startAge,
                                  aEnd: endAge);
                              if (context.mounted) {
                                Navigator.pop(context);
                              }
                            },
                    ),
                  ]),
            ),
          );
        });
  }

  setgender(String val) {
    setState(() {
      genger = val;
    });
  }
}

Widget genderButton(
    {String? title, Size? size, Color? color, VoidCallback? callback}) {
  return GestureDetector(
    onTap: callback,
    child: Container(
      alignment: Alignment.center,
      width: size!.width * 0.43,
      height: 39,
      decoration: BoxDecoration(
        color: color ?? Colors.white,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: color ?? const Color(0xFF7B7B7B)),
      ),
      child: Text(
        title!,
        style: GoogleFonts.roboto(
            color: color == null ? const Color(0xFFAAAAAA) : Colors.white),
      ),
    ),
  );
}

showHomeFilterWidget(BuildContext context) {
  showMaterialModalBottomSheet(
      context: context,
      builder: (context) {
        return const ShowHomeFilterWidget();
      });
}
