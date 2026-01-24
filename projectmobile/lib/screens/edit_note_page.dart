import 'package:flutter/material.dart';
import '../models/note_model.dart';
import '../services/note_service.dart';

class EditNotePage extends StatefulWidget {
  final NoteModel note;

  const EditNotePage({super.key, required this.note});

  @override
  State<EditNotePage> createState() => _EditNotePageState();
}

class _EditNotePageState extends State<EditNotePage> {
  late TextEditingController titleC;
  late TextEditingController contentC;
  late TextEditingController imageC;
  bool loading = false;

  @override
  void initState() {
    super.initState();
    titleC = TextEditingController(text: widget.note.title);
    contentC = TextEditingController(text: widget.note.content);
    imageC = TextEditingController(text: widget.note.image ?? '');
  }

  Future<void> submit() async {
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

    final result = await NoteService.updateNote(
      id: widget.note.id,
      title: titleC.text,
      content: contentC.text,
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
      appBar: AppBar(title: const Text('Edit Note')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: titleC,
              decoration: const InputDecoration(labelText: 'Judul'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: contentC,
              maxLines: 5,
              decoration: const InputDecoration(labelText: 'Isi'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: imageC,
              decoration:
              const InputDecoration(labelText: 'Image URL (opsional)'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: loading ? null : submit,
              child: loading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text('Update'),
            ),
          ],
        ),
      ),
    );
  }
}
