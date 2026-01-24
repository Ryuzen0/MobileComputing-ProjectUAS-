import 'package:flutter/material.dart';
import '../models/todo_model.dart';
import '../services/todo_service.dart';

class TodoPage extends StatefulWidget {
  final int userId;
  const TodoPage({super.key, required this.userId});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  late Future<List<TodoModel>> _todoFuture;
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadTodos();
  }

  void _loadTodos() {
    _todoFuture = TodoService.getTodos(widget.userId);
  }

  Future<void> _refresh() async {
    setState(() => _loadTodos());
  }

  /// 🔴 CONFIRM DELETE
  Future<void> _confirmDelete(int todoId) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Delete Todo'),
        content: const Text('Are you sure you want to delete this todo?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirm == true) {
      await TodoService.deleteTodo(todoId);

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Todo deleted successfully'),
          backgroundColor: Colors.red,
        ),
      );

      _refresh();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My Todos")),
      body: Column(
        children: [
          // ➕ ADD TODO
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: "New todo...",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () async {
                    if (_controller.text.isEmpty) return;

                    await TodoService.addTodo(
                      widget.userId,
                      _controller.text,
                    );

                    _controller.clear();
                    _refresh();
                  },
                ),
              ],
            ),
          ),

          // 📋 TODO LIST
          Expanded(
            child: FutureBuilder<List<TodoModel>>(
              future: _todoFuture,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                final todos = snapshot.data!;
                if (todos.isEmpty) {
                  return const Center(child: Text("No todos yet"));
                }

                return RefreshIndicator(
                  onRefresh: _refresh,
                  child: ListView.builder(
                    itemCount: todos.length,
                    itemBuilder: (context, i) {
                      final todo = todos[i];

                      return ListTile(
                        leading: Checkbox(
                          value: todo.isDone == 1,
                          onChanged: (v) async {
                            await TodoService.updateTodo(
                              todo.id,
                              v! ? 1 : 0,
                            );
                            _refresh();
                          },
                        ),
                        title: Text(
                          todo.title,
                          style: TextStyle(
                            decoration: todo.isDone == 1
                                ? TextDecoration.lineThrough
                                : null,
                          ),
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _confirmDelete(todo.id),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
