import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {
  final Function addTransactionFunction;

  NewTransaction(this.addTransactionFunction);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  @override
  void addTransactionPressed() {
    final enteredTitle = titleController.text;
    final enteredAmout = double.parse(amountController.text);
    if (enteredTitle.isEmpty || enteredAmout <= 0) {
      // THIS CODE IS NOT EXECUTE
      // STOP THE FUNCTION
      return;
    }
    widget.addTransactionFunction(enteredTitle, enteredAmout);
    Navigator.of(context).pop();
  }

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
            onSubmitted: (_) => addTransactionPressed(),
          ),
          TextField(
            controller: amountController,
            decoration: InputDecoration(labelText: 'Amount'),
            keyboardType: TextInputType.number,
            // mean (_) it is convention signal, i get an argument but dont care about it
            // also mean I DONT USE IT
            onSubmitted: (_) => addTransactionPressed(),
          ),
          TextButton(
            onPressed: addTransactionPressed,
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
