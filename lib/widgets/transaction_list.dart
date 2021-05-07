import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transactions.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTransaction;

  TransactionList(this.transactions, this.deleteTransaction);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: transactions.isEmpty
          ? LayoutBuilder(builder: (ctx, constrains) {
              return Column(
                children: [
                  Text(
                    'No transaction added yet!',
                    style: TextStyle(color: Colors.red, fontSize: 18),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Image.asset(
                      'assets/images/nocontent.png',
                      fit: BoxFit.cover,
                    ),
                    height: constrains.maxHeight * 0.5,
                  )
                ],
              );
            })
          : ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (context, index) {
                return SingleTransactionItem(
                    transaction: transactions[index],
                    deleteTransaction: deleteTransaction);
              },
            ),
    );
  }
}

class SingleTransactionItem extends StatelessWidget {
  const SingleTransactionItem({
    Key key,
    @required this.transaction,
    @required this.deleteTransaction,
  }) : super(key: key);

  final Transaction transaction;
  final Function deleteTransaction;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          backgroundColor: Colors.red[400],
          foregroundColor: Colors.white,
          child: Container(
            padding: EdgeInsets.all(6),
            child: FittedBox(child: Text('\$${transaction.amount}')),
          ),
        ),
        title: Text(
          transaction.title,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          DateFormat.yMMMd().format(transaction.date),
        ),
        trailing: MediaQuery.of(context).size.width > 400
            ? TextButton.icon(
                onPressed: () => deleteTransaction(transaction.id),
                icon: Icon(
                  Icons.delete,
                  color: Colors.black,
                ),
                style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all(Colors.black)),
                label: Text('Delete'))
            : IconButton(
                onPressed: () => deleteTransaction(transaction.id),
                icon: Icon(
                  Icons.delete,
                  color: Colors.black,
                ),
              ),
      ),
      elevation: 5,
    );
  }
}
