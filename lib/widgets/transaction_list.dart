import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
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
                SizedBox(
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
            itemBuilder: (ctx, index) {
              // return a widget
              return Card(
                elevation: 5,
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    child: Padding(
                      padding: EdgeInsets.all(7),
                      child: FittedBox(
                          child: Text('\$ ${transactions[index].amount}')),
                    ),
                  ),
                  title: Text(
                    transactions[index].title,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  subtitle:
                      Text(DateFormat.yMMMd().format(transactions[index].date)),
                  trailing: MediaQuery.of(context).size.width > 460
                      ? TextButton.icon(
                          onPressed: () =>
                              _deleteTransaction(transactions[index].id),
                          icon: Icon(Icons.delete),
                          label: Text('Delete'),
                          style: TextButton.styleFrom(primary: Colors.red),
                        )
                      : IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () =>
                              _deleteTransaction(transactions[index].id),
                          color: Theme.of(context).errorColor,
                        ),
                ),
              );
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
