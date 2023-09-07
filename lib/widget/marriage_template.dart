import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_shadow/simple_shadow.dart';
import 'package:wedme1/constants/colors.dart';
import 'package:wedme1/getit.dart';
import 'package:wedme1/models/wedding_templete_model.dart';
import 'package:wedme1/viewModel/marriage_vm.dart';

class MarriageCertTemplate1 extends StatelessWidget {
  final bool? isCreatingNewInvit;
  const MarriageCertTemplate1({super.key, required this.isCreatingNewInvit});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final mVm = getIt.get<MarriageViewModel>();

    return Stack(
      children: [
        SimpleShadow(
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
              child: isCreatingNewInvit!
                  ? Image.asset(
                      wedingTemplet[mVm.currentIndex].image!,
                      fit: BoxFit.cover,
                    )
                  : CachedNetworkImage(
                      imageUrl: mVm.certParseData!.template,
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) =>
                              const CupertinoActivityIndicator(),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.broken_image),
                      fit: BoxFit.cover,
                    ),
            ),
          ),
        ),
        //Brown Template
        // if (mVm.currentIndex == 0)
        Positioned(
            top: 70,
            left: 70,
            child: Text(
              mVm.brideNameController.text,
              style: GoogleFonts.alexBrush(
                  fontWeight: FontWeight.w600,
                  fontStyle: FontStyle.italic,
                  color: Colors.white,
                  fontSize: 24),
            )),
        // if (mVm.currentIndex == 0)
        Positioned(
            top: 120,
            right: 50,
            child: Text(
              mVm.groomNameController.text,
              style: GoogleFonts.alexBrush(
                  fontWeight: FontWeight.w600,
                  fontStyle: FontStyle.italic,
                  color: Colors.white,
                  fontSize: 24),
            )),
        // if (mVm.currentIndex == 0)
        Positioned(
            bottom: 80,
            right: size.width * 0.29,
            child: Text(
              '${mVm.date}',
              style: GoogleFonts.inter(
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.italic,
                  color: Colors.white,
                  fontSize: 12),
            )),

        Positioned(
            bottom: 40,
            left: 30,
            child: Container(
              alignment: Alignment.center,
              width: 200,
              child: Text(
                mVm.locationController.text,
                maxLines: 2,
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.italic,
                    color: Colors.white,
                    fontSize: 11),
              ),
            ))

// locationController
      ],
    );
  }
}

class MarriageCertTemplate2 extends StatelessWidget {
  final bool? isCreatingNewInvit;
  const MarriageCertTemplate2({super.key, required this.isCreatingNewInvit});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final mVm = getIt.get<MarriageViewModel>();

    return Stack(
      children: [
        SimpleShadow(
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
              child: isCreatingNewInvit!
                  ? Image.asset(
                      wedingTemplet[mVm.currentIndex].image!,
                      fit: BoxFit.cover,
                    )
                  : CachedNetworkImage(
                      imageUrl: mVm.certParseData!.template,
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) =>
                              const CupertinoActivityIndicator(),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.broken_image),
                      fit: BoxFit.cover,
                    ),
            ),
          ),
        ),
        Positioned(
            top: 80,
            left: 70,
            child: Text(
              mVm.brideNameController.text,
              style: GoogleFonts.alexBrush(
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                  fontSize: 32),
            )),
        Positioned(
            bottom: 120,
            right: 50,
            child: Text(
              mVm.groomNameController.text,
              style: GoogleFonts.alexBrush(
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                  fontSize: 32),
            )),
        Positioned(
            bottom: 80,
            right: size.width * 0.28,
            child: Text(
              '${mVm.date}',
              style: GoogleFonts.inter(
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.italic,
                  color: kPrimaryColor,
                  fontSize: 12),
            )),
        Positioned(
            bottom: 40,
            left: 30,
            child: Container(
              alignment: Alignment.center,
              width: 200,
              child: Text(
                mVm.locationController.text,
                maxLines: 2,
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.italic,
                    color: Colors.white,
                    fontSize: 11),
              ),
            ))
      ],
    );
  }
}

class MarriageCertTemplate3 extends StatelessWidget {
  final bool? isCreatingNewInvit;
  const MarriageCertTemplate3({super.key, required this.isCreatingNewInvit});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final mVm = getIt.get<MarriageViewModel>();

    return Stack(
      children: [
        SimpleShadow(
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
              child: isCreatingNewInvit!
                  ? Image.asset(
                      wedingTemplet[mVm.currentIndex].image!,
                      fit: BoxFit.cover,
                    )
                  : CachedNetworkImage(
                      imageUrl: mVm.certParseData!.template,
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) =>
                              const CupertinoActivityIndicator(),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.broken_image),
                      fit: BoxFit.cover,
                    ),
            ),
          ),
        ),
        Positioned(
            top: 90,
            right: size.width * 0.24,
            child: Text(
              '${mVm.date}',
              style: GoogleFonts.inter(
                  fontWeight: FontWeight.w700,
                  fontStyle: FontStyle.italic,
                  color: Color(0xFF1ED6FF),
                  fontSize: 16),
            )),
        Positioned(
            bottom: 40,
            right: 50,
            child: Text(
              mVm.brideNameController.text,
              style: GoogleFonts.alexBrush(
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                  fontSize: 32),
            )),
        Positioned(
            bottom: 40,
            left: 50,
            child: Text(
              mVm.groomNameController.text,
              style: GoogleFonts.alexBrush(
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                  fontSize: 32),
            )),
        Positioned(
            bottom: 10,
            left: 30,
            child: Container(
              alignment: Alignment.center,
              width: 200,
              child: Text(
                mVm.locationController.text,
                maxLines: 2,
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.italic,
                    color: Colors.white,
                    fontSize: 11),
              ),
            ))
      ],
    );
  }
}

class MarriageCertTemplate4 extends StatelessWidget {
  final bool? isCreatingNewInvit;
  const MarriageCertTemplate4({super.key, required this.isCreatingNewInvit});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final mVm = getIt.get<MarriageViewModel>();

    return Stack(
      children: [
        SimpleShadow(
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
              child: isCreatingNewInvit!
                  ? Image.asset(
                      wedingTemplet[mVm.currentIndex].image!,
                      fit: BoxFit.cover,
                    )
                  : CachedNetworkImage(
                      imageUrl: mVm.certParseData!.template,
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) =>
                              const CupertinoActivityIndicator(),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.broken_image),
                      fit: BoxFit.cover,
                    ),
            ),
          ),
        ),
        Positioned(
            top: 100,
            right: size.width * 0.24,
            child: Text(
              '${mVm.date}',
              style: GoogleFonts.inter(
                  fontWeight: FontWeight.w700,
                  fontStyle: FontStyle.italic,
                  color: const Color(0xFF1ED6FF),
                  fontSize: 16),
            )),
        Positioned(
            bottom: 60,
            right: 50,
            child: Text(
              mVm.brideNameController.text,
              style: GoogleFonts.alexBrush(
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                  fontSize: 32),
            )),
        Positioned(
            bottom: 30,
            left: 30,
            child: Container(
              alignment: Alignment.center,
              width: 200,
              child: Text(
                mVm.locationController.text,
                maxLines: 2,
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.italic,
                    color: Colors.white,
                    fontSize: 11),
              ),
            ))
      ],
    );
  }
}
