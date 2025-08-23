import 'package:day13_expense_tracker_app/expense.dart';
import 'package:day13_expense_tracker_app/expense_database.dart';
import 'package:flutter/material.dart';

class ExpenseProvider with ChangeNotifier {
  List<Expense> _expenses = [];
  List<Expense> get expenses => _expenses;

  double get totalExpense => _expenses.fold(0, (sum, e) => sum + e.amount);

  Future<void> loadExpense() async {
    _expenses = await ExpenseDatabase.instance.getExpenses();
    notifyListeners();
  }

  Future<void> addExpense(String title, double amount, String category) async {
    await ExpenseDatabase.instance.insert(
      Expense(title: title, amount: amount, category: category),
    );
    await loadExpense();
  }

  Future<void> deleteExpense(int id) async {
    await ExpenseDatabase.instance.delete(id);
    await loadExpense();
  }
}
