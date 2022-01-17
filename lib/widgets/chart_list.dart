import 'package:flutter/material.dart';

class ChartList extends StatelessWidget {
  final String day;
  final double totalSum;
  final double percent;
  const ChartList(
      {Key? key,
      required this.day,
      required this.totalSum,
      required this.percent})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, constraint) {
      return Column(
        children: [
          SizedBox(
            height: constraint.maxHeight * 0.15,
            child: FittedBox(
              child: Text('\$$totalSum'),
            ),
          ),
          SizedBox(
            height: constraint.maxHeight * 0.05,
          ),
          SizedBox(
            height: constraint.maxHeight * 0.6,
            width: 20,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(width: 2, color: Colors.grey),
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(5)),
                ),
                FractionallySizedBox(
                  heightFactor: percent,
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(width: 2, color: Colors.blue),
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(5)),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: constraint.maxHeight * 0.05
          ),
         SizedBox(
           height: constraint.maxHeight * 0.15,
           child: FittedBox(
             child: Text(day),
           ),
         ),
        ],
      );
    });
  }
}
