// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_pickers/country_picker_dropdown.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_animation_transition/animations/bottom_to_top_transition.dart';
import 'package:page_animation_transition/page_animation_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:wedme1/screens/phone_number_screen.dart';

import '../../../getit.dart';
import '../../../utils/base_view_builder.dart';
import '../../../viewModel/profile_vm.dart';
import '../../../widget/profile_widget/addjobs_custom_containers.dart';

import '../../chat_screens/country/countryScreen.dart';
import 'narrowing_screen.dart';

class AddCityScreen extends StatefulWidget {
  const AddCityScreen({Key? key}) : super(key: key);

  @override
  State<AddCityScreen> createState() => _AddCityScreenState();
}

class _AddCityScreenState extends State<AddCityScreen> {
  bool inKilometers = true;
  bool inMiles = false;
  bool state1 = false;
  bool state2 = false;
  bool state3 = false;
  List dist = ['Km.'];
  late SharedPreferences _prefs;

  Future<void> _setSwitchValue(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('switch_value', value);
  }

  Future<bool> _getSwitchValue() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('switch_value') ?? false;
  }

  var locationMessage = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initPrefs();
    _getSwitchValue().then((value) {
      setState(() {
        state3 = value;
      });
    });
    SharedPreferences.getInstance().then((prefs) {
      setState(() {
        _prefs = prefs;
        state1 = _prefs.getBool('nationwide') ?? false;
        state2 = _prefs.getBool('autoplay') ?? false;
      });
    });
  }

  void _initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
    inKilometers = _prefs.getBool('inKilometers') ?? true;
    inMiles = _prefs.getBool('inMiles') ?? false;
  }

  void _updateDistanceUnit(bool kmSelected) {
    setState(() {
      inKilometers = kmSelected;
      inMiles = !kmSelected;
      dist[0] = kmSelected ? 'km.' : 'Mi.';
    });
    _prefs.setBool('inKilometers', inKilometers);
    _prefs.setBool('inMiles', inMiles);
  }

  @override
  Widget build(BuildContext context) {
    return BaseViewBuilder<ProfileViewModel>(
        model: getIt(),
        builder: (pVm, _) {
          return Scaffold(
            appBar: AppBar(
              leadingWidth: 60,
              centerTitle: true,
              title: Text(
                'Settings',
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
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
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, bottom: 2),
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: Color.fromARGB(255, 92, 90, 90),
                  ),
                ),
              ),
            ),
            backgroundColor: Color.fromARGB(255, 250, 248, 248),
            body: Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, top: 30),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Account settings',
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        AddCityCustomContainer(
                          leadingtext: 'Phone Number',
                          trailingwidget: GestureDetector(
                            onTap: () {
                              // Navigator.of(context).push(PageAnimationTransition(
                              //     page: const PhoneNumberScreen(),
                              //     pageAnimationType: BottomToTopTransition()));
                            },
                            child: Row(
                              children: [
                                Text(
                                  pVm.cachedUserDetail!.phoneNumber!,
                                  style: GoogleFonts.poppins(
                                    textStyle: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.grey,
                                  size: 20,
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 5),
                        // Text(
                        //   'Verify your phone Number to secure your account',
                        //   style: GoogleFonts.poppins(
                        //     textStyle: const TextStyle(
                        //       fontSize: 12,
                        //       fontWeight: FontWeight.w400,
                        //       color: Colors.black,
                        //     ),
                        //   ),
                        // ),
                        SizedBox(height: 25),
                        Text(
                          'Narrowing Setting',
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(PageAnimationTransition(
                                page: const NarrowingScreen(),
                                pageAnimationType: BottomToTopTransition()));
                          },
                          child: AddCityCustomContainer(
                            leadingtext: 'Location',
                            trailingwidget: InkWell(
                              onTap: () {},
                              child: Text(
                                'My Current Location',
                                style: GoogleFonts.poppins(
                                  textStyle: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.red,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Select your location to help us match someone near you',
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        SizedBox(height: 30),
                        AddCityCustomContainer(
                          leadingtext: 'Nationwide',
                          trailingwidget: Switch(
                            value: state1,
                            onChanged: (bool value) async {
                              setState(() {
                                state1 = value;
                                _prefs.setBool('nationwide', value);
                              });
                            },
                            activeColor: Color.fromRGBO(237, 34, 39, 1),
                            inactiveTrackColor:
                                Color.fromRGBO(217, 217, 217, 1),
                            thumbColor: MaterialStateColor.resolveWith(
                              (states) => Color.fromRGBO(237, 34, 39, 1),
                            ),
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'What region should we search',
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        SizedBox(height: 25),
                        Text(
                          'Data usage',
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        AddCityCustomContainer(
                          leadingtext: 'Autoplay Videos',
                          trailingwidget: Switch(
                            value: state2,
                            onChanged: (bool value) {
                              setState(() {
                                state2 = value;
                                _prefs.setBool('autoplay', value);
                              });
                            },
                            activeColor: Color.fromRGBO(237, 34, 39, 1),
                            inactiveTrackColor:
                                Color.fromRGBO(217, 217, 217, 1),
                            thumbColor: MaterialStateColor.resolveWith(
                              (states) => Color.fromRGBO(237, 34, 39, 1),
                            ),
                          ),
                        ),
                        SizedBox(height: 25),
                        Container(
                          width: double.infinity,
                          height: 100,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 3),
                                      child: Text(
                                        'Show Distances in',
                                        style: GoogleFonts.poppins(
                                          textStyle: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color: Colors.red,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(right: 8.0),
                                      child: Text(
                                        inKilometers
                                            ? '${dist[0]}'
                                            : '${dist[0]}',
                                        style: GoogleFonts.poppins(
                                          textStyle: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 30),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    GestureDetector(
                                      onTap: () => _updateDistanceUnit(true),
                                      child: Container(
                                        width: 100,
                                        height: 30,
                                        decoration: BoxDecoration(
                                          color: inKilometers
                                              ? Colors.red
                                              : Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: Center(
                                          child: Text(
                                            'Km.',
                                            style: GoogleFonts.poppins(
                                              textStyle: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                color: inKilometers
                                                    ? Colors.white
                                                    : Colors.black,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () => _updateDistanceUnit(false),
                                      child: Container(
                                        width: 100,
                                        height: 30,
                                        decoration: BoxDecoration(
                                          color: inMiles
                                              ? Colors.red
                                              : Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: Center(
                                          child: Text(
                                            'Mi.',
                                            style: GoogleFonts.poppins(
                                              textStyle: TextStyle(
                                                color: inMiles
                                                    ? Colors.white
                                                    : Colors.black,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        StatefulBuilder(
                          builder: (context, setState) {
                            return Container(
                              width: double.infinity,
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Center(
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => CountryScreen(),));
                                    setState((){});
                                  },
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left: 8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                'Change country',
                                                style: GoogleFonts.poppins(
                                                  textStyle: const TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.red,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            StreamBuilder<DocumentSnapshot>(
                                              stream: FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).snapshots(),
                                              builder: (context, snapshot) {
                                                if(!snapshot.hasData&&snapshot.hasError){
                                                  return Text("");
                                                }else{
                                                  var d=snapshot.data?["country"];
                                                  return Text(d.toString(),
                                                    style: TextStyle(
                                                      color:
                                                      Color.fromARGB(255, 78, 76, 76),
                                                      fontSize: 12,
                                                      fontWeight: FontWeight.w500,
                                                    ),
                                                  );
                                                }

                                              }
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(right: 8.0),
                                        child: Icon(
                                          Icons.arrow_forward_ios,
                                          color: Colors.grey,
                                          size: 20,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                        SizedBox(height: 30),
                        Text(
                          'Safety and Privacy',
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          width: double.infinity,
                          height: 140,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 8, top: 12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'User Privacy Settings',
                                      style: GoogleFonts.poppins(
                                        textStyle: const TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 6),
                                    Text(
                                      'Set your privacy the way you want',
                                      style: GoogleFonts.poppins(
                                        textStyle: const TextStyle(
                                          fontWeight: FontWeight.w400,
                                          color: Color.fromARGB(
                                              255, 116, 114, 114),
                                          fontSize: 13,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 30),
                                    Text(
                                      'Data Protection System',
                                      style: GoogleFonts.poppins(
                                        textStyle: const TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 6),
                                    Text(
                                      'Activate Data protection',
                                      style: GoogleFonts.poppins(
                                        textStyle: const TextStyle(
                                          fontWeight: FontWeight.w400,
                                          color: Color.fromARGB(
                                              255, 116, 114, 114),
                                          fontSize: 13,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 20),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Switch(
                                      value: state3,
                                      onChanged: (bool value) {
                                        setState(() {
                                          state3 = value;
                                          _setSwitchValue(value);
                                        });
                                      },
                                      activeColor:
                                          Color.fromRGBO(237, 34, 39, 1),
                                      inactiveTrackColor:
                                          Color.fromRGBO(217, 217, 217, 1),
                                      thumbColor:
                                          MaterialStateColor.resolveWith(
                                        (states) =>
                                            Color.fromRGBO(237, 34, 39, 1),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
