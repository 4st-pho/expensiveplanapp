import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';
import './chart_list.dart';

class Chart extends StatelessWidget {
  final List<Transaction> transactions;
  const Chart({ Key? key , required this.transactions}) : super(key: key);

  List<Map<String, dynamic>> get _chartList{
    return List.generate(7, (index){
      DateTime weekDay = DateTime.now().subtract(Duration(days: 6 - index));
      double totalAmount = 0;
      for (Transaction item in transactions) {
        if(item.date.day == weekDay.day && item.date.month == weekDay.month && item.date.year == weekDay.year){
          totalAmount += item.amount;
        }
      }
      if(transactions.isEmpty){
        return {'day' : DateFormat.E().format(weekDay), 'amount': 0.0};
      }
        return {'day' : DateFormat.E().format(weekDay), 'amount': totalAmount};
    });
  }

  double get _totalAmount{
    return _chartList.fold(0, (previousValue, element) => previousValue + element['amount']);
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Card(
        child: Row(
          children: _chartList.map((e) => Expanded(child: ChartList(day: e['day'] as String, totalSum: e['amount'], percent:  (e['amount'] as double)/ (_totalAmount == 0 ? 1 : _totalAmount) ))).toList()
        ),
      ),
    );
  }
}