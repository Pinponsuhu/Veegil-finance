import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:veegil/providers.dart';

class CreditSection extends ConsumerWidget {
  // var transaction; 
  // CreditSection({this.transaction});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final transactions = ref.watch(getTransaction);
    
    return Container(
      child: transactions.when(
        data: (value){
              final vals = value.data;
               final debitTransactions =
          vals.where((transaction) => transaction.type == 'credit').toList();
              List values = vals.reversed.toList() ;

          return ListView.builder(
                  shrinkWrap: true,
                  reverse: false,
                  itemCount: debitTransactions.length,
                  itemBuilder: (context, index) {
                    final transaction = debitTransactions[index];
                    return ListTile(
                      leading: Icon(
                        Icons.arrow_downward_outlined,
                        color:  Colors.green,
                      ),
                      title: Text(transaction.phoneNumber),
                      subtitle: Text(transaction.amount.toString()),
                    );
                  });
        }, 
        error: (error,_)=> Text("erro"), 
        loading: ()=> Text("loading"))
    );
  }
}