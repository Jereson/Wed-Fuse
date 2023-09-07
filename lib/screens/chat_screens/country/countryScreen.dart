import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../chat/countriesListChatRoom.dart';

class CountryScreen extends StatefulWidget {
  const CountryScreen({Key? key}) : super(key: key);

  @override
  State<CountryScreen> createState() => _CountryScreenState();
}

class _CountryScreenState extends State<CountryScreen> {
  CountriesNow countriesNow = CountriesNow();
  List filteredCountries = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: ListView.builder(
        itemCount: countriesNow.countriesNow.length,
        itemBuilder: (context, index) {
          var country = countriesNow.countriesNow[index];

          return InkWell(
            onTap: () async {
              setState(() {
               // print(countriesNow.countriesNow[index]);
                countriesNow.updateCountry(country: countriesNow.countriesNow[index].toString());
                Navigator.pop(context);
                //selectedCountry = country;
              });
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

                ],
              ),
            ),
          );
      },),
    );
  }
}
