import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:scoped_model/scoped_model.dart';
import './pages/splash_screen_page.dart';
import './scoped_model/main.dart';
import './pages/UnAuthorizedUser/landing_page.dart';
import 'package:flutter/services.dart';

void main() {
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((onValue) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModel(
      model: MainModel(),
      child: MaterialApp(
        theme: ThemeData(
            buttonTheme: ButtonThemeData(),
            primaryColor: Color.fromRGBO(33, 33, 33, 1), //BLACK
            textSelectionColor: Color.fromRGBO(198, 237, 44, 1), //GREEN
            accentColor: Color.fromRGBO(198, 237, 44, 1),
            secondaryHeaderColor: Color.fromRGBO(33, 33, 33, 1),
            fontFamily: 'Roboto',
            textTheme: TextTheme(
              headline: TextStyle(
                color: Color.fromRGBO(198, 237, 44, 1),
              ),
              title: TextStyle(
                color: Color.fromRGBO(198, 237, 44, 1),
              ),
              caption: TextStyle(
                color: Color.fromRGBO(198, 237, 44, 1),
              ),
              subtitle: TextStyle(
                color: Colors.grey,
              ),
            )),
        routes: {
          "/": (BuildContext context) {
            return WelcomePage();
          },
        },
      ),
    );
  }
}
