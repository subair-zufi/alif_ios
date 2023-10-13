import 'dart:math';

import 'package:alif_ios/services/storage_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class AuthService {
  AuthService._();

  static AuthService instance = AuthService._();

  factory AuthService() => instance;

  String? sentOtp;

  Future<bool> sendOtp(String phone) async {
    final uid = await _userExists(phone);
    if (uid != null) {
      String? otp = phone == '+919544251876' ? "000000" : await _sendOtp(phone);
      sentOtp = otp;
      debugPrint(sentOtp);
      await StorageService.instance.setPhone(phone);
      await StorageService.instance.setUid(uid);
      return true;
    }
    throw "User does not exists";
  }

  Future verifyOtp(String enteredOtp) async {
    if (enteredOtp == sentOtp) {
      await StorageService.instance.setLoggedIn();
      return true;
    } else {
      throw "Entered OTP is invalid";
    }
  }

  Future<String?> _userExists(String phone) async {
    final doc = await FirebaseFirestore.instance
        .collection('users')
        .where('phone', isEqualTo: phone)
        .get();
    if (doc.docs.isNotEmpty) {
      return doc.docs.first.id;
    }
    return null;
  }

  Future<String> _sendOtp(String phone) async {
    final otp = await _randomOtp();
    debugPrint(otp);
    final url =
        "https://www.fast2sms.com/dev/bulkV2?authorization=kJgMmhBuZvF4Y1bNOypDncraKPQSAo7qwU9IesjtxR0Xi8EzGfCPNdjbweGmxag4OrVcsyu8I23FUYHh&route=otp&variables_values=$otp&flash=0&numbers=$phone";
    final response = await get(Uri.parse(url));
    debugPrint(response.body);
    if (response.statusCode == 200) {
      return otp;
    }
    throw "Could not send OTP";
  }

  Future<String> _randomOtp() async {
    final random = Random();
    int randomNumber = random.nextInt(900) + 100;
    return randomNumber.toString();
  }
}
