import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;

  final Function _deleteTransaction;

  TransactionList(this.transactions, this._deleteTransaction);

  @override
  Widget build(BuildContext context) {
    return Container(
        // !
        height: 400,
        child: transactions.isEmpty
            ? Column(
                children: <Widget>[
                  Text(
                    'No Transaction added yet!',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                      height: 200,
                      child: Image.asset(
                        'assets/images/waiting.png',
                        fit: BoxFit.cover,
                      ))
                ],
              )
            // ! LISTVIEW ALWAYS HAVE INFINITE HEIGHT
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
                      subtitle: Text(
                          DateFormat.yMMMd().format(transactions[index].date)),
                      trailing: IconButton(
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
              ));
  }
}
