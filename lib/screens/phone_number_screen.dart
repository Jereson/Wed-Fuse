
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wedme1/constants/colors.dart';
import 'package:wedme1/getit.dart';
import 'package:wedme1/utils/base_view_builder.dart';
import 'package:wedme1/utils/styles.dart';
import 'package:wedme1/viewModel/auth_vm.dart';

import 'package:country_pickers/country_pickers.dart';
import 'package:country_pickers/country.dart';
import 'package:wedme1/widget/button_widget.dart';

class PhoneNumberScreen extends StatefulWidget {
  const PhoneNumberScreen({Key? key}) : super(key: key);

  @override
  State<PhoneNumberScreen> createState() => _PhoneNumberScreenState();
}

class _PhoneNumberScreenState extends State<PhoneNumberScreen> {
  Country? country;
  GlobalKey prefixKey = GlobalKey();
  double prefixWidth = 0;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
    super.initState();
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: kPrimaryWhite,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        automaticallyImplyLeading: true,
        leading: const Icon(
          Icons.arrow_back_ios_new,
          size: 20,
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: BaseViewBuilder<AuthViewModel>(
          model: getIt(),
          initState: (init) {},
          builder: (aVm, _) {
            return Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // const SizedBox(height: 30),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: size.height * 0.05,
                        ),
                        Text(
                          "Verify your phone \nNumber?",
                          style: Styles.headLineStyle2,
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        const Text(
                            'A Verification code will be sent to your phone number',
                            style: TextStyle(
                                color: Colors.black, //grey color
                                fontSize: 17,
                                fontWeight: FontWeight.w300)),
                        const SizedBox(height: 20),
                        Row(
                          // crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              decoration: BoxDecoration(

                                  // border: Border.all(color: Colors.red),
                                  borderRadius: BorderRadius.circular(4)),
                              child: CountryPickerDropdown(
                                initialValue: 'NG',
                                // itemBuilder: _buildDropdownItem,
                                isExpanded: false,
                                icon: Transform.translate(
                                    offset: const Offset(-10, 0),
                                    child: const Icon(Icons.arrow_drop_down)),
                                priorityList: [
                                  CountryPickerUtils.getCountryByIsoCode('GB'),
                                  CountryPickerUtils.getCountryByIsoCode('CN'),
                                ],
                                sortComparator: (Country a, Country b) =>
                                    a.isoCode.compareTo(b.isoCode),
                                onValuePicked: (Country country) {
                                  // print("${country.phoneCode}");
                                  aVm.setCountryCode(country.phoneCode);

                                  // loginUser.countryPhoneCode = country.phoneCode;
                                  // print("${loginUser.countryPhoneCode}");
                                },
                              ),
                            ),
                            // const SizedBox(width: 10),
                            Expanded(
                              child: TextFormField(
                                controller: aVm.verifyOptController,
                                keyboardType: TextInputType.phone,
                                decoration: const InputDecoration(
                                  hintText: 'Phone number',
                                ),
                                validator: (val) {
                                  if (val!.isEmpty) {
                                    return 'Password required';
                                  } else if (val.length < 10) {
                                    return 'Invalid phone number';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Column(
                      children: [
                        ProceedButtonWidget(
                            size: size,
                            text: 'Proceed',
                            press: () {
                              // Navigator.of(context).push(MaterialPageRoute(
                              //     builder: (context) =>
                              //         const PhoneOtpScreen()));
                              if (!formKey.currentState!.validate()) return;
                              aVm.sendVerifyPhoneNumberOTP(context);
                            }

                            //press:sendPhoneNumber,
                            ),
                        const SizedBox(height: 20),
                        SizedBox(
                          height: size.height * 0.08,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
