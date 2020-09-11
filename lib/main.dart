import 'package:flutter/material.dart';
import 'package:movieapp/injector_provider.dart';
import 'package:movieapp/presentation/pages/home/home_page.dart';

//TODO Refactor code UI
//TODO Readme
//TODO Open PR
//TODO Verificar iOS
//TODO replace all in data

void main() {
  setupInjection();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IMDb Movies',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          cursorColor: Colors.white,
          textSelectionHandleColor: Colors.white,
          textSelectionColor: Colors.white30,
          scaffoldBackgroundColor: Colors.black,
          textTheme: TextTheme()),
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
