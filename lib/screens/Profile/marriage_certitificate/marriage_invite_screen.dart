import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_shadow/simple_shadow.dart';
import 'package:wedme1/getit.dart';
import 'package:wedme1/utils/base_view_builder.dart';
import 'package:wedme1/utils/styles.dart';
import 'package:wedme1/viewModel/deeplink_vm.dart';
import 'package:wedme1/viewModel/marriage_vm.dart';
import 'package:wedme1/widget/app_bar_widget.dart';
import 'package:wedme1/widget/button_widget.dart';
import 'package:wedme1/widget/marriage_template.dart';
import 'package:widgets_to_image/widgets_to_image.dart';

class MarriageInviteScreen extends StatefulWidget {
  final bool isCreatingNewInvit;
  const MarriageInviteScreen({Key? key, this.isCreatingNewInvit = true})
      : super(key: key);

  @override
  State<MarriageInviteScreen> createState() => _MarriageInviteScreenState();
}

class _MarriageInviteScreenState extends State<MarriageInviteScreen> {
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
    WidgetsToImageController controller = WidgetsToImageController();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: simpleAppBar(context, widget.isCreatingNewInvit ? true : false),
      body: BaseViewBuilder<MarriageViewModel>(
          model: getIt(),
          builder: (mVm, _) {
            return BaseViewBuilder<DynamicDeepLinkModelView>(
                model: getIt(),
                initState: (init) {
                  init.createDynamicLink();
                },
                builder: (dVm, _) {
                  return SingleChildScrollView(
                    padding: const EdgeInsets.all(20),
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        Text(
                          'Invite Created',
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                              fontSize: 17,
                            ),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 20),
                        widget.isCreatingNewInvit
                            ? Center(
                                child: WidgetsToImage(
                                    controller: controller,
                                    child: mVm.currentIndex == 0
                                        ? MarriageCertTemplate1(
                                            isCreatingNewInvit:
                                                widget.isCreatingNewInvit)
                                        : mVm.currentIndex == 1
                                            ? MarriageCertTemplate2(
                                                isCreatingNewInvit:
                                                    widget.isCreatingNewInvit)
                                            : mVm.currentIndex == 2
                                                ? MarriageCertTemplate3(
                                                    isCreatingNewInvit: widget
                                                        .isCreatingNewInvit)
                                                : mVm.currentIndex == 3
                                                    ? MarriageCertTemplate4(
                                                        isCreatingNewInvit: widget
                                                            .isCreatingNewInvit)
                                                    : const Offstage()))
                            : Center(
                                child: SimpleShadow(
                                  opacity: 0.6,
                                  color: Colors.grey,
                                  offset: const Offset(5, 5),
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
                                      child: CachedNetworkImage(
                                        imageUrl: mVm.certParseData!.template,
                                        progressIndicatorBuilder: (context, url,
                                                downloadProgress) =>
                                            const CupertinoActivityIndicator(),
                                        errorWidget: (context, url, error) =>
                                            const Icon(Icons.broken_image),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                        const SizedBox(height: 25),
                        Text(
                          'WedFuse Wishes you marital bliss',
                          style: stBlack40013.copyWith(
                              fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(height: 25),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              if (widget.isCreatingNewInvit) ...[
                                ProceedButtonWidget(
                                    size: size,
                                    text: 'Save Invite',
                                    press: !mVm.isInviteUploaded
                                        ? () => mVm.saveCertificate(
                                            context, controller)
                                        : () {}),
                              ],
                              if (!widget.isCreatingNewInvit) ...[
                                const SizedBox(height: 10),
                                ProceedButtonWidget(
                                    size: size,
                                    text: 'Send Invite',
                                    press: () {
                                      dVm.shareInvite();
                                    }),
                                const SizedBox(height: 10),
                                ProceedButtonWidget(
                                    size: size,
                                    text: 'Create Group',
                                    press: () {}),
                                const SizedBox(height: 10),
                                ProceedButtonWidget(
                                    size: size, text: 'History', press: () {}),
                              ]
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                });
          }),
    );
  }
}
