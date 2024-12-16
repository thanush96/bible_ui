import 'package:flutter/material.dart';
import 'package:flutter_app/provider/language_provider.dart';
import 'package:flutter_app/screens/bible/bible_onboard.dart';
// import 'package:flutter_app/screens/bible/bible_reader.dart';
import 'package:provider/provider.dart';

import 'provider/bible_id_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LanguageProvider()),
        ChangeNotifierProvider(
            create: (_) => BibleIDProvider()), // Add BibleIDProvider
      ],
      child: const MyApp(),
    ),
  );
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
      // home: BibleReaderPage(
      //   bibleId: 'de4e12af7f28f599-01',
      //   chapterId: 'JHN.intro',
      // ),
      home: const BibleOnboard(),
    );
  }
}
