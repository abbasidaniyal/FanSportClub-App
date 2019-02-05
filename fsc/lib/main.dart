import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import './pages/welcome_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(  
      theme: ThemeData(
        primarySwatch: Colors.green,
        brightness: Brightness.light, 
        accentColor: Colors.lightGreenAccent
      ),
      routes: {
        "/": (BuildContext context){
          return WelcomePage();
        } 
      },
          
      );
  }
}