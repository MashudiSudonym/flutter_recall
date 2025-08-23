import 'expense_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class ExpenseForm extends StatelessWidget {
  const ExpenseForm({super.key});

  @override
  Widget build(BuildContext context) {
    String title = '';
    String category = 'Makanan';
    double amount = 0;

    return Scaffold(
      appBar: AppBar(title: const Text("Tambah Pengeluaran")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(labelText: "Judul"),
              onChanged: (val) => title = val,
            ),
            TextField(
              decoration: const InputDecoration(labelText: "Jumlah"),
              keyboardType: TextInputType.number,
              onChanged: (val) => amount = double.tryParse(val) ?? 0,
            ),
            DropdownButtonFormField<String>(
              value: category,
              items: [
                "Makanan",
                "Transportasi",
                "Hiburan",
                "Lainnya",
              ].map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
              onChanged: (val) => category = val!,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (title.isNotEmpty && amount > 0) {
                  context.read<ExpenseProvider>().addExpense(
                    title,
                    amount,
                    category,
                  );
                  Navigator.pop(context);
                }
              },
              child: const Text("Simpan"),
            ),
          ],
        ),
      ),
    );
  }
}
