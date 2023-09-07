


import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:stacked/stacked.dart';
import 'package:http/http.dart'as http;
import 'package:wedme1/utils/constant_utils.dart';
import 'bank_drop_down.dart';

class RedeemCoin extends BaseViewModel {
  final String userName;

   RedeemCoin({required this.userName});

  Future<void> showBottomSheet(BuildContext context) async {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Set this to true
      builder: (BuildContext context) {
        return SingleChildScrollView( // Wrap with SingleChildScrollView
          child: Container(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom, // Adjust padding for keyboard
            ),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(26.2742)),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 35.0, right: 35),
              child: ListView(
                shrinkWrap: true,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 34,),
                      Row(
                        children: const [
                          Text(
                            "Choose bank:",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6,),
                        MyDropdownButton(userName: userName,),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
