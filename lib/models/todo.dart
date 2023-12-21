import 'package:uuid/uuid.dart';

class TodoItem {
  final String id;
  String name;
  bool isComplete;

  TodoItem({required this.name, this.isComplete = false}) : id = Uuid().v4();
}
