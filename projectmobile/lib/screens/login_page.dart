import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/auth_service.dart';
import 'home_page.dart';
import 'register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailC = TextEditingController();
  final passC = TextEditingController();
  bool loading = false;

  Future<void> login() async {
    setState(() => loading = true);

    final res = await AuthService.login(
      emailC.text,
      passC.text,
    );

    setState(() => loading = false);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(res['message'])),
    );

    // ✅ LOGIN SUCCESS
    if (res['success'] == true && res['token'] != null) {
      final prefs = await SharedPreferences.getInstance();

      // ✅ SAVE TOKEN
      await prefs.setString('token', res['token']);

      // ✅ SAVE USER ID (THIS WAS MISSING)
      await prefs.setInt('user_id', res['user']['id']);

      // (optional)
      await prefs.setString('user_name', res['user']['name']);

      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomePage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login Notes")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: emailC,
              decoration: const InputDecoration(labelText: "Email"),
            ),
            TextField(
              controller: passC,
              decoration: const InputDecoration(labelText: "Password"),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: loading ? null : login,
              child: loading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text("Login"),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const RegisterPage()),
                );
              },
              child: const Text("Belum punya akun? Register"),
            )
          ],
        ),
      ),
    );
  }
}
