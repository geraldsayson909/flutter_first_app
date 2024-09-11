import 'package:flutter/material.dart';
import 'package:todo_app/keys/checkable_todo_item.dart';
// import 'package:todo_app/keys/todo_item.dart';

class Todo {
  const Todo(this.text, this.priority);

  final String text;
  final Priority priority;
}

class Keys extends StatefulWidget {
  const Keys({super.key});

  @override
  State<Keys> createState() {
    return _KeysState();
  }
}

class _KeysState extends State<Keys> {
  var _order = 'asc';
  final _todos = [
    const Todo('Learn Flutter', Priority.urgent),
    const Todo('Practice Flutter', Priority.normal),
    const Todo('Explore other courses', Priority.low),
  ];

  List<Todo> get _orderTools {
    final sortedTodos = List.of(_todos);
    sortedTodos.sort(
      (a, b) {
        final bComesAfterA = a.text.compareTo(b.text);
        return _order == 'asc' ? bComesAfterA : -bComesAfterA;
      },
    );
    return sortedTodos;
  }

  void _changeOrder() {
    setState(() {
      _order = _order == 'asc' ? 'desc' : 'asc';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: TextButton.icon(
            onPressed: _changeOrder,
            icon: Icon(
                _order == 'asc' ? Icons.arrow_downward : Icons.arrow_upward),
            label: Text('Sort ${_order == 'asc' ? 'Desending' : 'Ascending'}'),
          ),
        ),
        Expanded(
          child: Column(
            children: [
              for (final todo in _orderTools)
                CheckableTodoItem(
                    key: ObjectKey(todo), todo.text, todo.priority),
            ],
          ),
        )
      ],
    );
  }
}