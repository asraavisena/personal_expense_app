import 'package:flutter/material.dart';
import './new_transaction.dart';
import './transaction_list.dart';
import '../models/transaction.dart';

// ! GAK DIGUNAIN DI PINDAHIN KE MAIN.DART
class UserTransactions extends StatefulWidget {
  const UserTransactions({Key? key}) : super(key: key);

  @override
  _UserTransactionsState createState() => _UserTransactionsState();
}

class _UserTransactionsState extends State<UserTransactions> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        // NewTransaction(_addTransaction),
        // TransactionList(_userTransactions)
      ],
    );
  }
}
