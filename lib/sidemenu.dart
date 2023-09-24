import 'package:flutter/material.dart';
import 'package:tugas3/main.dart';
import 'package:tugas3/add_form.dart';

class Sidemenu extends StatelessWidget {
  const Sidemenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            child: Text('Sidemenu'),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
              // Navigasi ke halaman Home
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomeScreen(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('Tambah Data'),
            onTap: () {
              // Navigasi ke halaman About
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddForm(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
