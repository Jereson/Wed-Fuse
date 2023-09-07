import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wedme1/constants/colors.dart';
import 'package:wedme1/getit.dart';
import 'package:wedme1/utils/base_view_builder.dart';
import 'package:wedme1/utils/form_utils.dart';
import 'package:wedme1/utils/styles.dart';
import 'package:wedme1/viewModel/profile_vm.dart';
import 'package:wedme1/widget/button_widget.dart';

class ReportProblemScreen extends StatefulWidget {
   ReportProblemScreen({super.key, this.postId="null"});
  String postId;

  @override
  State<ReportProblemScreen> createState() => _ReportProblemScreenState();
}

class _ReportProblemScreenState extends State<ReportProblemScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kBackgroundColor,
        leading: Container(
          margin: const EdgeInsets.fromLTRB(10.0, 10.0, 0, 10),
          child: InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: const CircleAvatar(
              radius: 15.0,
              child: Icon(Icons.arrow_back),
            ),
          ),
        ),
        centerTitle: true,
        title: Text(
          'FeedBack',
          style: GoogleFonts.poppins(
            textStyle: const TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.black,
              fontSize: 16,
            ),
          ),
        ),
      ),
      backgroundColor: kBackgroundColor,
      body: BaseViewBuilder<ProfileViewModel>(
          model: getIt(),
          builder: (pVm, _) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                            text: 'Report problem below ',
                            children: [
                              TextSpan(
                                text: '*',
                                style: stBlack40013.copyWith(
                                    color: kPrimaryColor,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                            style: stBlack40013),
                      ),
                      TextFormField(
                        controller: pVm.reportController,
                        maxLines: 4,
                        decoration: borderTextInputDecoration.copyWith(
                            hintText: 'Describe the problem here...'),
                        validator: (val) {
                          if (val!.isEmpty) {
                            return 'Field is required';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 24),
                      TextFormField(
                        controller: pVm.rpEmailController,
                        cursorColor: Colors.black,
                        decoration: borderTextInputDecoration.copyWith(
                            hintText: 'Enter your Email'),
                      ),
                      const SizedBox(height: 60),
                      ProceedButtonWidget(
                          size: size,
                          text: 'Send Report',
                          press: () {
                            if (!_formKey.currentState!.validate()) return;
                            pVm.sendReport(context,widget.postId);
                          }),
                    ],
                  )),
            );
          }),
    );
  }
}
