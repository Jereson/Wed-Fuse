import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wedme1/constants/colors.dart';

class CustomWidgets {
  static Widget textField(String title,
      {bool isPassword = false,
      bool isNumber = false,
      int? length,
      Function(String)? onChange,
      String? hint,
      IconData? suffixIcon,
      TextEditingController? textController,
      int lines = 1}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // const SizedBox(
          //   height: 10,
          // ),
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.w300, fontSize: 15),
          ),
          const SizedBox(height: 1),
          Container(
            decoration: BoxDecoration(
              color: kEditextColor,
              border: Border.all(
                color: kEditextColor,
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextFormField(
              maxLines: lines,
              controller: textController,
              onChanged: onChange,
              maxLength: length,
              inputFormatters: [
                LengthLimitingTextInputFormatter(length),
              ],
              obscureText: isPassword,
              keyboardType:
                  isNumber ? TextInputType.number : TextInputType.text,
              decoration: InputDecoration(
                hintText: hint,
                border: InputBorder.none,
                suffixIcon: Icon(
                  suffixIcon,
                  color: Colors.black,
                  size: 22,
                ),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
                isDense: true,
              ),
            ),
          )
        ],
      ),
    );
  }
}
