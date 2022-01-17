import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:planapp2/models/transaction.dart';
import '../models/transaction.dart';

class TransactionsList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function(String id) deleteTransactions;
  const TransactionsList(
      {Key? key, required this.transactions, required this.deleteTransactions})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(top: 10),
        child: transactions.isEmpty
            ? Center(
                heightFactor: 0.5,
                child: Text(
                  'No transaction',
                  style: TextStyle(
                      color: Theme.of(context).primaryColor, fontSize: 25),
                ))
            : ListView.builder(
                itemCount: transactions.length,
                itemBuilder: (context, index) {
                  return Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 10),
                      child: Card(
                        elevation: 5,
                        child: ListTile(
                          leading: CircleAvatar(
                            radius: 30,
                            child: FittedBox(
                              child: Padding(
                                padding: const EdgeInsets.all(3),
                                child: Text('\$${transactions[index].amount}'),
                              ),
                            ),
                          ),
                          title: Text(transactions[index].title),
                          subtitle: Text(DateFormat.yMEd()
                              .format(transactions[index].date)),
                          trailing: MediaQuery.of(context).size.width > 480
                              ? TextButton.icon(
                                  onPressed: () => deleteTransactions(
                                      transactions[index].id),
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                  label: const Text('Delete'))
                              : IconButton(
                                  onPressed: () => deleteTransactions(
                                      transactions[index].id),
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                ),
                        ),
                      ));
                },
              ));
  }
}
