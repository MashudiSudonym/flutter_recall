import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TodoProvider extends ChangeNotifier {
  List<String> _todos = [];
  List<String> get todos => _todos;

  TodoProvider() {
    _loadTodos();
  }

  Future<void> _loadTodos() async {
    final prefs = await SharedPreferences.getInstance();
    _todos = prefs.getStringList('todos') ?? [];
    notifyListeners();
  }

  Future<void> _saveTodos() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('todos', _todos);
  }

  void addTodo(String todo) {
    _todos.add(todo);
    _saveTodos();
    notifyListeners();
  }

  void removeTodoAt(int index) {
    _todos.removeAt(index);
    _saveTodos();
    notifyListeners();
  }
}
