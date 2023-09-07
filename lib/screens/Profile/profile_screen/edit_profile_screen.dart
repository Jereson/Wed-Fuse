import 'package:cached_network_image/cached_network_image.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wedme1/constants/colors.dart';
import 'package:wedme1/getit.dart';
import 'package:wedme1/utils/form_utils.dart';
import 'package:wedme1/utils/local_storage_utils.dart';
import 'package:wedme1/viewModel/profile_vm.dart';
import 'package:wedme1/widget/button_widget.dart';
import '../../../utils/base_view_builder.dart';
import '../../../utils/styles.dart';
import '../../../widget/profile_widget/custom_profile_head.dart';
import 'addimage.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfile();
}

class _EditProfile extends State<EditProfile> {
  bool profileFile = true;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController aboutController = TextEditingController();
  final TextEditingController jobController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BaseViewBuilder<ProfileViewModel>(
        model: getIt(),
        initState: (init) {
          init.setInitTextEditingController();
          init.setOtherInitValue();
        },
        builder: (pVm, _) {
          return Scaffold(
            appBar: AppBar(
              leadingWidth: 60,
              centerTitle: true,
              title: Text(
                'Edit Profile',
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                    letterSpacing: -0.41,
                    fontSize: 18,
                  ),
                ),
              ),
              elevation: 0,
              backgroundColor: Colors.transparent,
              leading: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Padding(
                  padding: EdgeInsets.only(left: 20, bottom: 2),
                  child: CircleAvatar(
                    radius: 15,
                    backgroundColor: Color.fromARGB(255, 241, 43, 28),
                    child: Icon(
                      Icons.arrow_back_rounded,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            backgroundColor: const Color.fromARGB(255, 250, 248, 248),
            body: Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, top: 30),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Row(
                          children: [
                            Stack(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      color: kPrimaryColor,
                                      borderRadius: BorderRadius.circular(10)),

                                  // strokeWidth: 2,
                                  // dashPattern: const [4, 4],
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.32,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.28,
                                      decoration: BoxDecoration(
                                        color: kPrimaryColor.withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(1),
                                        // image: DecorationImage(
                                        //     image: NetworkImage(
                                        //       pVm.cachedUserDetail!.bannerPic![0],
                                        //     ),
                                        //     fit: BoxFit.cover
                                        //     ),
                                      ),
                                      child: CachedNetworkImage(
                                        imageUrl: pVm.cachedUserDetail!
                                                .bannerPic!.isEmpty
                                            ? pVm.cachedUserDetail!
                                                .altBannerPic![0]
                                            : pVm.cachedUserDetail!
                                                .bannerPic![0],
                                        fit: BoxFit.cover,
                                        placeholder: (context, url) =>
                                            const CupertinoActivityIndicator(),
                                        errorWidget: (context, url, error) =>
                                            const Icon(Icons.broken_image),
                                      ),
                                    ),
                                  ),
                                ),
                                if (pVm.cachedUserDetail!.bannerPic!.isNotEmpty)
                                  Positioned(
                                      right: -12,
                                      bottom: -10,
                                      child: IconButton(
                                          onPressed: () => pVm.deleteBanner(
                                              context,
                                              pVm.cachedUserDetail!
                                                  .bannerPic![0]),
                                          icon: Transform.translate(
                                            offset: const Offset(3, 4),
                                            child: const Icon(
                                              Icons.cancel,
                                            ),
                                          )))
                              ],
                            ),
                            SizedBox(width: 10.w),
                            Column(
                              children: [
                                Wrap(
                                  spacing: 10.w,
                                  children: [
                                    pVm.cachedUserDetail!.bannerPic!.length >= 2
                                        ? _customImageContainer(
                                            pVm.cachedUserDetail!.bannerPic![1])
                                        : _customDottedBorder(),
                                    pVm.cachedUserDetail!.bannerPic!.length >= 3
                                        ? _customImageContainer(
                                            pVm.cachedUserDetail!.bannerPic![2])
                                        : _customDottedBorder(),
                                  ],
                                ),
                                SizedBox(height: 10.h),
                                Wrap(
                                  spacing: 10.w,
                                  children: [
                                    pVm.cachedUserDetail!.bannerPic!.length >= 4
                                        ? _customImageContainer(
                                            pVm.cachedUserDetail!.bannerPic![3])
                                        : _customDottedBorder(),
                                    pVm.cachedUserDetail!.bannerPic!.length >= 5
                                        ? _customImageContainer(
                                            pVm.cachedUserDetail!.bannerPic![4])
                                        : _customDottedBorder(),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 42),
                        editprofilebutton(
                          width: 230,
                          text: 'Add Photos ',
                          press: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => AddImageScreen(
                                      imageLength: pVm.cachedUserDetail!
                                          .bannerPic!.length)),
                            );
                          },
                        ),
                        const SizedBox(height: 20),
                        // editprofilebutton(
                        //     width: 230, text: 'Save', press: () {}),
                        const SizedBox(height: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomProfileHeadings(heading: 'Name'),
                            const SizedBox(height: 5),

                            FocusScope(
                              onFocusChange: (value) {
                                if (!value) {
                                  pVm.editName(context);
                                }
                              },
                              child: TextField(
                                  onTapOutside: (value) {
                                    FocusScope.of(context).unfocus();
                                    pVm.editName(context);
                                  },
                                  onSubmitted: (value) {
                                    FocusScope.of(context).unfocus();
                                    pVm.editName(context);
                                  },
                                  style: profileFieldStyle,
                                  controller: pVm.pNameEditController,
                                  decoration: profileInputDecoration),
                            ),
                            const SizedBox(height: 20),
                            CustomProfileHeadings(heading: 'About Me'),
                            const SizedBox(height: 5),

                            FocusScope(
                              onFocusChange: (value) {
                                if (!value) {
                                  pVm.editAboutMe(context);
                                }
                              },
                              child: TextField(
                                onTapOutside: (value) {
                                  FocusScope.of(context).unfocus();
                                  pVm.editAboutMe(context);
                                },
                                onSubmitted: (value) {
                                  FocusScope.of(context).unfocus();
                                  pVm.editAboutMe(context);
                                },
                                style: profileFieldStyle,
                                controller: pVm.pAbountMeEditController,
                                decoration: profileInputDecoration,
                                maxLines: 4,
                              ),
                            ),
                            const SizedBox(height: 20),

                            CustomProfileHeadings(heading: 'Add Job'),
                            const SizedBox(height: 10),
                            FocusScope(
                                onFocusChange: (value) {
                                  if (!value) {
                                    pVm.editJob(context);
                                  }
                                },
                                child: TextField(
                                    onTapOutside: (value) {
                                      FocusScope.of(context).unfocus();
                                      pVm.editJob(context);
                                    },
                                    onSubmitted: (value) {
                                      FocusScope.of(context).unfocus();
                                      pVm.editJob(context);
                                    },
                                    controller: pVm.pJobEditController,
                                    style: profileFieldStyle,
                                    decoration: profileInputDecoration)),
                            const SizedBox(height: 20),
                            CustomProfileHeadings(heading: 'Living in'),
                            //AddCityScreen
                            const SizedBox(height: 10),

                            CSCPicker(
                              countryDropdownLabel:
                                  pVm.cachedUserDetail!.country!.isNotEmpty
                                      ? pVm.cachedUserDetail!.country!
                                      : "Select country",
                              dropdownDecoration: BoxDecoration(
                                  color: Colors.white,
                                  border:
                                      Border.all(color: Colors.transparent)),
                              showStates: false,
                              showCities: false,
                              onCountryChanged: (value) {
                                print(value);
                                pVm.editCounty(context, value);
                              },
                              onStateChanged: (value) {},
                              onCityChanged: (value) {},
                            ),

                            const SizedBox(height: 20),
                            CustomProfileHeadings(heading: 'Age'),
                            const SizedBox(height: 10),
                            FocusScope(
                                onFocusChange: (value) {
                                  if (!value) {
                                    pVm.editAge(context);
                                  }
                                },
                                child: TextField(
                                    onTapOutside: (value) {
                                      FocusScope.of(context).unfocus();
                                      pVm.editAge(context);
                                    },
                                    onSubmitted: (value) {
                                      FocusScope.of(context).unfocus();
                                      pVm.editAge(context);
                                    },
                                    controller: pVm.pAgeEditController,
                                    style: profileFieldStyle,
                                    decoration: profileInputDecoration)),

                            const SizedBox(height: 20),
                            CustomProfileHeadings(heading: 'Religion'),
                            const SizedBox(height: 10),

                            DropdownButtonFormField<String>(
                              value: pVm.pRelogion,
                              icon: const Icon(Icons.arrow_drop_down),
                              elevation: 16,
                              dropdownColor: Colors.white,
                              style: profileFieldStyle,
                              decoration: profileInputDecoration.copyWith(
                                  hintText: 'What is your Religion'),
                              onChanged: (String? value) {
                                pVm.editReligion(context, value!);
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
                            CustomProfileHeadings(heading: 'Genotype'),
                            const SizedBox(height: 10),
                            DropdownButtonFormField<String>(
                              value: pVm.pGeonoty,
                              icon: const Icon(Icons.arrow_drop_down),
                              elevation: 16,
                              dropdownColor: Colors.white,
                              style: profileFieldStyle,
                              decoration: profileInputDecoration.copyWith(
                                  hintText: 'What is your Genotype'),
                              onChanged: (String? value) {
                                pVm.editGeonoty(context, value!);
                              },
                              items: [
                                "AA",
                                "AC",
                                "AS",
                                "SS"
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),

                            const SizedBox(height: 20),
                            CustomProfileHeadings(heading: 'Temperament'),
                            const SizedBox(height: 10),
                            DropdownButtonFormField<String>(
                              value: pVm.pTemperament,
                              icon: const Icon(Icons.arrow_drop_down),
                              elevation: 16,
                              dropdownColor: Colors.white,
                              style: profileFieldStyle,
                              decoration: profileInputDecoration.copyWith(
                                  hintText: "what's your mood like"),
                              onChanged: (String? value) {
                                if (value == 'Others') {
                                  pVm.setOtherSelected(true);
                                } else {
                                  pVm.editTemperament(context, value!);
                                }
                              },
                              items: [
                                "Relaxed",
                                "Extrovert",
                                "Introvert",
                                "Ambivert",
                                "Playful",
                                "Others"
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),

                            pVm.isOtherSelected
                                ? Column(
                                    children: [
                                      const SizedBox(height: 10),
                                      FocusScope(
                                          onFocusChange: (value) {
                                            if (!value) {
                                              pVm.editTemperament(
                                                  context,
                                                  pVm.pTemperamentEditController
                                                      .text);
                                            }
                                          },
                                          child: TextField(
                                              onTapOutside: (value) {
                                                FocusScope.of(context)
                                                    .unfocus();
                                                pVm.editTemperament(
                                                    context,
                                                    pVm.pTemperamentEditController
                                                        .text);
                                              },
                                              onSubmitted: (value) {
                                                FocusScope.of(context)
                                                    .unfocus();
                                                pVm.editTemperament(
                                                    context,
                                                    pVm.pTemperamentEditController
                                                        .text);
                                              },
                                              controller: pVm
                                                  .pTemperamentEditController,
                                              style: profileFieldStyle,
                                              decoration: profileInputDecoration
                                                  .copyWith(
                                                      hintText:
                                                          'Enter your temperament'))),
                                    ],
                                  )
                                : const Offstage(),
                            const SizedBox(height: 20),
                            CustomProfileHeadings(heading: 'What do you want'),
                            const SizedBox(height: 10),
                            DropdownButtonFormField<String>(
                              value: pVm.pChioce,
                              icon: const Icon(Icons.arrow_drop_down),
                              elevation: 16,
                              dropdownColor: Colors.white,
                              style: profileFieldStyle,
                              decoration: profileInputDecoration.copyWith(
                                  hintText: "Select what you want"),
                              onChanged: (String? value) {
                                pVm.editChoice(context, value!);
                              },
                              items: [
                                "Something Casual",
                                "Something Serious",
                                "Marriage",
                                "Just Dating",
                                "Friendship"
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),

                            const SizedBox(height: 20),
                            CustomProfileHeadings(
                              heading: 'Marriage Readiness Status',
                            ),
                            const SizedBox(height: 10),
                            DropdownButtonFormField<String>(
                              value: pVm.pReadiness,
                              icon: const Icon(Icons.arrow_drop_down),
                              elevation: 16,
                              dropdownColor: Colors.white,
                              style: profileFieldStyle,
                              decoration: profileInputDecoration.copyWith(
                                  hintText: "Select how ready you are"),
                              onChanged: (String? value) {
                                pVm.editMarraigeReadiness(context, value!);
                              },
                              items: [
                                "As soon as possible",
                                "Few months",
                                "Few years",
                                "Not Interested"
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),

                            const SizedBox(height: 20),
                            CustomProfileHeadings(heading: 'Preference'),
                            const SizedBox(height: 10),
                            DropdownButtonFormField<String>(
                              value: pVm.pPreference,
                              icon: const Icon(Icons.arrow_drop_down),
                              elevation: 16,
                              dropdownColor: Colors.white,
                              style: profileFieldStyle,
                              decoration: profileInputDecoration.copyWith(
                                  hintText: "Select who you are interested in"),
                              onChanged: (String? value) {
                                pVm.editPreference(context, value!);
                              },
                              items: [
                                "Men",
                                "Women",
                                "Everyone"
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),

                            const SizedBox(height: 20),
                          ],
                        ),
                        const SizedBox(height: 20),
                        CustomProfileHeadings(heading: 'Control your profile'),
                        const SizedBox(height: 10),
                        Container(
                          height: 150,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 8, right: 8),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Show My Age',
                                      style: GoogleFonts.poppins(
                                        textStyle: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    Switch(
                                      value: getIt
                                              .get<LocalStorage>()
                                              .getShowAge() ??
                                          false,
                                      onChanged: (bool value) {
                                        pVm.setShowAgeButton(value);
                                      },
                                      activeColor:
                                          const Color.fromRGBO(237, 34, 39, 1),
                                      inactiveTrackColor: const Color.fromRGBO(
                                          217, 217, 217, 1),
                                      thumbColor:
                                          MaterialStateColor.resolveWith(
                                        (states) => const Color.fromRGBO(
                                            237, 34, 39, 1),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 8, right: 8),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Show My Distance',
                                      style: GoogleFonts.poppins(
                                        textStyle: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    Switch(
                                      value: getIt
                                              .get<LocalStorage>()
                                              .getShowDistance() ??
                                          false,
                                      onChanged: (bool value) {
                                        pVm.setShowDistanceButton(value);
                                      },
                                      activeColor:
                                          const Color.fromRGBO(237, 34, 39, 1),
                                      inactiveTrackColor: const Color.fromRGBO(
                                          217, 217, 217, 1),
                                      thumbColor:
                                          MaterialStateColor.resolveWith(
                                        (states) => const Color.fromRGBO(
                                            237, 34, 39, 1),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 8, right: 8),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Show My Genotype',
                                      style: GoogleFonts.poppins(
                                        textStyle: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    Switch(
                                      value: getIt
                                              .get<LocalStorage>()
                                              .getShowGenotype() ??
                                          false,
                                      onChanged: (bool value) {
                                        pVm.setShowGenotyButton(value);
                                      },
                                      activeColor:
                                          const Color.fromRGBO(237, 34, 39, 1),
                                      thumbColor:
                                          MaterialStateColor.resolveWith(
                                        (states) => const Color.fromRGBO(
                                            237, 34, 39, 1),
                                      ),
                                      inactiveTrackColor: const Color.fromRGBO(
                                          217, 217, 217, 1),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  Widget _customDottedBorder() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: DottedBorder(
        color: kPrimaryColor,
        child: Container(
            height: 90,
            width: 85,
            color: kPrimaryColor.withOpacity(0.1),
            child: Center(
              child: Text("Add Image",
                  style: TextStyle(
                    color: Styles.grayColor,
                    fontSize: 14.sp,
                  )),
            )),
      ),
    );
  }

  Widget _customImageContainer(String imageUrl) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        height: 90,
        width: 85,
        color: kPrimaryColor.withOpacity(0.1),
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          fit: BoxFit.cover,
          progressIndicatorBuilder: (context, url, downloadProgress) =>
              const CupertinoActivityIndicator(),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
      ),
    );
  }
}
