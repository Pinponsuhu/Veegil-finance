import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:veegil/providers.dart';

class DepositDropsheet extends StatelessWidget {
  final WidgetRef ref;
  DepositDropsheet({required this.ref});
  TextEditingController _amount = TextEditingController();
  TextEditingController _phoneNumber = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    
    return Container(
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            spreadRadius: 1, 
            blurRadius: 1, 
            color: Colors.grey
          )
        ],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
        color: Colors.white,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Transfer",
            style: TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _amount,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the amount';
                    }
                    // Add more validation if needed
                    return null;
                  },
                  decoration: InputDecoration(hintText: "Amount"),
                ),
                SizedBox(
                  height: 14,
                ),
                TextFormField(
                  controller: _phoneNumber,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the account number';
                    }
                    // Add more validation if needed
                    return null;
                  },
                  decoration: InputDecoration(hintText: "Account Number"),
                ),
                SizedBox(
                  height: 14,
                ),
                SizedBox(
                  width: double.infinity,
                  child: Consumer(
                    builder: (context, ref, build) => TextButton(
                      onPressed: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          ref.read(transfer({'context': context,'amount': _amount.text,'phoneNumber' : _phoneNumber.text,'ref' : ref}));
                        }
                      },
                      child: Text(
                        "Transfer",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8))),
                        padding: MaterialStateProperty.all(EdgeInsets.all(14)),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.blue.shade600),
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }


}