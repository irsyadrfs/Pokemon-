import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const PokemonApp());
}

class PokemonApp extends StatelessWidget {
  const PokemonApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Irsyad Rafisqy - Ujikom Pokemon', // Akan terlihat di task switcher / tab browser
      debugShowCheckedModeBanner: false, // Menghilangkan pita "DEBUG" merah
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.grey[50], // Latar belakang abu-abu sangat muda agar Card putih terlihat menonjol
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black, // Warna teks dan icon di AppBar
          elevation: 0,
        ),
      ),
      home: const HomeScreen(),
    );
  }
}