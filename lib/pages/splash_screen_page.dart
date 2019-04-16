import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;
import './calendar_page.dart';

import '../scoped_model/main.dart';

class WelcomePage extends StatelessWidget {
  Widget build(BuildContext context) {
    return ScopedModelDescendant(
      builder: (BuildContext context, Widget child, MainModel model) {
        model.getToken();
        return SplashScreen(
          seconds: 3,
          image: Image.asset(
            "assets/logo.png",
            fit: BoxFit.cover,
            width: MediaQuery.of(context).size.width * 0.80,
          ),
          photoSize: 80.0,
          imageBackground: AssetImage("assets/splashScreen.jpg"),
          navigateAfterSeconds: CalendarPage(), 
          loaderColor: Colors.white,
        );
      },
    );
  }
}
