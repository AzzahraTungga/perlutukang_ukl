import 'package:flutter/material.dart';
import 'package:ukl_2025/UklCoba/SplashScreen.dart';
import 'package:ukl_2025/UklCoba/Profile.dart';
import 'package:ukl_2025/UklCoba/Transaction.dart';
import 'package:ukl_2025/ukltes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tukang.com',
      initialRoute: '/home',
      routes: {
        '/home': (context) => const DashboardScreen(),
        '/orders': (context) => const TransactionScreen(),
        '/profile': (context) => const Profile(),
      },
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber),
        useMaterial3: true,
      ),
    );
  }
}
