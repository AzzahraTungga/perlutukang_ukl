import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Akun'),
        // Tambahkan kolom pencarian dan ikon notifikasi
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            // Bagian Profil (Nama, Email, Telepon)
            _buildProfileSection(),
            const Divider(),
            // Daftar Menu Akun
            _buildAccountMenuItem(Icons.lock, 'Ubah Password', hasArrow: true),
            _buildAccountMenuItem(Icons.description, 'Ketentuan Layanan'),
            _buildAccountMenuItem(Icons.security, 'Kebijakan Privasi'),
            _buildAccountMenuItem(Icons.chat, 'Whatsapp Admin'),
            _buildAccountMenuItem(Icons.logout, 'Keluar', isDanger: true),
            const Divider(),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text('Version V 1.3.6', style: TextStyle(color: Colors.grey)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileSection() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 30,
            backgroundImage: AssetImage('assets/zea imut.jpg'),
          ),
          const SizedBox(width: 16),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Zea', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              Text('zeackpbgt@gamil.com', style: TextStyle(color: Colors.grey)),
              Text('123456789', style: TextStyle(color: Colors.grey)),
            ],
          ),
          const Spacer(),
          ElevatedButton(
            onPressed: () {
              // Aksi edit profil
            },
            child: const Text('Edit'),
          ),
        ],
      ),
    );
  }

  Widget _buildAccountMenuItem(IconData icon, String title, {bool hasArrow = false, bool isDanger = false}) {
    return ListTile(
      leading: Icon(icon, color: isDanger ? Colors.red : Colors.black),
      title: Text(
        title,
        style: TextStyle(color: isDanger ? Colors.red : Colors.black),
      ),
      trailing: hasArrow ? const Icon(Icons.chevron_right) : null,
      onTap: () {
        // Aksi saat menu diklik
      },
    );
  }
}