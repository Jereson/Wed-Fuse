import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'choose_coin_class_model.dart';

class MyDropdownButton extends StatefulWidget {
  const MyDropdownButton({Key? key, required this.userName}) : super(key: key);
  final String userName;

  @override
  _MyDropdownButtonState createState() => _MyDropdownButtonState();
}

class _MyDropdownButtonState extends State<MyDropdownButton> {
  String _selectedItem = '';
  List<String> _bankNames = [];
  final TextEditingController _accountNumberController = TextEditingController();

  String nameOfBank="";

  @override
  void initState() {
    super.initState();
    fetchBanks();
  }

  Future<void> resolveAccount() async {
    String baseUrl = 'https://api.flutterwave.com/v3/banks';
    String apiKey = 'FLWSECK-4cf8676cdba3aed7d416384554fc2ac0-1880747a49fvt-X'; // Replace with your actual API key
    final body = {
      'account_number': '035',
      'account_bank': '7156638558',
    };
    Map<String, String> headers = {'Authorization': 'Bearer $apiKey'};
    final url = Uri.parse('https://api.flutterwave.com/v3/accounts/resolve');

    final response = await http.post(url, headers: headers, body: jsonEncode(body));

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      print(responseBody);
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  void fetchBanks() async {
    String baseUrl = 'https://api.flutterwave.com/v3/banks';
    String country = 'NG';
    String apiKey = 'FLWSECK-4cf8676cdba3aed7d416384554fc2ac0-1880747a49fvt-X'; // Replace with your actual API key

    String url = '$baseUrl/$country';
    Map<String, String> headers = {'Authorization': 'Bearer $apiKey'};

    http.Response response = await http.get(Uri.parse(url), headers: headers);

    if (response.statusCode == 200) {
      var responseData = json.decode(response.body);

      List<dynamic> banks = responseData['data'];
      List<String> bankNames = banks.map((bank) => bank['name'] as String).toList();

      setState(() {
        _bankNames = bankNames;
        _selectedItem = _bankNames.isNotEmpty ? _bankNames[0] : '';
      });
    } else {
      // Handle error case
    }
  }

  String retrieveBankId(String bankName) {
    // Map the bank name to its corresponding ID
    // Replace this logic with your own mapping based on the bank names and IDs you have
    if (bankName == 'Bank 1') {
      return 'Bank1Id';
    } else if (bankName == 'Bank 2') {
      return 'Bank2Id';
    } else if (bankName == 'Bank 3') {
      return 'Bank3Id';
    }
    // Return a default value or handle an unknown bank name
    return '';
  }

  @override
  void dispose() {
    _accountNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
        Container(
        height: 47.69,
        width: 315,
        padding: const EdgeInsets.only(left: 13,right: 13),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: const BorderRadius.all(Radius.circular(10))
        ),
          child: Row(
            children: [
              DropdownButton<String>(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                dropdownColor: Colors.white,
                value: _selectedItem,
                iconEnabledColor: Colors.white,
                underline: Container(), // Remove the default underline
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedItem = newValue!;
                    nameOfBank = newValue;
                  });
                },
                items: _bankNames.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.57,
                      child: Text(value),
                    ),
                  );
                }).toList(),
              ),
              const Icon(Icons.keyboard_arrow_down),
            ],
          ),
        ),
          const SizedBox(height: 10),
          Column(
            children: [
              Row(
                children: const [
                  Text(
                    "Account number:",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Container(
                height: 47.69,
                width: 315,
                padding: const EdgeInsets.only(left: 13,right: 13),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: const BorderRadius.all(Radius.circular(10))
                ),
                child: TextField(
                  controller: _accountNumberController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Enter account number',
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Container(
            height: 47.69,
            width: 315,
            padding: const EdgeInsets.only(left: 13,right: 13),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.red),
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              color: Colors.red,

            ),
            child: TextButton(
              onPressed: () {
                 String accountNumber = _accountNumberController.text.trim();
                 String bankId = retrieveBankId(_selectedItem);
                 print("nameOfBank $nameOfBank");
                 print("bankId ${widget.userName}");
                 if(accountNumber.isNotEmpty&&nameOfBank.isNotEmpty){
                   ChooseAccountModel().addBankAccount(bankName: nameOfBank, accountNumber: accountNumber, accountName: widget.userName, context: context);
                 }

                 
              },
              child: const Text('Proceed',style: TextStyle(color: Colors.white),),
            ),
          ),
          const SizedBox(height: 20),
        ],
    );
  }
}

