import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:scoped_model/scoped_model.dart';
import './calendar_page.dart';

import '../scoped_model/main.dart';

class WelcomePage extends StatelessWidget {
  Widget build(BuildContext context) {
    return ScopedModelDescendant(
      builder: (BuildContext context, Widget child, MainModel model) {
        return SplashScreen(
          seconds: 2,
          image: Image.asset(
            "assets/logo-fansport.png",
            fit: BoxFit.cover,
            width: MediaQuery.of(context).size.width * 0.80,
          ),
          photoSize: MediaQuery.of(context).size.shortestSide*0.22,
          imageBackground: AssetImage("assets/splashScreen.jpg"),
          navigateAfterSeconds: CalendarPage(), 
          loaderColor: Colors.white,
        );
      },
    );
  }
}
