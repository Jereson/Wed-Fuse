import 'dart:io';
import 'package:flutter/material.dart';
import 'package:wedme1/utils/flushbar_widget.dart';

firebaseErrorCode(BuildContext context, String code) {
  if (code == 'weak-password') {
    flushbar(
        context: context,
        title: 'Weak Password',
        message: 'Your password is weak. Enter strong password',
        isSuccess: false);
  } else if (code == 'email-already-in-use') {
    flushbar(
        context: context,
        title: 'User already exist',
        message:
            'Account already exist for the email. Please contact the admin',
        isSuccess: false);
  } else if (code == 'user-not-found') {
    flushbar(
        context: context,
        title: 'User not found',
        message: 'No user found for the email.',
        isSuccess: false);
  } else if (code == 'network-request-failed') {
    flushbar(
        context: context,
        title: 'Internet',
        message: 'Please check your connection and try again.',
        isSuccess: false);
  } else if (code == 'too-many-requests') {
    flushbar(
        context: context,
        title: 'Too many request',
        message: 'You have made too many request. Please try again later',
        isSuccess: false);
  } else if (code == 'session-expired') {
    flushbar(
        context: context,
        title: 'Expires',
        message: 'Session expired, try again.',
        isSuccess: false);
  } else if (code == 'user-disabled') {
    flushbar(
        context: context,
        title: 'Unautharisation',
        message: 'Unathorisation, please contact the admin',
        isSuccess: false);
  } else if (code == 'wrong-password') {
    flushbar(
        context: context,
        title: 'Invalid',
        message: 'Invalid credential, please try again.',
        isSuccess: false);
  } else if (code == 'invalid-email') {
    flushbar(
        context: context,
        title: 'Invalid',
        message: 'Invalid email, please try again.',
        isSuccess: false);
  } else if (code == 'invalid-phone-number') {
    flushbar(
        context: context,
        title: 'Invalid phone number',
        message: 'The provided phone number is not valid',
        isSuccess: false);
  } 
  else if(code =='invalid-verification-code'){
    flushbar(
        context: context,
        title: 'Invalid token ',
        message: 'The provided token is not valid',
        isSuccess: false);
  }
  else {
    flushbar(
        context: context,
        title: 'Error',
        message: 'Error occured! Tyr again.',
        isSuccess: false);
  }
}

otherExeption(BuildContext context, Object e) {
  if (e == SocketException) {
    flushbar(
        context: context,
        title: 'Internet',
        message: 'Please check your connection and try again.',
        isSuccess: false);
  }

  flushbar(
      context: context,
      title: 'Unknown Error',
      message: 'Error occured! Try again.',
      isSuccess: false);
}
