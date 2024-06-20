import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'add_expense_screen.dart';
import 'expense_provider.dart';
import 'statistics_screen.dart';
import 'budget_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final expenseProvider = Provider.of<ExpenseProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Expense Tracker'),
      ),
      body: ListView.builder(
        itemCount: expenseProvider.expenses.length,
        itemBuilder: (context, index) {
          final expense = expenseProvider.expenses[index];
          return ListTile(
            title: Text(expense.title),
            subtitle: Text('\$${expense.amount.toStringAsFixed(2)}'),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                expenseProvider.deleteExpense(expense.id);
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => AddExpenseScreen()),
          );
        },
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 6.0,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.home),
              onPressed: () {
                // navigate to home screen
              },
            ),
            IconButton(
              icon: Icon(Icons.bar_chart),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => StatisticsScreen()),
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.account_balance_wallet),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => BudgetScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
