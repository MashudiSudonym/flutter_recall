import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'expense_provider.dart';
import 'expense_form.dart';

class ExpensePage extends StatelessWidget {
  const ExpensePage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ExpenseProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text("Expense Tracker")),
      body: Column(
        children: [
          Container(
            color: Colors.indigo,
            padding: const EdgeInsets.all(16),
            width: double.infinity,
            child: Text(
              "Total: Rp ${provider.totalExpense.toStringAsFixed(0)}",
              style: const TextStyle(fontSize: 20, color: Colors.white),
            ),
          ),
          Expanded(
            child: provider.expenses.isEmpty
                ? const Center(child: Text("Belum ada pengeluaran"))
                : ListView.builder(
                    itemCount: provider.expenses.length,
                    itemBuilder: (context, i) {
                      final exp = provider.expenses[i];
                      return ListTile(
                        title: Text(exp.title),
                        subtitle: Text("${exp.category} - Rp ${exp.amount}"),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => context
                              .read<ExpenseProvider>()
                              .deleteExpense(exp.id!),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const ExpenseForm()),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}
