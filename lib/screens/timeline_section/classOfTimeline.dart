// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:ui';
import 'package:flutter/material.dart';


class UserProfileT {
  UserProfileT({
    required this.displayName,
    required this.fullName,
    required this.email,
    required this.photoUrl,
    required this.phoneNumber,
    required this.userId,
    required this.signUpMethod,
    required this.authverified,
    required this.createdAt,
    required this.otp,
    required this.countryCode,
    required this.country,
    required this.city,
    required this.religion,
    required this.gender,
    required this.genoType,
    required this.temperament,
    required this.choice,
    required this.bannerPic,
    required this.isVerified,
    required this.isOnline,
    required this.age,
    required this.birthDay,
    required this.birthMonth,
    required this.birthYear,
    required this.lat,
    required this.lng,
    required this.balance,
    required this.course,
    required this.schoolName,
    required this.marriageRadyness,
    required this.aboutMe,
    required this.love,
    required this.storylineCount,
    required this.images,
    required this.interest,
    required this.storylineUrl,
  });

  String displayName;
  String fullName;
  String email;
  String photoUrl;
  String phoneNumber;
  String userId;
  String signUpMethod;
  String authverified;
  String createdAt;
  String otp;
  String countryCode;
  String country;
  String city;
  String religion;
  String gender;
  String genoType;
  String temperament;
  String choice;
  String bannerPic;
  String isVerified;
  String isOnline;
  String age;
  String birthDay;
  String birthMonth;
  String birthYear;
  String lat;
  String lng;
  String balance;
  String course;
  String schoolName;
  String marriageRadyness;
  String aboutMe;
  String love;
  String storylineCount;
  String images;
  String interest;
  String storylineUrl;

  factory UserProfileT.fromJson(Map<String, dynamic> json) => UserProfileT(
    displayName: json["displayName"],
    fullName: json["fullName"],
    email: json["email"],
    photoUrl: json["photoUrl"],
    phoneNumber: json["phoneNumber"],
    userId: json["userId"],
    signUpMethod: json["signUpMethod"],
    authverified: json["authverified"],
    createdAt: json["createdAt"],
    otp: json["otp"],
    countryCode: json["countryCode"],
    country: json["country"],
    city: json["city"],
    religion: json["religion"],
    gender: json["gender"],
    genoType: json["genoType"],
    temperament: json["temperament"],
    choice: json["choice"],
    bannerPic: json["bannerPic"],
    isVerified: json["isVerified"],
    isOnline: json["isOnline"],
    age: json["age"],
    birthDay: json["birthDay"],
    birthMonth: json["birthMonth"],
    birthYear: json["birthYear"],
    lat: json["lat"],
    lng: json["lng"],
    balance: json["balance"],
    course: json["course"],
    schoolName: json["schoolName"],
    marriageRadyness: json["marriageRadyness"],
    aboutMe: json["aboutMe"],
    love: json["love"],
    storylineCount: json["storylineCount"],
    images: json["images"],
    interest: json["interest"],
    storylineUrl: json["storylineUrl"],
  );

  Map<String, dynamic> toJson () => {
    "displayName": displayName,
    "fullName": fullName,
    "email": email,
    "photoUrl": photoUrl,
    "phoneNumber": phoneNumber,
    "userId": userId,
    "signUpMethod": signUpMethod,
    "authverified": authverified,
    "createdAt": createdAt,
    "otp": otp,
    "countryCode": countryCode,
    "country": country,
    "city": city,
    "religion": religion,
    "gender": gender,
    "genoType": genoType,
    "temperament": temperament,
    "choice": choice,
    "bannerPic": bannerPic,
    "isVerified": isVerified,
    "isOnline": isOnline,
    "age": age,
    "birthDay": birthDay,
    "birthMonth": birthMonth,
    "birthYear": birthYear,
    "lat": lat,
    "lng": lng,
    "balance": balance,
    "course": course,
    "schoolName": schoolName,
    "marriageRadyness": marriageRadyness,
    "aboutMe": aboutMe,
    "love": love,
    "storylineCount": storylineCount,
    "images": images,
    "interest": interest,
    "storylineUrl": storylineUrl,
  };
}



var firebaseAdmin = FirebaseFirestore.instance.collection("Amin").doc("School").collection("JSS1").doc();


var user = FirebaseAuth.instance.currentUser;
var userCollection = FirebaseFirestore.instance.collection('users').doc(user?.uid);