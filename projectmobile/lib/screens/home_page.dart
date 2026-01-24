import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/note_model.dart';
import '../services/note_service.dart';
import 'detail_note_page.dart';
import 'add_note_page.dart';
import 'login_page.dart';
import 'todo_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<NoteModel>> _notesFuture;
  int? userId;

  @override
  void initState() {
    super.initState();
    _loadUser();
    _loadNotes();
  }

  // ======================
  // LOAD USER ID
  // ======================
  Future<void> _loadUser() async {
    final prefs = await SharedPreferences.getInstance();
    final id = prefs.getInt('user_id');

    debugPrint("USER ID = $id");

    setState(() {
      userId = id;
    });
  }

  // ======================
  // LOAD NOTES
  // ======================
  void _loadNotes() {
    _notesFuture = NoteService.getNote();
  }

  Future<void> _refresh() async {
    setState(() {
      _loadNotes();
    });
  }

  // ======================
  // LOGOUT
  // ======================
  Future<void> _logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    if (!mounted) return;

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const LoginPage()),
          (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Notes'),
        centerTitle: true,
        actions: [
          // ✅ TODO BUTTON
          IconButton(
            icon: const Icon(Icons.checklist),
            tooltip: "My Todos",
            onPressed: () {
              if (userId == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("User not logged in"),
                    backgroundColor: Colors.red,
                  ),
                );
                return;
              }

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => TodoPage(userId: userId!),
                ),
              );
            },
          ),

          // ✅ LOGOUT BUTTON
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              final confirm = await showDialog<bool>(
                context: context,
                builder: (_) => AlertDialog(
                  title: const Text('Logout'),
                  content: const Text('Are you sure you want to logout?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context, false),
                      child: const Text('Cancel'),
                    ),
                    ElevatedButton(
                      onPressed: () => Navigator.pop(context, true),
                      child: const Text('Logout'),
                    ),
                  ],
                ),
              );

              if (confirm == true) {
                _logout(context);
              }
            },
          ),
        ],
      ),

      // ======================
      // ADD NOTE BUTTON
      // ======================
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddNotePage()),
          );

          if (result == true && mounted) {
            _refresh();
          }
        },
      ),

      // ======================
      // NOTES LIST
      // ======================
      body: FutureBuilder<List<NoteModel>>(
        future: _notesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          final notes = snapshot.data ?? [];

          if (notes.isEmpty) {
            return const Center(
              child: Text(
                'No notes yet',
                style: TextStyle(fontSize: 16),
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: _refresh,
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: notes.length,
              itemBuilder: (context, index) {
                final note = notes[index];

                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 3,
                  child: ListTile(
                    leading: const Icon(Icons.note),
                    title: Text(
                      note.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Text(
                      note.content,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    onTap: () async {
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => DetailNotePage(note: note),
                        ),
                      );

                      if (result == true && mounted) {
                        _refresh();
                      }
                    },
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
