import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:veegil/components/creditSection.dart';
import 'package:veegil/components/debitSection.dart';
import 'package:veegil/providers.dart';

class TransactionWidget extends ConsumerWidget {

  @override
  Widget build(BuildContext context,ref) {

    final transactions = ref.watch(getTransaction);
    
    return TabBarView(
          children: [
            CreditSection(),
            DebitSection(),
          ],
        );
  }
}