import 'package:flutter/material.dart';

class TransactionScreen extends StatelessWidget {
  const TransactionScreen({super.key});

  // Data dummy untuk transaksi
  final List<Map<String, String>> transactions = const [
    {'name': 'didit tekhnik', 'date': 'Tanggal/Waktu Transaksi', 'status': 'Selesai/Proses'},
    {'name': 'Danish Jaya Teknik', 'date': 'Tanggal/Waktu Transaksi', 'status': 'Selesai/Proses'},
    {'name': 'Free Kuota', 'date': 'Tanggal/Waktu Transaksi', 'status': 'Selesai/Proses'},
    // ... tambahkan data transaksi lainnya
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transaksi'),
        // Tambahkan kolom pencarian dan ikon notifikasi
      ),
      body: ListView.builder(
        itemCount: transactions.length,
        itemBuilder: (context, index) {
          final transaction = transactions[index];
          return ListTile(
            leading: const CircleAvatar(
              // Ganti dengan gambar profil tukang jika ada
              backgroundColor: Colors.grey,
              child: Icon(Icons.person, color: Colors.white),
            ),
            title: Text(
              transaction['name']!,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text('${transaction['date']} - ${transaction['status']}'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              // Aksi saat item transaksi diklik
            },
          );
        },
      ),
    );
  }
}