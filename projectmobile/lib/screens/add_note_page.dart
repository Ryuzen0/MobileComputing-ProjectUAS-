import 'package:flutter/material.dart';
import '../services/note_service.dart';

class AddNotePage extends StatefulWidget {
  const AddNotePage({super.key});

  @override
  State<AddNotePage> createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {
  final titleC = TextEditingController();
  final contentC = TextEditingController();
  final imageC = TextEditingController();

  bool loading = false;

  Future<void> saveNote() async {
    if (titleC.text.isEmpty || contentC.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Judul dan isi tidak boleh kosong'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() => loading = true);

    final result = await NoteService.addNote(
      title: titleC.text,
      content: contentC.text,
      userId: 1, // sementara (ambil dari SharedPreferences nantinya)
      image: imageC.text.isEmpty ? null : imageC.text,
    );

    setState(() => loading = false);

    if (!mounted) return;

    if (result['success'] == true) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(result['message']),
          backgroundColor: Colors.green,
        ),
      );

      Navigator.pop(context, true);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(result['message']),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tambah Note')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: titleC,
              decoration: const InputDecoration(labelText: 'Judul Note'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: contentC,
              maxLines: 5,
              decoration: const InputDecoration(labelText: 'Isi Note'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: imageC,
              decoration:
              const InputDecoration(labelText: 'Image URL (opsional)'),
            ),
            const SizedBox(height: 25),
            ElevatedButton(
              onPressed: loading ? null : saveNote,
              child: loading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text('Simpan'),
            ),
          ],
        ),
      ),
    );
  }
}
