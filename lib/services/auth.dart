import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:veegil/providers.dart';
import 'package:veegil/screens/auth/login.dart';
import 'package:veegil/screens/home.dart';
import 'package:veegil/services/user_preference.dart';

class AuthHandler {
  final String _url = "https://bankapi.veegil.com";

  Future<void> handleSignUp(
      BuildContext context, String phoneNumber, String password) async {
    Map<String, String> body = {
      'phoneNumber': phoneNumber,
      'password': password,
    };

    EasyLoading.show(status: 'Creating account...');

    try {
      final response = await http.post(
        Uri.parse("$_url/auth/signup"),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode(body),
      );

      final res = json.decode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.blue[600],
            content: Text(
              'Account has been created',
              style: TextStyle(color: Colors.white),
            ),
            duration: Duration(seconds: 3),
          ),
        );
        Navigator.popAndPushNamed(context, LoginScreen.id);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.blue[600],
            content: Text(
              "Error: ${res['message']}",
              style: TextStyle(color: Colors.white),
            ),
            duration: Duration(seconds: 3),
          ),
        );
      }
    } finally {
      EasyLoading.dismiss();
    }
  }

  void handleLogin(
      BuildContext context, String phoneNumber, String password) async {
    EasyLoading.show(status: 'Logging in...');

    try {
      Map<String, String> body = {
        'phoneNumber': phoneNumber,
        'password': password,
      };

      final response = await http.post(
        Uri.parse("$_url/auth/login"),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode(body),
      );

      final res = json.decode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        await UserPreference().setPhoneNumber(phoneNumber);
        await UserPreference().setToken(res['data']['token']);
        Navigator.pushNamedAndRemoveUntil(
            context, HomeScreen.id, (route) => false);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.blue[600],
            content: Text(
              "Error: ${res['message']}",
              style: TextStyle(color: Colors.white),
            ),
            duration: Duration(seconds: 3),
          ),
        );
      }
    } finally {
      EasyLoading.dismiss();
    }
  }

  void handleLogout(BuildContext context, WidgetRef ref) async {
    EasyLoading.show(status: 'Logging out...');

    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.clear();
      Navigator.pushNamedAndRemoveUntil(
          context, LoginScreen.id, (route) => false);
      ref.invalidate(setScreen);
    } finally {
      EasyLoading.dismiss();
    }
  }
}