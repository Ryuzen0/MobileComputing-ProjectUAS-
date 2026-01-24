// Class model yang merepresentasikan data Note
class NoteModel {
  // ID unik untuk setiap catatan
  final int id;

  // Judul catatan
  final String title;

  // Isi atau konten dari catatan
  final String content;

  // Gambar opsional yang terkait dengan catatan (boleh null)
  final String? image;

  // Tanggal pembuatan catatan
  final String createdAt;

  // Penanda apakah catatan difavoritkan atau tidak
  bool isFavorite;

  // Constructor untuk membuat objek NoteModel
  NoteModel({
    required this.id,           // ID catatan (wajib)
    required this.title,        // Judul catatan (wajib)
    required this.content,      // Isi catatan (wajib)
    this.image,                 // Gambar (opsional)
    required this.createdAt,    // Tanggal dibuat (wajib)
    this.isFavorite = false,    // Default status favorit adalah false
  });

  // Factory constructor untuk mengubah data JSON menjadi objek NoteModel
  factory NoteModel.fromJson(Map<String, dynamic> json) {
    return NoteModel(
      // Mengonversi ID ke tipe int (aman jika ID berupa string)
      id: int.parse(json['id'].toString()),

      // Mengambil judul dari JSON
      title: json['title'],

      // Mengambil isi konten dari JSON
      content: json['content'],

      // Mengambil data gambar dari JSON (bisa null)
      image: json['image'],

      // Mengambil tanggal pembuatan, jika null maka string kosong
      createdAt: json['created_at'] ?? '',
    );
  }
}