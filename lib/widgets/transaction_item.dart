import 'dart:math';

import 'package:flutter/material.dart';
import 'package:expense_planner/models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionItem extends StatefulWidget {
  const TransactionItem({
    Key? key,
    required this.transaction,
    required this.medQuery,
    required this.deleteTx,
  }) : super(key: key);

  final Transaction transaction;
  final MediaQueryData medQuery;
  final Function deleteTx;

  @override
  State<TransactionItem> createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {
  Color? _rdmColor;
  @override
  void initState() {
    // TODO: implement initState
    const availableCol = [Colors.green, Colors.red, Colors.white, Colors.blue];
    _rdmColor = availableCol[Random().nextInt(4)];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
        elevation: 4,
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: _rdmColor,
            radius: 30,
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: FittedBox(child: Text('\$${widget.transaction.amount}')),
            ),
          ),
          title: Text(
            widget.transaction.title,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          subtitle: Text(
            DateFormat.yMMMd().format(widget.transaction.date),
            style: Theme.of(context).textTheme.titleMedium,
          ),
          trailing: widget.medQuery.size.width > 460
              ? FlatButton.icon(
                  onPressed: () {
                    widget.deleteTx(widget.transaction.id);
                  },
                  icon: Icon(Icons.delete),
                  textColor: Theme.of(context).errorColor,
                  label: Text('Delete'),
                )
              : IconButton(
                  icon: Icon(Icons.delete),
                  color: Theme.of(context).errorColor,
                  onPressed: () {
                    widget.deleteTx(widget.transaction.id);
                  },
                ),
        ));
  }
}
