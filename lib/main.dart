import 'package:flutter/material.dart';
import 'package:wetter_app/src/core/home_screen.dart';

// SharedPreferences
// InitState N/A begin
// OnRefresh (?)
// Data tests
// swipable appbar (?)

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false, home: HomeScreen());
  }
}
