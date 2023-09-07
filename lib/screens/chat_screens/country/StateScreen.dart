import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../../../chat/countryRoom.dart';
import '../../../chat/groupChat/chatControl/ChatControl.dart';
import '../../../chat/groupChat/roomChatLikeHome.dart';
import '../../../chat/stateRoom.dart';
import '/widget/button_widget.dart';

class StateScreen extends StatefulWidget {
  const StateScreen({Key? key,required this.country, required this.roomCountry}) : super(key: key);
  final String country;
  final String roomCountry;

  @override
  State<StateScreen> createState() => _StateScreenState();
}

class _StateScreenState extends State<StateScreen> {
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _searchControllerS = TextEditingController();
  final PageController _pageViewController = PageController(initialPage: 0);

  CountryRoom countriesNew = CountryRoom();
  StateRoom countriesNewS = StateRoom();

  String? selectedCountry;
  String? selectedCountryS;
  List filteredCountries = [];
  List filteredCountriesS = [];


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    filteredCountries = countriesNew.countryRoom.toList();
    filteredCountriesS = countriesNewS.stateRoom.toList();
    dyn();
  }
  String countryIdN="";


  dyn() async {
    final prefs = await SharedPreferences.getInstance();
    String? action = prefs.getString('sortname');
    setState(() {
      countryIdN = action ?? "";
    });
  }



  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(
            height: 18.sp,
          ),
          Expanded(
            child: PageView(
              controller: _pageViewController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                Column(
                  children: [
                    Padding(
                      padding:
                      const EdgeInsets.only(left: 14, right: 14, bottom: 8),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          border: Border.all(
                            color: Colors.grey.shade100,
                            width: 1.0,
                          ),
                        ),
                        child: TextFormField(
                          maxLines: 1,
                          onChanged: (value) => _runFilterS(value),
                          controller: _searchControllerS,
                          decoration: const InputDecoration(
                            hintText: "Search State",
                            border: InputBorder.none,
                            suffixIcon: Icon(
                              Icons.search,
                              color: Colors.black,
                              size: 22,
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 14, horizontal: 10),
                            isDense: true,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      key: const ValueKey("state"),
                      child: ListView.builder(
                          itemCount: filteredCountriesS.where((map) => map["countryCode"] == widget.country).length,
                          itemBuilder: ((context, index) {
                            var filteredList = filteredCountriesS.where((map) => map["countryCode"] ==widget.country).toList();
                            filteredList.sort((a, b) => a["name"].compareTo(b["name"])); // sort the list alphabetically by name
                            var item = filteredList[index];
                            return InkWell(
                              onTap: () async {
                                setState(() {
                                  selectedCountryS = item["name"];
                                });
                                var prefs = await SharedPreferences.getInstance();
                                await prefs.setString('selectedCountryS',selectedCountryS! );

                              },
                              child: Container(
                                margin:
                                const EdgeInsets.only(left: 26, bottom: 8),
                                width: double.infinity,
                                decoration: const BoxDecoration(),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        item["name"] ?? "",
                                        style: GoogleFonts.poppins(
                                          textStyle: TextStyle(
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.w400,
                                            letterSpacing: -0.4,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 20),
                                    if (selectedCountryS == item["name"])
                                      const Icon(
                                        Icons.check,
                                        color: Colors.red,
                                      ),
                                  ],
                                ),
                              ),
                            );
                          })
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 30, bottom: 4),
                      child: ProceedButtonWidget(
                        size: size,
                        text: 'Proceed',
                        press: () {
                          if(selectedCountryS!.isEmpty){

                          }else{
                            Navigator.push(context, MaterialPageRoute(builder: (context) =>RoomChatLikeHome(country: widget.roomCountry, state: selectedCountryS!,) ,));

                          }
                        },
                      ),
                    ),

                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 1.h)
        ],
      ),
    );
  }

  _runFilter(String value) {
    List result = [];
    if (value.isEmpty) {
      result = countriesNew.countryRoom;
    } else {
      String searchValue =
          value.substring(0, 1).toUpperCase() + value.substring(1);
      result = countriesNew.countryRoom.where((element) {
        return element["name"].toString().contains(searchValue);
      }).toList();
    }
    setState(() {
      filteredCountries = result;
    });
  }

  _runFilterS(String value) {
    List resultS = [];
    if (value.isEmpty) {
      resultS = countriesNewS.stateRoom;
    } else {
      String searchValue =
          value.substring(0, 1).toUpperCase() + value.substring(1);
      resultS = countriesNewS.stateRoom.where((element) {
        return element["name"].toString().contains(searchValue);
      }).toList();
    }
    setState(() {
      filteredCountriesS = resultS;
    });
  }
}
