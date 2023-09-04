import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_state/todo_app_scratch/todo_list_widget.dart';
import 'package:provider_state/todo_app_scratch/todos.dart';
import 'add_todo_dialogue_widget.dart';
import 'completed_list_widget.dart';


class userHome extends StatelessWidget {
  const userHome({Key? key}) : super(key: key);

  static const String title = 'Todo App';

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
      create: (BuildContext context) => 
        TodosProvider(),
      
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: title,
        theme: ThemeData(
            primarySwatch: Colors.pink,
            scaffoldBackgroundColor: Colors.white
        ),
        home: const Home_Widget(),
      )
  );
}

class Home_Widget extends StatefulWidget {
  const Home_Widget({Key? key}) : super(key: key);

  @override
  State<Home_Widget> createState() => _Home_WidgetState();
}

class _Home_WidgetState extends State<Home_Widget> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final tabs = [
      const TodoListWidget(),
      const CompletedListWidget()
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text(userHome.title),
      ),
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Theme.of(context).primaryColor,
          unselectedItemColor: Colors.white.withOpacity(0.7),
          selectedItemColor: Colors.white,
          currentIndex: selectedIndex,
          onTap: (index) => setState(() {
                selectedIndex = index;
              }),
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.fact_check_outlined), label: 'Todos'),
            BottomNavigationBarItem(
                icon: Icon(Icons.done, size: 28.0), label: 'Completed')
          ]),
      body: tabs[selectedIndex],
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepOrange,
        shape:RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0)
        ),
        onPressed: () => showDialog(
            barrierDismissible: false,
            barrierColor: Colors.green[200],
            context: context,
            builder: (context) => const AddTodoDialogueWidget()),
        child: const Icon(Icons.add),
      ),
    );
  }
}