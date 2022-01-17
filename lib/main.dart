import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import './models/transaction.dart';
import './widgets/transactions_list.dart';
import './widgets/add_transaction.dart';
import './widgets/chart.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations(
  //     [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Colors.green,
      ),
      home: const MyHomePage(title: 'Plan app 2'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transactions = [
    Transaction(id: 'a', title: 'title', amount: 0, date: DateTime.now()),
  ];
  bool _showChart = false;
  void _startAddNewTransaction(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) => GestureDetector(
              child: AddTransaction(
                addNewTransaction: _addNewTransaction,
              ),
              onTap: () {},
              behavior: HitTestBehavior.opaque,
            ));
  }

  void _addNewTransaction(String title, double amount, DateTime date) {
    setState(() {
      _transactions.add(Transaction(
          id: DateTime.now().toString(),
          title: title,
          amount: amount,
          date: date));
    });
  }

  void _deleteTransactions(String id) {
    setState(() {
      _transactions.removeWhere((element) => element.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;
    final appBar = Platform.isIOS
        ? CupertinoNavigationBar(
            middle: Text('hello'),
            trailing: Row(
              children: [
                GestureDetector(
                  child: Icon(Icons.add),
                  onTap: () => _startAddNewTransaction(context),
                )
              ],
            ),
          ) 
        : AppBar(
            title: Text(widget.title),
            actions: [
              IconButton(
                onPressed: () => _startAddNewTransaction(context),
                icon: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
            ],
          ) 
    return Platform.isIOS
        ? CupertinoPageScaffold(
            child: const Text('hi'),
            navigationBar: appBar,
          )
        : Scaffold(
            appBar: appBar,
            body: SingleChildScrollView(
              // ignore: prefer_const_literals_to_create_immutables
              child: Column(
                children: [
                  if (!isLandscape)
                    SizedBox(
                      height: (mediaQuery.size.height * 0.3 -
                          mediaQuery.padding.top -
                          appBar.preferredSize.height),
                      child: Chart(transactions: _transactions),
                    ),
                  if (!isLandscape)
                    SizedBox(
                      height: mediaQuery.size.height * 0.7 -
                          mediaQuery.padding.top -
                          appBar.preferredSize.height,
                      child: TransactionsList(
                        transactions: _transactions,
                        deleteTransactions: _deleteTransactions,
                      ),
                    ),
                  if (isLandscape)
                    SizedBox(
                        height: mediaQuery.size.height * 0.15,
                        child: FittedBox(
                          child: Row(
                            children: [
                              const Text('Show chart'),
                              Switch.adaptive(
                                  value: _showChart,
                                  onChanged: (val) {
                                    setState(() {
                                      _showChart = val;
                                    });
                                  })
                            ],
                          ),
                        )),
                  if (isLandscape)
                    _showChart
                        ? SizedBox(
                            height: (mediaQuery.size.height * 0.85 -
                                mediaQuery.padding.top -
                                appBar.preferredSize.height),
                            child: Chart(transactions: _transactions),
                          )
                        : SizedBox(
                            height: mediaQuery.size.height * 0.85 -
                                mediaQuery.padding.top -
                                appBar.preferredSize.height,
                            child: TransactionsList(
                              transactions: _transactions,
                              deleteTransactions: _deleteTransactions,
                            ),
                          ),
                ],
              ),
            ),
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    child: Icon(Icons.add),
                    onPressed: () => _startAddNewTransaction(context),
                  ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          );
  }
}
