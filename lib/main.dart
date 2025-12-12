import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wetter_app/src/core/home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Optimize for Web
  if (kIsWeb) {
    // Disable debug print in release for better performance
    if (kReleaseMode) {
      debugPrint = (String? message, {int? wrapWidth}) {};
    }
  }

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Set system UI overlay style for better integration
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: Colors.black,
      ),
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Wetter',
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.black,
      ),
      home: const HomeScreen(),
    );
  }
}
