import 'package:flutter/material.dart';
import 'package:movieapp/injector_provider.dart';
import 'package:movieapp/presentation/pages/home/home_page.dart';

//TODO refactor UI
//TODO remove interceptors

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
      ),
      home: HomePage(),
    );
  }
}
