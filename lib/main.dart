import 'package:flutter/material.dart';

import 'database/database_creator.dart';
import 'pages/home_page.dart';

const API_KEY = "AIzaSyAPbxsTh6PW6oq3uZlkGNVrpZtC3qintN0 ";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseCreator().initDatabase();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }
}
