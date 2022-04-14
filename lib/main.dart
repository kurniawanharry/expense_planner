import 'package:expense_planner/transaction.dart';
import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: Text('This is AppBar'),
      ),
      body: HomePage(),
    ),
  ));
}

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final List<Transaction> transactions = [
    Transaction(id: 't1', title: 'Shoes', amount: 69.99, date: DateTime.now())
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          child: Text('Top'),
        ),
        Column(
          children: transactions
              .map((tx) => Card(
                    child: Row(children: [
                      Container(
                        child: Text(tx.amount.toString()),
                      ),
                      Column(
                        children: [
                          Text(tx.title),
                          Text(
                            tx.date.toString(),
                          ),
                        ],
                      ),
                    ]),
                  ))
              .toList(),
        )
      ],
    );
  }
}
