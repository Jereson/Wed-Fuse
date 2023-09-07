import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:stacked/stacked.dart';
import '../../chat/countryRoom.dart';
import '../../chat/stateRoom.dart';
import '../../models/stack_model/users_model.dart';
import '../../viewModel/profile_vm.dart';
import '/widget/button_widget.dart';
import 'country/StateScreen.dart';

class ChatRoom extends StatefulWidget {
  const ChatRoom({Key? key}) : super(key: key);

  @override
  State<ChatRoom> createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  final TextEditingController _searchController = TextEditingController();
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

  String countryIdN = "";
  String selectedCountryId = "";
  String selectedRoomCountryId = "";

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

    return ViewModelBuilder<UsersModel>.reactive(
      viewModelBuilder: () => UsersModel(),
      builder: (context, viewModel, child) => Column(
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
                          onChanged: (value) => _runFilter(value),
                          controller: _searchController,
                          decoration: const InputDecoration(
                            hintText: "Search Country",
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
                      key: const ValueKey("country"),
                      child: ListView.builder(
                          itemCount: 1,
                          // itemCount: filteredCountries.length,
                          itemBuilder: ((context, index) {
                            // var country = filteredCountries[index]["name"];
                            var country =
                                "Nigeria"; // set the country name to Nigeria
                            return InkWell(
                              onTap: () async {
                                setState(() {
                                  selectedCountry = country;
                                  selectedRoomCountryId = "Nigeria";
                                  // selectedRoomCountryId=filteredCountries[index]["name"];
                                  selectedCountryId = "NG";
                                  //selectedCountryId=filteredCountries[index]["isoCode"];
                                });
                                var prefs =
                                    await SharedPreferences.getInstance();
                                await prefs.setString(
                                    'sortname', selectedRoomCountryId);
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
                                        country,
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
                                    if (selectedCountry == country)
                                      const Icon(
                                        Icons.check,
                                        color: Colors.red,
                                      ),
                                  ],
                                ),
                              ),
                            );
                          })),
                    ),
                    ProfileViewModel().validateSubscriptionStus(viewModel.userAccount?.subscriptionDueDate ?? "${DateTime.now()}") &&
                        viewModel.userAccount?.subscriptionType == "premium"
                        ?  Container()
                        : Padding(
                      padding:
                      const EdgeInsets.only(left: 20, right: 30, bottom: 4),
                      child: ProceedButtonWidget(
                        size: size,
                        text: 'Proceed',
                        press: () async {
                          if (selectedCountry!.isEmpty) {
                          } else {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => StateScreen(
                                    country: selectedCountryId,
                                    roomCountry: selectedRoomCountryId,
                                  ),
                                ));
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
}
