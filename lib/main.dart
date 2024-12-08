import 'package:flutter/material.dart';
import 'package:wetter_app/src/core/home_screen.dart';

// SharedPreferences
// InitState N/A begin
// OnRefresh (?)
// Data tests
// Tastatur gelicnce kcükmesi
// stack tastatur acilinca ui hatasi vardi?
// swipable appbar (?)
// IOS ICIN FARKLI BENUTZEN: GERCI WEEBSEITE DE YAZI OLACAK
// scaffol ddisina basinca shomodal gidiyor!!!
// flackern yapiyor???
// mein standort gec dolyuor

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
