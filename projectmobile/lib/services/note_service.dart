import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/api.dart';
import '../models/note_model.dart';

class NoteService {
  // =======================
  // GET NOTES
  // =======================
  static Future<List<NoteModel>> getNote() async {
    final response = await http.get(
      Uri.parse('${Api.baseUrl}/notes/index.php'),
    );

    if (response.statusCode != 200) {
      throw Exception('Gagal memuat catatan');
    }

    final List data = jsonDecode(response.body);
    return data.map((e) => NoteModel.fromJson(e)).toList();
  }

  // =======================
  // ADD NOTE
  // =======================
  static Future<Map<String, dynamic>> addNote({
    required String title,
    required String content,
    required int userId,
    String? image,
  }) async {
    final response = await http.post(
      Uri.parse('${Api.baseUrl}/notes/store.php'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'title': title,
        'content': content,
        'user_id': userId,
        'image': image,
      }),
    );

    return jsonDecode(response.body);
  }

  // =======================
  // UPDATE NOTE
  // =======================
  static Future<Map<String, dynamic>> updateNote({
    required int id,
    required String title,
    required String content,
    String? image,
  }) async {
    final response = await http.post(
      Uri.parse('${Api.baseUrl}/notes/update.php'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'id': id,
        'title': title,
        'content': content,
        'image': image,
      }),
    );

    return jsonDecode(response.body);
  }

  // =======================
  // DELETE NOTE
  // =======================
  static Future<Map<String, dynamic>> deleteNote(int id) async {
    final response = await http.post(
      Uri.parse('${Api.baseUrl}/notes/delete.php'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'id': id}),
    );

    return jsonDecode(response.body);
  }
}
