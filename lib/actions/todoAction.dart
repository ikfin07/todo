import 'package:flutter/material.dart';
import '../main.dart';
import '../models/todo.dart';

class TodoModel extends ChangeNotifier {
  List<TodoItem> _list = [];
  String filter = '';

  List<TodoItem> get list {
    if (filter.isEmpty) return _list;
    return _list
        .where((todo) => todo.name.toLowerCase().contains(filter.toLowerCase()))
        .toList();
  }

  void addItem(String name) {
    if (name.trim().isEmpty) {
      // Fluttertoast.showToast(msg: 'Todo name cannot be empty!');
      showSnackBar('Todo name cannot be empty!');
      return;
    }
    if (_list.any((item) => item.name.toLowerCase() == name.toLowerCase())) {
      // Fluttertoast.showToast(msg: 'Duplicate Todo name!');
      showSnackBar('Duplicate Todo name!');
      return;
    }
    _list.add(TodoItem(name: name));
    notifyListeners();
  }

  void removeItem(String id) {
    _list.removeWhere((item) => item.id == id);
    notifyListeners();
  }

  void toggleComplete(String id) {
    var index = _list.indexWhere((item) => item.id == id);
    _list[index].isComplete = !_list[index].isComplete;
    notifyListeners();
  }

  void updateItem(String id, String name) {
    if (name.trim().isEmpty) {
      // Fluttertoast.showToast(msg: 'Todo name cannot be empty!');
      showSnackBar('Todo name cannot be empty!');
      return;
    }
    if (_list.any((item) =>
        item.id != id && item.name.toLowerCase() == name.toLowerCase())) {
      // Fluttertoast.showToast(msg: 'Duplicate Todo name!');
      showSnackBar('Duplicate Todo name!');
      return;
    }
    var index = _list.indexWhere((item) => item.id == id);
    _list[index].name = name;
    notifyListeners();
  }

  void setFilter(String value) {
    filter = value;
    notifyListeners();
  }
}
