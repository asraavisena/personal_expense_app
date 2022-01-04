import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
import './transaction_item.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;

  final Function _deleteTransaction;

  TransactionList(this.transactions, this._deleteTransaction);

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        // ! SETUP IMAGE FOR LANDSCAPE MODE
        ? LayoutBuilder(builder: (ctx, constrains) {
            return Column(
              children: <Widget>[
                Text(
                  'No Transaction added yet!',
                  style: Theme.of(context).textTheme.headline6,
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                    height: constrains.maxHeight * 0.6,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    ))
              ],
            );
          })
        // ! LISTVIEW BUAT SCROLL TP VIEW ALWAYS HAVE INFINITE HEIGHT
        : ListView.builder(
            //! KAYA FOREACH / MAP NYA
            itemBuilder: (ctx, index) {
              // return a widget
              return TransactionItem(
                  transaction: transactions[index],
                  deleteTransaction: _deleteTransaction);
              // ! ANOTHER VERSION WITHOUT LISTTILE
              // Card(
              //     child: Row(
              //   children: <Widget>[
              //     Container(
              //       padding: EdgeInsets.all(10),
              //       margin:
              //           EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              //       // Decoration -> Border
              //       decoration: BoxDecoration(
              //           border: Border.all(
              //               color: Theme.of(context).primaryColorLight,
              //               width: 2)),
              //       child: Text(
              //         '\$ ${transactions[index].amount.toStringAsFixed(2)}',
              //         style: TextStyle(
              //             fontWeight: FontWeight.bold,
              //             fontSize: 16,
              //             color: Theme.of(context).primaryColorDark),
              //       ),
              //     ),
              //     Column(
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       children: <Widget>[
              //         Text(
              //           transactions[index].title,
              //           style: TextStyle(
              //               fontWeight: FontWeight.bold,
              //               fontSize: 16,
              //               color: Colors.black),
              //         ),
              //         Text(
              //           DateFormat.yMMMd().format(transactions[index].date),
              //           style: TextStyle(
              //               fontWeight: FontWeight.w700,
              //               fontSize: 14,
              //               color: Colors.grey[400]),
              //         ),
              //       ],
              //     )
              //   ],
              // )
              // );
            },
            itemCount: transactions.length,
          );
  }
}
