import 'package:flutter/material.dart';
import 'package:tes_internship_william_hubertus/screen/FirstScreen.dart';
import 'package:tes_internship_william_hubertus/screen/SecondScreen.dart';
import 'package:tes_internship_william_hubertus/screen/ThirdScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(routes: {
      '/': (context) => FirstScreen(),
      '/second_screen': (context) {
        final String name = ModalRoute.of(context)!.settings.arguments
            as String; // Mengambil nama dari argumen
        return SecondScreen(name: name); // Mengoper nama ke SecondScreen
      },
      '/third_screen': (context) => ThirdScreen(),
    });
  }
}
