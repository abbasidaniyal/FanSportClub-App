import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:scoped_model/scoped_model.dart';
import './pages/splash_screen_page.dart';
import './scoped_model/main.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModel(
      model: MainModel(),
      child: MaterialApp(
        theme: ThemeData(
            buttonTheme: ButtonThemeData(),
            primaryColor: Color.fromRGBO(33, 33, 33, 1),
            textSelectionColor: Color.fromRGBO(120, 171, 9, 1),
            accentColor: Color.fromRGBO(120, 171, 9, 1), //black
            secondaryHeaderColor: Color.fromRGBO(33, 33, 33, 1),

            
            
            fontFamily: 'Roboto',
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
            )),
        routes: {
          "/": (BuildContext context) {
            return WelcomePage();
          }
        },
      ),
    );
  }
}
