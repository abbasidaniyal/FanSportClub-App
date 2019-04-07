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
          image: Image.asset("assets/logo.png",fit: BoxFit.cover),
          photoSize: 60.0,
          backgroundColor: Theme.of(context).primaryColor,
          navigateAfterSeconds: CalendarPage(),
          loadingText: Text("Welcome",style: TextStyle(color: Colors.white),),
          loaderColor: Colors.white,
          title: Text(
            "Fan Sports Club",
            style: TextStyle(color: Colors.white),
            textScaleFactor: 2,
          ),
        );
      },
    );
  }
}
