import 'package:contacts_app/view/contacts.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.white,
        accentColor: Color(0xFFD8ECF1),
        //scaffoldBackgroundColor: Color(0xFFF3F5F7),
        visualDensity: VisualDensity.adaptivePlatformDensity
      ),
      home: ContactsDashboard()
    );
  }
}

