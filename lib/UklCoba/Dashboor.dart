import 'package:flutter/material.dart';

abstract class homeScreen extends StatelessWidget {
  const homeScreen({super.key});

  // ... (Metode build(BuildContext context) ada di sini) ...

  // 1. Bagian Lokasi (Sudah ada di jawaban sebelumnya, diulang untuk kelengkapan)
  Widget _buildLocationSection() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        children: [
          Icon(Icons.location_on, color: Colors.blue, size: 20),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              'Kota Malang, Kedungkandang', // Sesuai Gambar 2 [cite: 89]
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Icon(Icons.chevron_right), // Sesuai Gambar 2
        ],
      ),
    );
  }

  // 2. Implementasi Bagian Banner/Promo
  Widget _buildPromoBanner() {
    // Banner umumnya menggunakan CarouselSlider atau ListView horizontal
    // Di sini kita gunakan ListView.builder horizontal sederhana.
    // Asumsi: Anda memiliki gambar banner di assets/banner_1.png
    return SizedBox(
      height: 150,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        itemCount: 3, // Jumlah banner
        itemBuilder: (context, index) {
          return Container(
            width: MediaQuery.of(context).size.width * 0.8, // Lebar 80% layar
            margin: const EdgeInsets.only(right: 10.0),
            decoration: BoxDecoration(
              color: index == 0 ? Colors.purple.shade100 : Colors.blue.shade100,
              borderRadius: BorderRadius.circular(10),
              // Idealnya, gunakan Image.asset('assets/banner_$index.png')
            ),
            child: const Center(
              child: Text(
                'Lakukan Dalam Satu Aplikasi', // Konten banner sesuai Gambar 2 [cite: 85]
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ),
          );
        },
      ),
    );
  }

  // 3. Implementasi Bagian Kategori Jasa (Horizontal List)
  Widget _buildServiceCategories() {
    // Data dummy untuk Kategori Jasa (Sesuai Gambar 2) [cite: 93, 94, 95]
    final categories = [
      {'name': 'Servis Ac', 'icon': Icons.ac_unit},
      {'name': 'Servis Cat', 'icon': Icons.format_paint},
      {'name': 'Servis Cctv', 'icon': Icons.videocam},
      {'name': 'Servis Bangunan', 'icon': Icons.construction},
      {'name': 'Servis Derek', 'icon': Icons.car_repair},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 4.0),
          child: Text(
            'Kategori Jasa', // Sesuai Gambar 2 [cite: 91]
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            'Temukan kebutuhan servismu dibawah ini sesuai yang kamu butuhkan', // Sesuai Gambar 2 [cite: 92]
            style: TextStyle(color: Colors.grey, fontSize: 12),
          ),
        ),
        SizedBox(
          height: 90, // Tinggi untuk list horizontal
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: InkWell(
                  onTap: () {
                    // Navigasi ke halaman detail kategori
                  },
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.grey.shade300)
                        ),
                        child: Icon(categories[index]['icon'] as IconData, color: Colors.blue),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        categories[index]['name'] as String, 
                        style: const TextStyle(fontSize: 12),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  // 4. Implementasi Bagian Penyedia Jasa Terdekat
  Widget _buildNearestServiceProviders() {
    // Data dummy Penyedia Jasa Terdekat (Sesuai Gambar 2) [cite: 97, 99]
    final providers = [
      {'name': 'servis laptop malang', 'distance': '6.41 Km', 'address': 'Jl. Gajayana, Ketawanggede, Kec. Lowokwaru, Kota M'},
      {'name': 'PietComp', 'distance': '4.89 Km', 'address': 'Gg. 3 No.64, Bandungrejoso, Kec. Sukun, Kota Mal...'},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
          child: Text(
            'Penyedia Jasa Terdekat', // Sesuai Gambar 2 [cite: 96]
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: providers.map((provider) {
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${provider['name']} (${provider['distance']})',
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        provider['address']!,
                        style: const TextStyle(color: Colors.grey, fontSize: 12),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  // 5. Implementasi Bagian Artikel Terbaru
  Widget _buildLatestArticles() {
    // Data dummy Artikel Terbaru (Sesuai Gambar 2) [cite: 104, 108, 110]
    final articles = [
      {'title': 'Update Aplikasi Perlu Tukang', 'color': Colors.blue.shade100},
      {'title': 'Update Terbaru Untuk Mitra (Tukang)', 'color': Colors.yellow.shade100},
      {'title': 'Update Terbaru Untuk Konsumen', 'color': Colors.green.shade100},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
          child: Text(
            'Artikel Terbaru', // Sesuai Gambar 2 [cite: 98]
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        ListView.builder(
          shrinkWrap: true, // Penting agar ListView bisa berada di dalam SingleChildScrollView
          physics: const NeverScrollableScrollPhysics(), // Menonaktifkan scroll di dalam
          itemCount: articles.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 4.0, 16.0, 8.0),
              child: Container(
                height: 100, // Sesuaikan tinggi gambar banner artikel
                decoration: BoxDecoration(
                  color: articles[index]['color'] as Color,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    articles[index]['title'] as String,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            );
          },
        ),
        const SizedBox(height: 80), // Memberi ruang di bagian bawah agar tidak terpotong BottomNavigationBar
      ],
    );
  }
}