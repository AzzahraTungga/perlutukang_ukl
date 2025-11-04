import 'package:flutter/material.dart';
import 'package:ukl_2025/UklCoba/SplashScreen.dart';
import 'package:ukl_2025/UklCoba/Profile.dart';
import 'package:ukl_2025/UklCoba/Transaction.dart';
import 'package:ukl_2025/ukltes.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  // Ensure Flutter bindings are initialized and locale data is ready
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('id_ID', null);
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
