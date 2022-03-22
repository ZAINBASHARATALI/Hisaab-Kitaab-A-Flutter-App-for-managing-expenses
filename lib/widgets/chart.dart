import 'package:flutter/material.dart';
import 'package:hissab_maxis/widgets/chart_bar.dart';
import '../models/transactions.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transactions> recentTransactions;
  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );
      var totalSum = 0.0;
      for (int i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year) {
          totalSum += recentTransactions[i].amount;
        }
      }
      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalSum,
      };
    }).reversed.toList();
  }

  double get maxSpending {
    return groupedTransactionValues.fold(0.0, (sum, val) {
      return sum + (val['amount'] as num);
    });
  }

  const Chart({Key? key, required this.recentTransactions}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: groupedTransactionValues.map((data) {
              //var x=data['day'];
              return Flexible(
                fit: FlexFit.tight,
                child: ChartBar(
                  label: data['day'].toString(),
                  spendingAmount: (data['amount'] as double),
                  spendingPctOfTotal: maxSpending == 0
                      ? 0.0
                      : (data['amount'] as double) / maxSpending,
                ),
              );
            }).toList()),
      ),
    );
  }
}
