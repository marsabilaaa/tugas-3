import 'package:flutter/material.dart';
import 'package:tugas3/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _saveUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('username', _usernameController.text);
  }

  // Fungsi untuk menampilkan input
  Widget _showInput(controller, placeholder, isPassword) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        hintText: placeholder,
        border: OutlineInputBorder(),
        labelText: placeholder,
      ),
    );
  }

  // Fungsi untuk menampilkan dialog
  void _showDialog(pesan, alamat) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(pesan),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.pushReplacement(
                  context, MaterialPageRoute(
                    builder: (context) => alamat,
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Menampilkan input untuk username
            _showInput(_usernameController, 'Masukkan username', false),
            // Menampilkan input untuk password
            _showInput(_passwordController, 'Masukkan password', true),
            const SizedBox(height: 20),
            ElevatedButton(
              child: const Text('Login'),
              onPressed: () {
                if (_usernameController.text == 'admin' &&
                    _passwordController.text == 'admin') {
                  _saveUsername();
                  _showDialog('Anda berhasil login', HomeScreen());

                } else {
                  _showDialog('Username dan password salah', LoginPage());
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
