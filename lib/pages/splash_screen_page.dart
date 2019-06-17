import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:scoped_model/scoped_model.dart';
import './calendar_page.dart';

import '../scoped_model/main.dart';
import './UnAuthorizedUser/landing_page.dart';

class WelcomePage extends StatelessWidget {
  final String token;
  WelcomePage(this.token);
  Widget build(BuildContext context) {
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
      navigateAfterSeconds: LandingPage(),
      loaderColor: Colors.white,
    );
  }
}
