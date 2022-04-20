import 'dart:io';

import 'package:expense_planner/models/transaction.dart';
import 'package:expense_planner/widgets/chart.dart';
import 'package:expense_planner/widgets/new_transaction.dart';
import 'package:expense_planner/widgets/transaction_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main(List<String> args) {
  //Setting agar layar tidak berotasi
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown,
  // ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Persenol Expenses',
      home: HomePage(),
      theme: ThemeData(
        primarySwatch: Colors.blue,
        accentColor: Colors.lightBlue,
        fontFamily: 'SpoqaHanSansNeo',
        textTheme: ThemeData.light().textTheme.copyWith(
              titleLarge: TextStyle(
                fontFamily: 'Momcake',
                fontSize: 20,
              ),
            ),
        appBarTheme: AppBarTheme(
          titleTextStyle: TextStyle(
            fontFamily: 'Momcake',
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Transaction> _userTransactions = [
    // Transaction(
    //   id: 't1',
    //   title: 'Shoes',
    //   amount: 69.99,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: 't2',
    //   title: 'Hat',
    //   amount: 19.99,
    //   date: DateTime.now(),
    // ),
  ];

  void _addNewtransaction(
      String txTitle, double txAmount, DateTime chosenDate) {
    final newTx = Transaction(
        id: DateTime.now().toString(),
        title: txTitle,
        amount: txAmount,
        date: chosenDate);

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            child: NewTransaction(addTx: _addNewtransaction),
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((tx) => tx.id == id);
    });
  }

  bool _showChart = false;

  @override
  Widget build(BuildContext context) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final appBar2 = AppBar(
      title: Text('Persenol Expenses'),
      actions: [
        IconButton(
            onPressed: () => _startAddNewTransaction(context),
            icon: const Icon(Icons.add))
      ],
    );
    final body2 = SafeArea(
      child: SingleChildScrollView(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (isLandscape)
                  _showChart
                      ? Text(
                          'Show to Transaction',
                          style: Theme.of(context).textTheme.titleMedium,
                        )
                      : Text(
                          'Show to Chart',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                if (isLandscape)
                  Switch.adaptive(
                      value: _showChart,
                      onChanged: (val) {
                        setState(() {
                          _showChart = val;
                        });
                      })
              ],
            ),
            if (!isLandscape)
              Container(
                  height: (MediaQuery.of(context).size.height -
                          appBar2.preferredSize.height -
                          MediaQuery.of(context).padding.top) *
                      0.25,
                  child: Chart(recentTransactions: _recentTransactions)),
            if (!isLandscape)
              Container(
                height: (MediaQuery.of(context).size.height -
                        appBar2.preferredSize.height -
                        MediaQuery.of(context).padding.top) *
                    0.75,
                child: TransactionList(
                  transactions: _userTransactions,
                  deleteTx: _deleteTransaction,
                ),
              ),
            if (isLandscape)
              _showChart
                  ? Container(
                      height: (MediaQuery.of(context).size.height -
                              appBar2.preferredSize.height -
                              MediaQuery.of(context).padding.top) *
                          0.7,
                      child: Chart(recentTransactions: _recentTransactions))
                  : Container(
                      height: (MediaQuery.of(context).size.height -
                              appBar2.preferredSize.height -
                              MediaQuery.of(context).padding.top) *
                          2,
                      child: TransactionList(
                        transactions: _userTransactions,
                        deleteTx: _deleteTransaction,
                      ),
                    )
          ],
        ),
      ),
    );
    return Platform.isIOS
        ? CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
              middle: Text('Personal Expenses'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    child: Icon(CupertinoIcons.add),
                    onTap: () => _startAddNewTransaction(context),
                  ),
                ],
              ),
            ),
            child: body2,
          )
        : Scaffold(
            appBar: appBar2,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    child: Icon(Icons.add),
                    onPressed: () {
                      _startAddNewTransaction(context);
                    },
                  ),
            body: body2,
          );
  }
}
