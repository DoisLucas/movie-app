import 'package:flutter/material.dart';
import 'package:movieapp/injector_provider.dart';
import 'package:movieapp/presentation/pages/home/home_page.dart';

void main() {
  setupInjection();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IMDB Movies',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        cursorColor: Colors.white,
        textSelectionHandleColor: Colors.white,
        textSelectionColor: Colors.white30,
      ),
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
