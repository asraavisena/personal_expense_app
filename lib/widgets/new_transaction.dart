import 'package:flutter/material.dart';

class NewTransaction extends StatelessWidget {
  final Function addTransactionFunction;
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  NewTransaction(this.addTransactionFunction);
  @override
  Widget build(BuildContext context) {
    return Card(
        child: Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          // Receiving user input
          TextField(
            controller: titleController,
            decoration: InputDecoration(labelText: 'Title'),
          ),
          TextField(
            controller: amountController,
            decoration: InputDecoration(labelText: 'Amount'),
          ),
          TextButton(
            onPressed: () {
              addTransactionFunction(
                  titleController.text, double.parse(amountController.text));
            },
            child: Text('Add Transaction'),
            style: ButtonStyle(
                foregroundColor:
                    MaterialStateProperty.all<Color>(Colors.purple)),
          )
        ],
      ),
    ));
  }
}
