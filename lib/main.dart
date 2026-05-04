import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.light);

void main() {
  runApp(const PokemonApp());
}

class PokemonApp extends StatelessWidget {
  const PokemonApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (_, ThemeMode currentMode, __) {
        return MaterialApp(
          title: 'Irsyad Rafisqy - Ujikom Pokemon', // Akan terlihat di task switcher / tab browser
          debugShowCheckedModeBanner: false, // Menghilangkan pita "DEBUG" merah
          themeMode: currentMode,
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
          darkTheme: ThemeData(
            useMaterial3: true,
            scaffoldBackgroundColor: const Color(0xFF121212),
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.blue,
              brightness: Brightness.dark,
            ),
            appBarTheme: const AppBarTheme(
              backgroundColor: Color(0xFF1C1C1E),
              foregroundColor: Colors.white,
              elevation: 0,
            ),
          ),
          home: const HomeScreen(),
        );
      },
    );
  }
}