import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

// Package intl diperlukan untuk memformat tanggal dan waktu.
// Tambahkan ke pubspec.yaml:
// dependencies:
//   intl: ^0.18.0

void main() async {
  // Inisialisasi locale Indonesia untuk DateFormat
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('id_ID', null);

  runApp(const UklTes25());
}

class UklTes25 extends StatelessWidget {
  const UklTes25({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Presensi Online Dashboard',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
        fontFamily: 'Roboto',
      ),
      home: const DashboardScreen(),
    );
  }
}

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  // Data State Aplikasi
  String _userName = 'Salsa';
  String _userRole = 'Guru';
  String? _checkInTime; // Waktu Absen Masuk
  String? _checkOutTime; // Waktu Absen Pulang
  String _message = 'Selamat datang, silakan lakukan presensi.';
  bool _isLoading = false;

  // Inisialisasi DateFormat langsung
  final DateFormat _dateFormatter = DateFormat('EEEE, dd MMMM yyyy', 'id_ID');
  final DateFormat _timeFormatter = DateFormat('HH:mm:ss');
  final DateFormat _attendanceTimeFormatter = DateFormat('HH:mm');

  // --- Fungsi Utama Presensi (Simulasi Jaringan) ---
  Future<void> handleAttendance(String type) async {
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
      _message = 'Memproses permintaan presensi $type...';
    });

    // Simulasi penundaan jaringan (loading 2 detik)
    await Future.delayed(const Duration(seconds: 2));

    final currentTime = _attendanceTimeFormatter.format(DateTime.now());

    try {
      if (type == 'masuk') {
        if (_checkInTime != null) {
          // Gagal: Sudah presensi masuk
          _message =
              '❌ Anda sudah melakukan Presensi Masuk pada $_checkInTime.';
        } else {
          // Sukses: Presensi Masuk
          _checkInTime = currentTime;
          _message = '✅ Presensi Masuk berhasil dicatat pada $currentTime.';
          _checkOutTime =
              null; // Reset pulang jika masuk lagi di hari yang sama (opsional)
        }
      } else if (type == 'pulang') {
        if (_checkInTime == null) {
          // Gagal: Belum presensi masuk
          _message = '❌ Anda harus melakukan Presensi Masuk terlebih dahulu.';
        } else if (_checkOutTime != null) {
          // Gagal: Sudah presensi pulang
          _message =
              '❌ Anda sudah melakukan Presensi Pulang pada $_checkOutTime.';
        } else {
          // Sukses: Presensi Pulang
          _checkOutTime = currentTime;
          _message = '✅ Presensi Pulang berhasil dicatat pada $currentTime.';
        }
      }
    } catch (e) {
      _message = 'Terjadi kesalahan sistem: $e';
    } finally {
      setState(() {
        _isLoading = false;
      });
    }

    // Tampilkan pesan status
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(_message),
          backgroundColor: _message.contains('✅') ? Colors.green : Colors.red,
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  // Widget untuk Kartu Status Presensi (Datang/Pulang)
  Widget _buildAttendanceStatusCard() {
    final now = DateTime.now();

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      margin: const EdgeInsets.only(top: 20, bottom: 30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          // Tanggal dan Waktu Sekarang
          Text(
            _dateFormatter.format(now),
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          Text(
            _timeFormatter.format(now),
            style: const TextStyle(fontSize: 16, color: Colors.grey),
          ),
          const Divider(height: 30, indent: 30, endIndent: 30),
          // Status Waktu Masuk dan Pulang
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildTimeIndicator(
                label: 'Datang',
                time: _checkInTime ?? '--:--',
                color: _checkInTime != null
                    ? Colors.green.shade600
                    : Colors.grey,
              ),
              _buildTimeIndicator(
                label: 'Pulang',
                time: _checkOutTime ?? '--:--',
                color: _checkOutTime != null
                    ? Colors.red.shade600
                    : Colors.grey,
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Widget Pembantu untuk Indikator Waktu
  Widget _buildTimeIndicator({
    required String label,
    required String time,
    required Color color,
  }) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          time,
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w900,
            color: color,
          ),
        ),
      ],
    );
  }

  // Widget untuk Tombol Aksi dalam Grid
  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required Color color,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.grey.shade200),
          boxShadow: [BoxShadow(color: color.withOpacity(0.1), blurRadius: 5)],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 36, color: color),
            const SizedBox(height: 8),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.black87,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget untuk Profil Pengguna
  Widget _buildProfileHeader() {
    return Container(
      padding: const EdgeInsets.only(top: 20, bottom: 20),
      decoration: BoxDecoration(
        color: Colors.blueAccent.shade400,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.blueAccent.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          // Judul dan Status Bar Simulasi
          const Text(
            'Demo Admin Sekolah',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 15),
          // Foto Profil
          const CircleAvatar(
            radius: 40,
            backgroundColor: Colors.white,
            child: Icon(Icons.person, size: 50, color: Colors.blueAccent),
          ),
          const SizedBox(height: 10),
          // Nama dan Jabatan
          Text(
            _userName,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            _userRole,
            style: TextStyle(color: Colors.blue.shade100, fontSize: 16),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Stack(
        children: [
          // Bagian Atas (Header Biru)
          _buildProfileHeader(),

          // Konten Utama (di ScrollView agar bisa digulir)
          Padding(
            padding: const EdgeInsets.only(
              top: 210,
            ), // Sesuaikan dengan tinggi header
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Kartu Status Presensi
                  _buildAttendanceStatusCard(),

                  // Indikator Loading Global
                  if (_isLoading)
                    const LinearProgressIndicator(
                      color: Colors.blueAccent,
                      backgroundColor: Colors.transparent,
                    ),
                  const SizedBox(height: 20),

                  // Grid Aksi Presensi & Modul Lain
                  GridView.count(
                    crossAxisCount: 3,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                    shrinkWrap: true,
                    physics:
                        const NeverScrollableScrollPhysics(), // Non-scrollable grid
                    children: <Widget>[
                      // 1. Absen Datang (Check-in)
                      _buildActionButton(
                        icon: Icons.fingerprint,
                        label: 'Absen Datang',
                        color: Colors.green.shade600,
                        onTap: _isLoading
                            ? null
                            : () => handleAttendance('masuk'),
                      ),
                      // 2. Absen Pulang (Check-out)
                      _buildActionButton(
                        icon: Icons.exit_to_app,
                        label: 'Absen Pulang',
                        color: Colors.red.shade600,
                        onTap: _isLoading
                            ? null
                            : () => handleAttendance('pulang'),
                      ),
                      // 3. Perizinan
                      _buildActionButton(
                        icon: Icons.sticky_note_2_outlined,
                        label: 'Perizinan',
                        color: Colors.orange.shade600,
                        onTap: () {
                          setState(
                            () => _message = 'Navigasi ke halaman Perizinan...',
                          );
                        },
                      ),
                      // 4. Jadwal Pelajaran
                      _buildActionButton(
                        icon: Icons.calendar_month,
                        label: 'Jadwal Pelajaran',
                        color: Colors.purple.shade600,
                        onTap: () {
                          setState(
                            () => _message = 'Navigasi ke halaman Jadwal...',
                          );
                        },
                      ),
                      // 5. Jurnal Mengajar
                      _buildActionButton(
                        icon: Icons.menu_book,
                        label: 'Jurnal Mengajar',
                        color: Colors.cyan.shade600,
                        onTap: () {
                          setState(
                            () => _message = 'Navigasi ke halaman Jurnal...',
                          );
                        },
                      ),
                      // 6. Ambil Foto (Simulasi fitur tambahan)
                      _buildActionButton(
                        icon: Icons.camera_alt,
                        label: 'Ambil Foto',
                        color: Colors.blueGrey.shade600,
                        onTap: () {
                          setState(
                            () => _message =
                                'Simulasi fitur kamera/ambil foto...',
                          );
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 80), // Padding bawah
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0, // Indeks Home
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'Histori'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Pengaturan',
          ),
        ],
        onTap: (index) {
          final labels = ['Home', 'Histori', 'Profil', 'Pengaturan'];
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Navigasi ke: ${labels[index]} (Simulasi)')),
          );
        },
      ),
    );
  }
}
