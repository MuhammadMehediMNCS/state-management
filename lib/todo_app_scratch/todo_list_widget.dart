import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_state/todo_app_scratch/todo_widget.dart';
import 'package:provider_state/todo_app_scratch/todos.dart';



class TodoListWidget extends StatelessWidget {
  const TodoListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TodosProvider>(context); 
    final todos = provider.todolist;

    return todos.isEmpty
    ? const Center(
      child: Text(
        'No todos',
        style: TextStyle(fontSize: 20.0),
      ),
    ) :
    ListView.separated(
      padding: const EdgeInsets.all(16.0),
      physics: const BouncingScrollPhysics(),
      itemCount: todos.length,
      itemBuilder: (context, index) {
        final todo = todos [index];

        return TodoWidget(todo: todo);
      },
      separatorBuilder: (context, index) => Container( height: 16.0),
    );
  }
}