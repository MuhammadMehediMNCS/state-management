import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:provider_state/todo_app_scratch/todo.dart';
import 'package:provider_state/todo_app_scratch/todos.dart';
import 'package:provider_state/todo_app_scratch/utils.dart';


import 'edit_todo_page.dart';


class TodoWidget extends StatelessWidget {
  final Todo todo;

  const TodoWidget({
    Key? key,
    required this.todo
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => ClipRRect(
    borderRadius: BorderRadius.circular(16.0),
    // Add dependency : (flutter_slidable: ^0.5.7) for slidable.
    child: Slidable(
      actionPane: const SlidableDrawerActionPane(),
      key: Key(todo.id),
      actions: [
        IconSlideAction(
          icon: Icons.edit,
          color: Colors.green,
          caption: 'Edit',
          onTap: () => EditTodo(context, todo),
        )
      ],
      secondaryActions: [
        IconSlideAction(
          color: Colors.red,
          caption: 'Delete',
          icon: Icons.delete,
          onTap: () => deleteTodo(context, todo),
        )
      ],
      child: buildTodo(context),
    ),
  );

  Widget buildTodo(BuildContext context) => GestureDetector(
    onTap: () => editTodo(context, todo),
    child: Container(
      padding: const EdgeInsets.all(20.0),
      color: Colors.white,
      child: Row(
        children: [
          Checkbox(
            activeColor: Theme.of(context).primaryColor,
            checkColor: Colors.white,
            value: todo.isDone,
            onChanged: (_) {
              final provider = Provider.of<TodosProvider>(context, listen: false);
              final isDone = provider.toggleTodoStatus(todo);
  
              Utils.showSnackBar(context, isDone ? 'Task Completed' : 'Task marked incomplete');
            }
          ),
          const SizedBox(width: 20.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  todo.title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22.0,
                    color: Theme.of(context).primaryColor
                  ),
                ),
                if(todo.description.isNotEmpty)
                Container(
                  margin: const EdgeInsets.only(top: 4.0),
                  child: Text(
                    todo.description,
                    style: const TextStyle(
                      fontSize: 20.0,
                      height: 1.5
                    ),
                  ),
                )
              ],
            )
          )
        ],
      ),
    ),
  );

  void deleteTodo(BuildContext context, Todo todo) {
    final provider = Provider.of<TodosProvider>(context, listen: false);

    provider.removeTodo(todo);

    Utils.showSnackBar(context, 'Deleted the task');
  }

  void EditTodo(BuildContext context, Todo todo) => Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => EditTodoPage(todo: todo),
    )
  );

  void editTodo(BuildContext context, Todo todo) => Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => EditTodoPage(todo: todo),
    )
  );
}