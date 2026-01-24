import 'package:flutter/material.dart';
import '../models/note_model.dart';
import '../screens/detail_note_page.dart';

// Widget card untuk menampilkan ringkasan note
class NoteCard extends StatefulWidget {
  // Data note yang akan ditampilkan
  final NoteModel note;

  const NoteCard({super.key, required this.note});

  @override
  State<NoteCard> createState() => _NoteCardState();
}

class _NoteCardState extends State<NoteCard> {
  @override
  Widget build(BuildContext context) {
    final note = widget.note;

    return Card(
      elevation: 4, // Efek bayangan card
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14), // Sudut membulat
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),

        // Aksi ketika card ditekan
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => DetailNotePage(note: note),
            ),
          );
        },

        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // Menampilkan gambar jika tersedia
              if (note.image != null && note.image!.isNotEmpty)
                Hero(
                  // Hero animation berdasarkan ID note
                  tag: 'note_${note.id}',
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      note.image!,
                      height: 120,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

              const SizedBox(height: 8),

              // Menampilkan judul note
              Text(
                note.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),

              const SizedBox(height: 4),

              // Menampilkan cuplikan isi note
              Text(
                note.content,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.grey[700]),
              ),

              const Spacer(),

              // Baris bawah: tanggal & tombol favorit
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Tanggal pembuatan note
                  Text(
                    note.createdAt,
                    style: const TextStyle(fontSize: 12),
                  ),

                  // Tombol favorit (hanya di UI, belum ke database)
                  IconButton(
                    icon: Icon(
                      note.isFavorite
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: Colors.red,
                    ),
                    onPressed: () {
                      // Mengubah status favorit
                      setState(() {
                        note.isFavorite = !note.isFavorite;
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
