import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_state/todo_app_scratch/todo.dart';
import 'package:provider_state/todo_app_scratch/todo_form_widget.dart';
import 'package:provider_state/todo_app_scratch/todos.dart';


class AddTodoDialogueWidget extends StatefulWidget {
  const AddTodoDialogueWidget({Key? key}) : super(key: key);

  @override
  State<AddTodoDialogueWidget> createState() => _AddTodoDialogueWidgetState();
}

class _AddTodoDialogueWidgetState extends State<AddTodoDialogueWidget> {
  final _formKey = GlobalKey<FormState>();
  String title ='';
  String description = '';

  @override
  Widget build(BuildContext context) => AlertDialog(
    content: Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Add Todo',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22.0),
          ),
          const SizedBox(height: 8.0),
          TodoFormWidget(
            onChangedTitle: (title) => setState(() => this.title = title),
            onChangedDescription: (description) => setState(() => this.description = description),
            onSavedTodo: addTodo
          )
        ],
      ),
    ),
  );

  void addTodo() {
    final isValid = _formKey.currentState!.validate();

    if(!isValid) {
      return ;
    } else {
      final todo = Todo(
        id: DateTime.now().toString(),
        createdTime: DateTime.now(),
        title: title,
        description: description
      );

      final provider = Provider.of<TodosProvider>(context, listen: false);
      provider.addTodo(todo);

      Navigator.of(context).pop();
    }
  }
}