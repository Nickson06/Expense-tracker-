import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'expense_provider.dart';

class BudgetScreen extends StatefulWidget {
  @override
  _BudgetScreenState createState() => _BudgetScreenState();
}

class _BudgetScreenState extends State<BudgetScreen> {
  final _formKey = GlobalKey<FormState>();
  double _budget = 0.0;

  void _submitBudget() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      Provider.of<ExpenseProvider>(context, listen: false).setBudget(_budget);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Set Budget')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Budget Amount'),
                keyboardType: TextInputType.number,
                onSaved: (value) {
                  _budget = double.parse(value!);
                },
                validator: (value) {
                  if (value!.isEmpty || double.tryParse(value) == null) {
                    return 'Please enter a valid amount';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitBudget,
                child: Text('Set Budget'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
