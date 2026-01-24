import 'package:flutter/material.dart';
import '../models/note_model.dart';
import '../services/note_service.dart';
import 'edit_note_page.dart';

class DetailNotePage extends StatelessWidget {
  final NoteModel note;

  const DetailNotePage({
    super.key,
    required this.note,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Note'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// 🖼 IMAGE (SAFE CHECK)
            if ((note.image ?? '').toString().isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(16),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    note.image.toString(),
                    height: 220,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      height: 220,
                      color: Colors.grey.shade300,
                      child: const Center(
                        child: Text('Image failed to load'),
                      ),
                    ),
                  ),
                ),
              ),

            /// 📝 TITLE
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                note.title,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 12),

            /// 📄 CONTENT
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                note.content,
                style: const TextStyle(fontSize: 16),
              ),
            ),

            const SizedBox(height: 30),

            /// ✏️ EDIT & ❌ DELETE BUTTONS
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                /// EDIT
                ElevatedButton.icon(
                  icon: const Icon(Icons.edit),
                  label: const Text('Edit'),
                  onPressed: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => EditNotePage(note: note),
                      ),
                    );

                    if (result == true) {
                      Navigator.pop(context, true);
                    }
                  },
                ),

                /// DELETE
                ElevatedButton.icon(
                  icon: const Icon(Icons.delete),
                  label: const Text('Delete'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  onPressed: () async {
                    final confirm = await showDialog<bool>(
                      context: context,
                      builder: (c) => AlertDialog(
                        title: const Text('Delete Note'),
                        content: const Text('Are you sure you want to delete this note?'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(c, false),
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () => Navigator.pop(c, true),
                            child: const Text('Delete'),
                          ),
                        ],
                      ),
                    );

                    if (confirm == true) {
                      final response = await NoteService.deleteNote(note.id);

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(response['message'] ?? 'Unknown response'),
                          backgroundColor:
                          response['success'] == true ? Colors.green : Colors.red,
                        ),
                      );

                      if (response['success'] == true) {
                        Navigator.pop(context, true);
                      }
                    }
                  },

                ),
              ],
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
