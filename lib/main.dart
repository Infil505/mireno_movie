import 'package:flutter/material.dart';
import 'package:mireno_movie/config/theme/theme_app.dart';
import 'package:mireno_movie/screen/discover/discover_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
        title: 'Minero App',
        darkTheme: AppTheme.darkTheme,
        home: const MyMovieApp(),
    );
  }
}