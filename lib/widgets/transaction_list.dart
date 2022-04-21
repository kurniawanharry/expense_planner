import 'package:expense_planner/widgets/transaction_item.dart';
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
        : ListView(
            children: transactions
                .map(
                  (tx) => TransactionItem(
                      key: ValueKey(tx.id),
                      transaction: tx,
                      medQuery: medQuery,
                      deleteTx: deleteTx),
                )
                .toList());
  }
}

// ListView.builder(
//             itemCount: transactions.length,
//             itemBuilder: (ctx, index) {
//               return TransactionItem(
//                   transaction: transactions[index],
//                   medQuery: medQuery,
//                   deleteTx: deleteTx);
//             },
//           );
