import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // ! FOR SYSTEM CHROME
import './widgets/chart.dart';
import './widgets/new_transaction.dart';
import './widgets/transaction_list.dart';
import './models/transaction.dart';

void main() {
  // ! TO AVOID LANDSCAPE MODE -> IT MEANS NO LANDSCAPE MODE
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations(
  //     [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Personal Expense',
      // ! BIKINI PRIMARY THEME / STYLE
      theme: ThemeData(
          primarySwatch: Colors.purple,
          //! ACCENT COLOR DEPECRATED USING COLOR SCHEME
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.purple)
              .copyWith(secondary: Colors.pink[400]),
          fontFamily: 'QuickSand',
          textTheme: ThemeData.light().textTheme.copyWith(
              headline6: const TextStyle(fontFamily: 'OpenSans', fontSize: 20),
              button: const TextStyle(color: Colors.white)),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              primary: Colors.purple,
            ),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(onPrimary: Colors.white))
          // appBarTheme: AppBarTheme(
          //         )
          ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

// ! LEARN APP LIFECYCLE
class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  final List<Transaction> _userTransactions = [
    // Transaction(
    //     id: 'T1', title: 'New Shoes', amount: 69.99, date: DateTime.now()),
    // Transaction(
    //     id: 'T2',
    //     title: 'Weekly groceries',
    //     amount: 16.99,
    //     date: DateTime.now())
  ];

  List<Transaction> get _recentTransaction {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(
        const Duration(days: 7),
      ));
    }).toList();
  }

  bool _showChart = false;

  // ! LEARN APP LIFECYCLE
  @override
  void initState() {
    WidgetsBinding.instance?.addObserver(this);

    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print(state);
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }

  void _addTransaction(String title, double amount, DateTime choosenDate) {
    final newTransaction = Transaction(
        title: title,
        amount: amount,
        date: choosenDate,
        id: (_userTransactions.length + 1).toString());

    // ! STATEFUL BISA NGUBAH UI DAN MENGGUNAKAN SETSTATE()
    setState(() {
      _userTransactions.add(newTransaction);
    });
  }

  void _deleteTransaction(String id) {
    // ! REBUILD UI
    setState(() {
      _userTransactions.removeWhere((element) => element.id == id);
    });
  }

  void _startButtonAddTransaction(BuildContext ctx) {
    // ! SHOW MODAL BOTTOM SHEET
    showModalBottomSheet(
      context: ctx,
      builder: (bCtx) {
        return GestureDetector(
          // NOTHING TO DO WHEN TAP
          onTap: () {},
          child: NewTransaction(_addTransaction),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  List<Widget> _buildLandscapeContent(
      MediaQueryData mediaQuery, AppBar appBar, Widget transactionListWidget) {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Show Chart',
            style: Theme.of(context).textTheme.headline6,
          ),
          Switch.adaptive(
              activeColor: Theme.of(context).primaryColor,
              value: _showChart,
              onChanged: (val) {
                setState(() {
                  _showChart = val;
                });
              })
        ],
      ),
      _showChart
          ? Container(
              height: (mediaQuery.size.height -
                      appBar.preferredSize.height -
                      mediaQuery.padding.top) *
                  0.7,
              child: Chart(_recentTransaction))
          : transactionListWidget
    ];
  }

  List<Widget> _buildPortraitContent(
      MediaQueryData mediaQuery, AppBar appBar, Widget transactionListWidget) {
    return [
      Container(
          height: (mediaQuery.size.height -
                  appBar.preferredSize.height -
                  mediaQuery.padding.top) *
              0.3,
          child: Chart(_recentTransaction)),
      transactionListWidget
    ];
  }

  @override
  Widget build(BuildContext context) {
    // ! CHECK IS LANDSCAPE OR NOT
    final mediaQuery = MediaQuery.of(context);
    final _isLandscape = mediaQuery.orientation == Orientation.landscape;
    // ! SETUP APPBAR
    // ! ADD TYPE PREFFEREDSIZEWIDGET TO ADD PREFFERED SIZE IN IOS NAVBAR
    final PreferredSizeWidget appBar = (Platform.isIOS
        ? CupertinoNavigationBar(
            middle: const Text('Flutter Personal Expense'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                GestureDetector(
                    onTap: () => _startButtonAddTransaction(context),
                    child: const Icon(CupertinoIcons.add)),
              ],
            ),
          )
        : AppBar(
            title: const Text('Flutter Personal Expense'),
            actions: <Widget>[
              IconButton(
                  onPressed: () => _startButtonAddTransaction(context),
                  icon: const Icon(Icons.add))
            ],
          )) as PreferredSizeWidget;

    final transactionListWidget = Container(
        height: (mediaQuery.size.height -
                appBar.preferredSize.height -
                mediaQuery.padding.top) *
            0.7,
        child: TransactionList(_userTransactions, _deleteTransaction));

    final pageBody = SafeArea(
        child: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          // Card will take width child, but if the parents had width it will take the parent,
          // Column is not the parent, usually is Container so it is no problem to put Container in Card or outside Card as Parent
          // ! GET HEIGHT DEPENDS ON DEVICES
          if (_isLandscape)
            ..._buildLandscapeContent(
                mediaQuery, (appBar as AppBar), transactionListWidget),
          if (!_isLandscape)
            ..._buildPortraitContent(
                mediaQuery, (appBar as AppBar), transactionListWidget),
        ],
      ),
    ));

    // ! YANG INI BUTUH PEMAHAMAN WIDGET
    return Platform.isIOS
        ? CupertinoPageScaffold(
            child: pageBody,
            navigationBar: (appBar as ObstructingPreferredSizeWidget),
          )
        : Scaffold(
            appBar: appBar,
            // ! BUAT SCROLL KARNA PAS NGEADD LIST DAN KEYBOARD MUNCUL ADA ERROR
            body: pageBody,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    child: const Icon(Icons.add),
                    onPressed: () => _startButtonAddTransaction(context)));
  }
}
