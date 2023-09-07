import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import '../../chat/countryRoom.dart';
import '../../chat/room_chat_state.dart';
import '/widget/button_widget.dart';

import '../../chat/groupChat/roomChatLikeHome.dart';

class ChatStateRoom extends StatefulWidget {
  const ChatStateRoom({Key? key}) : super(key: key);

  @override
  State<ChatStateRoom> createState() => _ChatStateRoomState();
}

class _ChatStateRoomState extends State<ChatStateRoom> {
  final TextEditingController _searchController = TextEditingController();

  CountryRoom countriesNew = CountryRoom();

  String? selectedCountry;
  List filteredCountries = [];

  String countrySelected ="";



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    filteredCountries = countriesNew.countryRoom;
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(height: 60.sp,),
          Padding(
            padding: const EdgeInsets.only(left: 14, right: 14, bottom: 8),
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

                onChanged: (value) {

                  setState(() {
                    filteredCountries = countriesNew.countryRoom
                        .where((country) => country["name"].toLowerCase().contains(value))
                        .toList();
                  });

                },
                controller: _searchController,
                decoration: const InputDecoration(
                  hintText: "Search Country",
                  border: InputBorder.none,
                  suffixIcon: Icon(
                    Icons.search,
                    color: Colors.black,
                    size: 22,
                  ),
                  contentPadding:
                  EdgeInsets.symmetric(vertical: 14, horizontal: 10),
                  isDense: true,
                ),


              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: filteredCountries.length,
                itemBuilder: ((context, index) {
                  var country = filteredCountries[index]["name"];
                  return InkWell(
                    onTap: () async {
                      setState(() {
                        selectedCountry = country;
                        print(filteredCountries[index]["isoCode"]);


                      });
                      SharedPreferences prefs = await SharedPreferences.getInstance();
                      await prefs.setString('selectedCountry', selectedCountry!);
                    },
                    child: Container(
                      margin: const EdgeInsets.only(left: 26, bottom: 8),
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
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 30, bottom: 4),
            child: ProceedButtonWidget(
              size: size,
              text: 'Proceed',
              press: () {
                if(selectedCountry!.isEmpty){

                }else{
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const ChatStateRoom(),));

                  //Navigator.of(context).push(MaterialPageRoute(builder: (context) => RoomChatLikeHome(country: selectedCountry!,),));
                }
              },
            ),
          ),
          SizedBox(height: 1.h)
        ],
      ),
    );
  }

}
