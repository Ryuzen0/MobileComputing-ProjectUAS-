import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/api.dart';
import '../models/todo_model.dart';

class TodoService {

  // GET TODOS
  static Future<List<TodoModel>> getTodos(int userId) async {
    final res = await http.get(
      Uri.parse("${Api.baseUrl}/todos/index.php?user_id=$userId"),
    );

    final List data = jsonDecode(res.body);
    return data.map((e) => TodoModel.fromJson(e)).toList();
  }

  // ADD TODO
  static Future<bool> addTodo(int userId, String title) async {
    final res = await http.post(
      Uri.parse("${Api.baseUrl}/todos/store.php"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "user_id": userId,
        "title": title,
      }),
    );

    final data = jsonDecode(res.body);
    return data['success'];
  }

  // UPDATE TODO (DONE / UNDONE)
  static Future<bool> updateTodo(int id, int isDone) async {
    final res = await http.put(
      Uri.parse("${Api.baseUrl}/todos/update.php"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "id": id,
        "is_done": isDone,
      }),
    );

    final data = jsonDecode(res.body);
    return data['success'];
  }

  // DELETE TODO
  static Future<bool> deleteTodo(int id) async {
    final res = await http.delete(
      Uri.parse("${Api.baseUrl}/todos/delete.php"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"id": id}),
    );

    final data = jsonDecode(res.body);
    return data['success'];
  }
}
