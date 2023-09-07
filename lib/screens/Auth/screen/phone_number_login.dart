import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wedme1/constants/colors.dart';
import 'package:wedme1/getit.dart';
import 'package:wedme1/screens/Auth/screen/phone_no_otp_screen.dart';
import 'package:wedme1/utils/base_view_builder.dart';
import 'package:wedme1/utils/styles.dart';
import 'package:wedme1/viewModel/auth_vm.dart';
import 'package:wedme1/widget/button_widget.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:country_pickers/country.dart';

class PhoneNumberLoginScreen extends StatefulWidget {
  const PhoneNumberLoginScreen({Key? key}) : super(key: key);

  @override
  State<PhoneNumberLoginScreen> createState() => _PhoneNumberLoginScreenState();
}

class _PhoneNumberLoginScreenState extends State<PhoneNumberLoginScreen> {
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
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
            size: 20,
          ),
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
                          "Login with your \nNumber?",
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
                                controller: aVm.authPhoneController,
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
                              aVm.signinWithPhoneNumber(context, true);
                            }

                            //press:sendPhoneNumber,
                            ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "Already have an account? ",
                              style: TextStyle(
                                color: Styles.textColor,
                                fontSize: 14,
                              ),
                            ),
                            InkWell(
                              onTap: () {},
                              child: Text(
                                'Login',
                                style: TextStyle(
                                  color: Styles.redColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
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
