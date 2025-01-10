import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'screens/home_screen.dart';

void main() async {
  await dotenv.load();
await dotenv.load();
await Supabase.initialize(
  url: dotenv.env['https://ybjzdmvmlkevkwspsjry.supabase.co']!,
  anonKey: dotenv.env['eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImR4enRrZmF4cGhtbHhlaHVudG9hIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzYwOTg4ODAsImV4cCI6MjA1MTY3NDg4MH0.ZgxnQgI6p66zE4ZevCN2ImUK7_oJQiJUUk-6Et-X7Wc']!,
);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Restaurant Menu',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(), // HomeScreen as the starting screen
    );
  }
}
