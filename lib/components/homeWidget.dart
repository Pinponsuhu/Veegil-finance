import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:veegil/components/transferMenu.dart';
import 'package:veegil/components/withdrawMenu.dart';
import 'package:veegil/models/usersModel.dart';
import 'package:veegil/providers.dart';
import 'package:veegil/services/transactions.dart';
import 'package:veegil/services/user_preference.dart';

class HomeWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final accNumber = ref.watch(getUsersProvider);
    final transaction = ref.watch(getTransaction);
    final phoneNo = ref.watch(phoneNumberProvider);
    return Container(
      padding: EdgeInsets.all(14),
      child: Column(
        children: [
          Container(
            height: 216,
            width: double.infinity,
            padding: EdgeInsets.all(14),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Colors.blue.shade300, Colors.blue.shade700])),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Account Number",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Text(
                  "${phoneNo.when(data: (data) => data, error: (e, _) => "Error getting account", loading: () => "Loading")}",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      Text(
                        "Amount",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      accNumber.when(
                          data: (value) {
                            if (value!.data.isNotEmpty) {
                              final account = value.data[0].balance;
                              return Text(
                                account.toString(),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24,
                                ),
                              );
                            } else {
                              return Text("No user data available");
                            }
                          },
                          error: (error, _) => Text("err"),
                          loading: () => Text("Loading"))
                    ]),
                   
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        showBottomSheet(
                            context: context,
                            builder: (context) {
                              return WithdrawDropsheet(ref: ref);
                            });
                      },
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4))),
                        padding: MaterialStateProperty.all(
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10)),
                        // backgroundColor: MaterialStateProperty.all(Colors.white)
                      ),
                      child: Text(
                        "Withdraw",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    TextButton(
                      onPressed: () {
                        showBottomSheet(
                            context: context,
                            builder: (context) {
                              return DepositDropsheet(ref: ref);
                            });
                      },
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4))),
                        padding: MaterialStateProperty.all(
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10)),
                        // backgroundColor: MaterialStateProperty.all(Colors.white)
                      ),
                      child: Text(
                        "Deposit",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          SizedBox(
            height: 12,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Recent Transactions",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              Consumer(
                builder: (context, ref, build) => TextButton(
                    onPressed: () {
                      ref.invalidate(setScreen);
                      ref.read(setScreen.notifier).state = 1;
                    },
                    child: Text(
                      "See all",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue.shade700,
                        fontSize: 16,
                      ),
                    )),
              )
            ],
          ),
          Expanded(
              child: transaction.when(
            data: (value) {
              final vals = value.data;
              List values = vals.reversed.toList() ;
              return ListView.builder(
                  shrinkWrap: true,
                  reverse: false,
                  itemCount: values.length > 12 ? 12 : value.data.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: Icon(
                        values[index].type == 'debit'
                            ? Icons.arrow_upward_outlined
                            : Icons.arrow_downward_outlined,
                        color: values[index].type == 'debit'
                            ? Colors.red
                            : Colors.green,
                      ),
                      title: Text(values[index].phoneNumber),
                      subtitle: Text(values[index].amount.toString()),
                    );
                  });
            },
            error: (error, _) => Text(error.toString()),
            loading: () => Text("loading"),
          ))
        ],
      ),
    );
  }
}
