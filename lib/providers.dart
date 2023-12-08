import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:veegil/services/auth.dart';
import 'package:veegil/services/transactions.dart';
import 'package:veegil/services/user_preference.dart';

final phoneNumberProvider = FutureProvider.autoDispose((ref) async=>await UserPreference().getPhoneNumber());
final tokenProvider = FutureProvider.autoDispose((ref) async=>await UserPreference().getToken());
final signUp = Provider.autoDispose.family<void,Map<String,dynamic>>((ref, params) => AuthHandler().handleSignUp(params['context'], params['phoneNumber'], params['password']));
final login = Provider.autoDispose.family<void,Map<String,dynamic>>((ref,params) => AuthHandler().handleLogin(params['context'], params['phoneNumber'], params['password'])); 
final withdraw = Provider.autoDispose.family<void,Map<String,dynamic>>((ref,params) => TransactionHandler().handleWithdraw(params['context'], params['amount'],params['ref'])); 
final transfer = Provider.autoDispose.family<void,Map<String,dynamic>>((ref,params) => TransactionHandler().handleTransfer(params['context'], params['amount'],params['phoneNumber'],params['ref'])); 
final getTransaction = FutureProvider.autoDispose((ref) => TransactionHandler().handleGetTransaction());
final getUsersProvider = FutureProvider.autoDispose((ref) => TransactionHandler().getUsers());
final logoutProvider = Provider.family<void, Map<String, dynamic>>((ref,params) => AuthHandler().handleLogout(params['ctx'],params['ref']));
final setScreen = StateProvider.autoDispose<int>((ref) => 0);
