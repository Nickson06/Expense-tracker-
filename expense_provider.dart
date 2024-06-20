import 'package:flutter/foundation.dart';
import 'expense.dart';
import 'expense_database.dart';

class ExpenseProvider with ChangeNotifier {
  List<Expense> _expenses = [];
  double _budget = 0.0;

  List<Expense> get expenses => _expenses;
  double get budget => _budget;

   void setBudget(double budget) {
    _budget = budget;
    notifyListeners();
  }

  void addExpense(String title, double amount) async {
    final newExpense = Expense(
      id: DateTime.now().toString(),
      title: title,
      amount: amount,
      date: DateTime.now(),
    );
    await ExpenseDatabase.instance.create(newExpense);
    _expenses.add(newExpense);
    notifyListeners();
  }

  void deleteExpense(String id) async {
    await ExpenseDatabase.instance.delete(id);
    _expenses.removeWhere((expense) => expense.id == id);
    notifyListeners();
  }

  Future<void> fetchExpenses() async {
    _expenses = await ExpenseDatabase.instance.readAllExpenses();
    notifyListeners();
  }
}
