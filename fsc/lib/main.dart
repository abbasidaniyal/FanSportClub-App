import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import './pages/welcome_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Color.fromRGBO(120, 171, 9, 1), //green
        textSelectionColor: Color.fromRGBO(120, 171, 9, 1),
        accentColor: Color.fromRGBO(33, 33, 33, 1), //black
        //fontFamily: "Oswald",
        textTheme: TextTheme(
          headline: TextStyle(
            color: Color.fromRGBO(120, 171, 9, 1),
          ),
          title: TextStyle(
            color: Color.fromRGBO(120, 171, 9, 1),
          ),
          caption: TextStyle(
            color: Color.fromRGBO(120, 171, 9, 1),
          ),
          subtitle: TextStyle(
            color: Colors.grey,
          ),         
        )
      ),
      routes: {
        "/": (BuildContext context) {
          return WelcomePage();
        }
      },
    );
  }
}
