import 'package:flutter/material.dart';
import '../services/auth_service.dart';

// Halaman untuk registrasi akun baru
class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // Controller untuk input nama lengkap
  final nameC = TextEditingController();

  // Controller untuk input email
  final emailC = TextEditingController();

  // Controller untuk input password
  final passC = TextEditingController();

  // Status loading saat proses register
  bool loading = false;

  // Fungsi untuk proses registrasi
  void register() async {
    // Validasi: semua field wajib diisi
    if (nameC.text.isEmpty ||
        emailC.text.isEmpty ||
        passC.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Semua field wajib diisi")),
      );
      return;
    }

    // Mengaktifkan loading
    setState(() => loading = true);

    // Memanggil AuthService untuk register
    final res = await AuthService.register(
      nameC.text,
      emailC.text,
      passC.text,
    );

    // Menonaktifkan loading
    setState(() => loading = false);

    // Menampilkan pesan dari response API
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(res['message'] ?? 'Register selesai')),
    );

    // Jika status dari API bernilai true, registrasi berhasil
    if (res['status'] == true) {
      // Kembali ke halaman login
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    // Membersihkan controller untuk mencegah memory leak
    nameC.dispose();
    emailC.dispose();
    passC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar halaman register
      appBar: AppBar(title: const Text("Register Akun")),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Input nama lengkap
            TextField(
              controller: nameC,
              decoration: const InputDecoration(labelText: "Nama Lengkap"),
            ),

            // Input email
            TextField(
              controller: emailC,
              decoration: const InputDecoration(labelText: "Email"),
              keyboardType: TextInputType.emailAddress,
            ),

            // Input password (disembunyikan)
            TextField(
              controller: passC,
              decoration: const InputDecoration(labelText: "Password"),
              obscureText: true,
            ),

            const SizedBox(height: 25),

            // Tombol register
            ElevatedButton(
              onPressed: loading ? null : register,
              child: loading
              // Loading indicator saat proses register
                  ? const CircularProgressIndicator(color: Colors.white)
              // Teks tombol normal
                  : const Text("Register"),
            ),
          ],
        ),
      ),
    );
  }
}
