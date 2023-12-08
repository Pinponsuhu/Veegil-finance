import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:veegil/providers.dart';
import 'package:veegil/screens/auth/login.dart';
import 'package:veegil/screens/home.dart';

class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  static String id = '/splash';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(tokenProvider, (previous, next) async{
      Future.delayed(Duration(seconds: 3));
      print(next.value);
      next.value == null ? Navigator.pushNamedAndRemoveUntil(context, LoginScreen.id, (route) => false) : Navigator.pushNamedAndRemoveUntil(context, HomeScreen.id, (route) => false);
     });
    return Container(
      color: Colors.white,
      child: Center(
        child: 
        Image.asset('images/veegillogo.png',
        )),
    );
  }
}