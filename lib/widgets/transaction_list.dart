import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:expense_planner/models/transaction.dart';

class TransactionList extends StatelessWidget {
  TransactionList(
      {Key? key, required this.transactions, required this.deleteTx})
      : super(key: key);

  final List<Transaction> transactions;
  final Function deleteTx;

  @override
  Widget build(BuildContext context) {
    final medQuery = MediaQuery.of(context);
    final curScaleFactor = medQuery.textScaleFactor;
    return transactions.isEmpty
        ? LayoutBuilder(builder: (context, constraints) {
            return Column(
              children: [
                Text(
                  'No Transaction yet!',
                  style: TextStyle(
                      fontSize: 20 * curScaleFactor, fontFamily: 'Momcake'),
                ),
                SizedBox(
                  height: constraints.maxHeight * 0.05,
                ),
                Container(
                  height: constraints.maxHeight * 0.2,
                  child: Image.asset('assets/anya.png', fit: BoxFit.cover),
                )
              ],
            );
          })
        : ListView.builder(
            itemCount: transactions.length,
            itemBuilder: (ctx, index) {
              return Card(
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                  elevation: 4,
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: FittedBox(
                            child: Text('\$${transactions[index].amount}')),
                      ),
                    ),
                    title: Text(
                      transactions[index].title,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    subtitle: Text(
                      DateFormat.yMMMd().format(transactions[index].date),
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    trailing: medQuery.size.width > 460
                        ? FlatButton.icon(
                            onPressed: () {
                              deleteTx(transactions[index].id);
                            },
                            icon: Icon(Icons.delete),
                            textColor: Theme.of(context).errorColor,
                            label: Text('Delete'),
                          )
                        : IconButton(
                            icon: Icon(Icons.delete),
                            color: Theme.of(context).errorColor,
                            onPressed: () {
                              deleteTx(transactions[index].id);
                            },
                          ),
                  ));
            },
          );
  }
}
