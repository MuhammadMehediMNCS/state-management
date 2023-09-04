import 'package:flutter/cupertino.dart';
import 'package:provider_state/todo_app_scratch/todo.dart';


class TodosProvider extends ChangeNotifier {
  List<Todo> _todos = [
    Todo(
      createdTime: DateTime.now(),
      title: 'Buy Food',
      description: '''_Eggs
-Milk
-Bread
-Water'''
    ),
    Todo(
      createdTime: DateTime.now(),
      title: 'Plan family trip to Norway',
      description: '''_Rent some hotels
-Rent a car
-Pack suitcase'''
    ),
    Todo(
        createdTime: DateTime.now(),
        title: 'Walk the Dog'
      ),
  ];
  List<Todo> get todolist => _todos.where((todo) => todo.isDone == false).toList();
  List<Todo> get todosCompleted => _todos.where((todo) => todo.isDone == true).toList();

  void addTodo(Todo todo) {
    _todos.add(todo);

    notifyListeners();
  }

  void removeTodo(Todo todo) {
    _todos.remove(todo);

    notifyListeners();
  }

  bool toggleTodoStatus(Todo todo) {
    todo.isDone = !todo.isDone;
    notifyListeners();

    return todo.isDone;
  }

  void updateTodo(Todo todo, String title, String description) {
    todo.title = title;
    todo.description = description;

    notifyListeners();
  }
}