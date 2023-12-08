import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:veegil/components/homeWidget.dart';
import 'package:veegil/components/settingWidget.dart';
import 'package:veegil/components/transactionWidget.dart';
import 'package:veegil/providers.dart';

class HomeScreen extends ConsumerWidget {
  static String id = '/home';

  bool isVisible = false;

  // int _currentScreen = 0;

  List<Map<String, dynamic>> _screens = [
    {
    'title' : 'Welcome', 
    'screen' : HomeWidget(), 
  },
    {
    'title' : 'Transactions', 
    'screen' : TransactionWidget(), 
  },
    {
    'title' : 'Settings', 
    'screen' : SettingsWidget(), 
  }
  ];

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    int _currentScreen = ref.watch(setScreen.notifier).state;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          backgroundColor: Colors.white,
        appBar: AppBar(
          
          title: Text(
            "${_screens[_currentScreen]['title']}", 
            style: TextStyle(
              fontWeight: FontWeight.bold, 
              color: _currentScreen == 1 ? Colors.white : Colors.black
            ),
            ),
          automaticallyImplyLeading: false,
          centerTitle: false,
          actions: [
            IconButton(onPressed: (){
              ref.refresh(getTransaction);
              ref.refresh(getUsersProvider);
            }, icon: Icon(Icons.refresh)
            )
          ],
          
          backgroundColor: _currentScreen == 1 ? Colors.blue : Colors.white,
          bottom: _currentScreen == 1 ? TabBar(
              indicatorColor: _currentScreen == 1 ? Colors.blue : Colors.white,
              indicatorWeight: 6,
              indicatorSize: TabBarIndicatorSize.label,
              labelColor: Colors.white,
              tabs: [
                Tab(
                  text: "Credit",
                ),
                Tab(
                  text: "Debit",
                ),
              ]) : null,
        ),
        body: _screens[_currentScreen]['screen'] as Widget,
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: ref.watch(setScreen.notifier).state,
          onTap: (int value){
            ref.invalidate(setScreen);
           ref.read(setScreen.notifier).state = value;
            print(_currentScreen);
            // setState(() {
            //   _currentScreen  = value;
            // });
            
          },
          backgroundColor: Colors.white,
          elevation: 5, 
          selectedItemColor: Colors.blue.shade600,
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home_outlined, 
                ), 
              label: "Home"
              ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.list_outlined, 
                ), 
              label: "Transactions"
              ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.settings, 
                ), 
              label: "Settings"
              ),
              ],
        ),
      ),
    );
  }
}