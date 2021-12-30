import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTransactionFunction;

  NewTransaction(this.addTransactionFunction);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate; // ! NULL EXCEPTION

  @override
  void _addTransactionPressed() {
    if (_amountController.text.isEmpty) {
      return;
    }
    final enteredTitle = _titleController.text;
    final enteredAmout = double.parse(_amountController.text);
    if (enteredTitle.isEmpty || enteredAmout <= 0 || _selectedDate == null) {
      // THIS CODE IS NOT EXECUTE
      // STOP THE FUNCTION
      return;
    }
    widget.addTransactionFunction(enteredTitle, enteredAmout, _selectedDate);
    Navigator.of(context).pop();
  }

  void _showDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1995),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }

      // ! TRIGGRED TO TELL DART / FLUTTER THAT STATEFULL WIDGET HAS BEEN UPDATED
      setState(() {
        _selectedDate = pickedDate;
      });
    }); // ! DI DART / FLUTTER NAMANYA FUTURE TP JS ASYNC
  }

  Widget build(BuildContext context) {
    return Card(
        child: Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          // Receiving user input
          TextField(
            controller: _titleController,
            decoration: InputDecoration(labelText: 'Title'),
            onSubmitted: (_) => _addTransactionPressed(),
          ),
          TextField(
            controller: _amountController,
            decoration: InputDecoration(labelText: 'Amount'),
            keyboardType: TextInputType.number,
            // mean (_) it is convention signal, i get an argument but dont care about it
            // also mean I DONT USE IT
            onSubmitted: (_) => _addTransactionPressed(),
          ),
          Container(
            height: 70,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    _selectedDate == null
                        ? 'No Date Choose'
                        : 'Picked date: ' +
                            DateFormat.yMd().format(_selectedDate as DateTime),
                  ),
                ),
                TextButton(
                  onPressed: _showDatePicker,
                  child: Text('Choose Date'),
                  style: TextButton.styleFrom(
                      textStyle: TextStyle(fontWeight: FontWeight.bold)),
                )
              ],
            ),
          ),
          ElevatedButton(
            onPressed: _addTransactionPressed,
            child: Text('Add Transaction'),
          )
        ],
      ),
    ));
  }
}
