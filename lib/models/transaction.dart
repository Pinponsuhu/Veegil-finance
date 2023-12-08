import 'dart:convert';

class Transaction {
  final String type;
  final num? amount;
  final String phoneNumber;
  final DateTime created;

  Transaction({
    required this.type,
    required this.amount,
    required this.phoneNumber,
    required this.created,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      type: json['type'],
      amount: json['amount'],
      phoneNumber: json['phoneNumber'],
      created: DateTime.parse(json['created']),
    );
  }
}

class TransactionList {
  final String status;
  final List<Transaction> data;

  TransactionList({
    required this.status,
    required this.data,
  });

  factory TransactionList.fromJson(Map<String, dynamic> json) {
    var list = json['data'] as List;
    List<Transaction> transactionList =
        list.map((data) => Transaction.fromJson(data)).toList();

    return TransactionList(
      status: json['status'],
      data: transactionList,
    );
  }
}
