import 'package:shared_preferences/shared_preferences.dart';


class UserPreference{

  Future<void> setPhoneNumber(String phoneNumber) async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('phoneNumber', phoneNumber
    );
  }
  Future<void> setToken(var token) async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', token
    );
  }

  Future<String?> getToken() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    // final token = prefs.getString('token');

    return prefs.getString('token');
  }
  Future<String?> getPhoneNumber() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    // final phoneNumber = prefs.getString('phoneNumber');

    return prefs.getString('phoneNumber');
  }
}