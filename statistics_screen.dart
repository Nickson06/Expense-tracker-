import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'expense_provider.dart';
import 'package:fl_chart/fl_chart.dart';

class StatisticsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final expenseProvider = Provider.of<ExpenseProvider>(context);
    final expenses = expenseProvider.expenses;

    Map<String, double> dataMap = {};
    expenses.forEach((expense) {
      dataMap.update(expense.title, (value) => value + expense.amount, ifAbsent: () => expense.amount);
    });

    return Scaffold(
      appBar: AppBar(title: Text('Statistics')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: PieChart(
          PieChartData(
            sections: dataMap.entries.map((entry) {
              return PieChartSectionData(
                value: entry.value,
                title: '${entry.key} (${entry.value.toStringAsFixed(2)})',
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
