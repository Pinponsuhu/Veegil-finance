import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:veegil/models/transaction.dart';
import 'package:veegil/models/usersModel.dart';
import 'package:veegil/providers.dart';
import 'package:veegil/services/user_preference.dart';

class TransactionHandler extends ChangeNotifier{
  final String _url = "https://bankapi.veegil.com";

  bool isLoading = false;

  Future handleGetTransaction() async {
    isLoading = true;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = await UserPreference().getToken();
    final response = await http.get(Uri.parse('$_url/transactions'), headers: {
      'Authorization': 'bearer $token',
      'Content-Type': 'application/json',
      'Accept': 'application/json'
    });
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return TransactionList.fromJson(json);
    } else {
      throw Exception('Failed to load transactions');
    }
  }

  

  Future<UserModel?> getUsers() async {
  try {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = await UserPreference().getToken();
    final accountNumber = await UserPreference().getPhoneNumber();
    
    final response = await http.get(Uri.parse('$_url/auth/users'), 
      headers: {
        'Authorization': 'bearer $token',
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      }
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final json = jsonDecode(response.body);

      if (json.containsKey('data')) {
        final userDataList = (json['data'] as List)
          .map((userData) => UserData.fromJson(userData))
          .toList();

        final userData = userDataList.firstWhere(
          (user) => user.phoneNumber == accountNumber,
          orElse: () => UserData(phoneNumber: "", created: ""),
        );

        if (userData != null) {
          final userModel = UserModel(
            status: json['status'],
            message: json['message'],
            data: [userData],
          );

          return userModel;
        } else {
          throw Exception('User with account number not found');
        }
      } 
    } else {
      throw Exception('Failed to load balance.');
    }
  } catch (error) {
    throw error; 
  }
}


  Future handleWithdraw(BuildContext context,String amount,WidgetRef ref) async{
    final phoneNumber = await UserPreference().getPhoneNumber();
    Map<String, dynamic> body = {
        'amount' : double.parse(amount), 
        'phoneNumber' : phoneNumber
    };

    final token = await UserPreference().getToken();

    final response = await http.post(
      Uri.parse("$_url/accounts/withdraw"), 
      headers: {
        'Content-Type' : 'application/json', 
        'Accept' : 'application/json', 
        'Authorization': 'bearer $token',
      }, 
      body: jsonEncode(body)
      );
      final res = json.decode(response.body);
      if(response.statusCode == 200 || response.statusCode == 201){
        ref.invalidate(getTransaction);
        ref.invalidate(getUsersProvider);

        Navigator.of(context).pop();
      }else{
         ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.blue[600],
                content: Text(
                  "Error: ${res['message']}", 
                  style: TextStyle(
                    color: Colors.white
                  ),
                  ),
                duration: Duration(seconds: 3), 
              ),
        );
      }
  }
  Future handleTransfer(BuildContext context,String amount,String phoneNumber,WidgetRef ref) async{
    Map<String, dynamic> body = {
        'amount' : double.parse(amount), 
        'phoneNumber' : phoneNumber
    };

    final token = await UserPreference().getToken();

    final response = await http.post(
      Uri.parse("$_url/accounts/transfer"), 
      headers: {
        'Content-Type' : 'application/json', 
        'Accept' : 'application/json', 
        'Authorization': 'bearer $token',
      }, 
      body: jsonEncode(body)
      );
      final res = json.decode(response.body);
      if(response.statusCode == 200 || response.statusCode == 201){
        ref.invalidate(getTransaction);
        Navigator.of(context).pop();
      }else{
         ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.blue[600],
                content: Text(
                  "Error: ${res['message']}", 
                  style: TextStyle(
                    color: Colors.white
                  ),
                  ),
                duration: Duration(seconds: 3), 
              ),
        );
      }
  }
}
