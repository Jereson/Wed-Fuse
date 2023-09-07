import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_shadow/simple_shadow.dart';
import 'package:wedme1/constants/colors.dart';
import 'package:wedme1/getit.dart';
import 'package:wedme1/models/wedding_templete_model.dart';
import 'package:wedme1/screens/Profile/marriage_certitificate/marriage_cert_form.dart';
import 'package:wedme1/utils/base_view_builder.dart';
import 'package:wedme1/viewModel/marriage_vm.dart';
import 'package:wedme1/widget/app_bar_widget.dart';
import 'package:wedme1/widget/button_widget.dart';

class ChooseTempletScreen extends StatefulWidget {
  const ChooseTempletScreen({Key? key}) : super(key: key);

  @override
  State<ChooseTempletScreen> createState() => _ChooseTempletScreenState();
}

class _ChooseTempletScreenState extends State<ChooseTempletScreen> {
  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
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
    final size = MediaQuery.of(context).size;
    return BaseViewBuilder<MarriageViewModel>(
        model: getIt(),
       
        builder: (mVm, _) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: simpleAppBar(context),
            body: SizedBox(
              height: size.height,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Text(
                      'Create Wedding Invitation',
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                          fontSize: 17,
                        ),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    Center(
                      child: SimpleShadow(
                        opacity: 0.6,
                        color: Colors.grey,
                        offset: Offset(5, 5),
                        sigma: 1,
                        child: Container(
                          // padding: const EdgeInsets.all(1),
                          height: size.height * 0.5,
                          width: size.width * 0.75,

                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset(
                              wedingTemplet[mVm.currentIndex].image!,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            persistentFooterButtons: [
              Container(
                height: size.height * 0.26,
                width: size.width,
                color: Color(0xFFD9D9D9),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: wedingTemplet.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 10),
                              child: GestureDetector(
                                onTap: () {
                                  mVm.setCurrentIndex(index);
                                  // setState(() {
                                  //   currentIndex = index;
                                  // });
                                },
                                child: Column(
                                  children: [
                                    Container(
                                        height: 70,
                                        width: 70,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              width: 2,
                                              color: index == mVm.currentIndex
                                                  ? kPrimaryColor
                                                  : Colors.transparent),
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: Image.asset(
                                                wedingTemplet[index].image!))),
                                    Text(wedingTemplet[index].title!)
                                  ],
                                ),
                              ),
                            );
                          }),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ProceedButtonWidget(
                          size: size,
                          text: 'Proceed',
                          press: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) {
                              return const MarriageCerttificateFormScreen();
                            }));
                          }),
                    )
                  ],
                ),
              ),
            ],
          );
        });
  }
}
