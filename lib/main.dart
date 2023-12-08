import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:veegil/screens/auth/login.dart';
import 'package:veegil/screens/auth/register.dart';
import 'package:veegil/screens/home.dart';
import 'package:veegil/screens/splash.dart';

void main() {
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Veegil Finance',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue.shade600),
        useMaterial3: true,
      ),
     initialRoute: SplashScreen.id,
     routes: {
      LoginScreen.id : (context)=> LoginScreen(),
      RegisterScreen.id : (context)=> RegisterScreen(),
      HomeScreen.id : (context)=> HomeScreen(),
      SplashScreen.id : (context)=> SplashScreen(),
     },
     builder: EasyLoading.init(),
    );
  }
}
