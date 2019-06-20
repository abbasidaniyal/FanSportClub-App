import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import './calendar_page.dart';
import '../scoped_model/main.dart';
import './UnAuthorizedUser/landing_page.dart';

class WelcomePage extends StatelessWidget {
  final String token;
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  WelcomePage(this.token);
  Widget build(BuildContext context) {
    _firebaseMessaging.requestNotificationPermissions();
    _firebaseMessaging.getToken().then((notificationToken){
      print("Token   " + notificationToken);
    });
    _firebaseMessaging.configure(
      onLaunch: (temp) async {},
      onMessage: (temp) async {},
      onResume: (temp) async {},
    );
    MainModel model = ScopedModel.of(context);
    // model.token;
    return SplashScreen(
      seconds: 2,
      image: Image.asset(
        "assets/logo-fansport.png",
        fit: BoxFit.cover,
        width: MediaQuery.of(context).size.width * 0.80,
      ),
      photoSize: MediaQuery.of(context).size.shortestSide * 0.22,
      imageBackground: AssetImage("assets/splashScreen.jpg"),
      navigateAfterSeconds:
          model.token == null ? LandingPage() : CalendarPage(),
      loaderColor: Colors.white,
    );
  }
}
