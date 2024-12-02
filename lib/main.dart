import 'package:flutter/material.dart';
import 'package:flutter_app/screens/bible/bible_onboard.dart';
import 'package:flutter_app/screens/bible/bible_reader.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'Times',
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      //home: const BibleReaderPage(),
      home: const BibleOnboard(),
    );
  }
}
