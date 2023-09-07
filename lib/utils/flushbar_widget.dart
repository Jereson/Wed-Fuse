import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';


flushbar(
    {@required BuildContext? context,
    @required String? title,
    @required String? message,
    @required bool? isSuccess,
    int duration = 5}) {
  Flushbar(
          title: title,
          message: message,
          flushbarPosition: FlushbarPosition.TOP,
          flushbarStyle: FlushbarStyle.FLOATING,
          duration: Duration(seconds: duration),
          backgroundColor: isSuccess! ? Colors.green : Colors.red,
          icon: isSuccess
              ? const Icon(
                  Icons.check,
                  color: Colors.greenAccent,
                )
              : const Icon(
                  Icons.error_outline,
                  color: Colors.white,
                ))
      .show(context!);
}
