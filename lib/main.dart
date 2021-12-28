import 'package:flutter/material.dart';
import './widgets/user_transactions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Personal Expense',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Flutter App'),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              // Card will take width child, but if the parents had width it will take the parent,
              // Column is not the parent, usually is Container so it is no problem to put Container in Card or outside Card as Parent
              Container(
                  // double.infinity will expand depends on screen
                  width: double.infinity,
                  child: const Card(
                    color: Colors.blue,
                    child: Text('Chart'),
                    elevation: 5,
                  )),
              UserTransactions()
            ],
          ),
        ));
  }
}
