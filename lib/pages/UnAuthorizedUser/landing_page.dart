import 'dart:ui' as prefix0;

import 'package:Fan_Sports/pages/UnAuthorizedUser/sign_in_page.dart';
import 'package:Fan_Sports/pages/UnAuthorizedUser/sign_up_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:scoped_model/scoped_model.dart';
import '../calendar_page.dart';

import '../../scoped_model/main.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: ExactAssetImage("assets/splashScreen.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.15),
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                        "assets/logo-fansport.png",
                      ),
                      fit: BoxFit.cover),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Hero(
                      tag: 123,
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.40,
                        height: MediaQuery.of(context).size.height * 0.07,
                        child: RaisedButton(
                          color: Theme.of(context).accentColor.withOpacity(0.8),
                          child: Text(
                            "LOGIN",
                            textScaleFactor: 1.3,
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder: (context, a, b) {
                                  return SigningPage();
                                },
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20.0,
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.07,
                      width: MediaQuery.of(context).size.width * 0.40,
                      child: RaisedButton(
                        color: Colors.grey,
                        child: Text(
                          "NEW USER",
                          textScaleFactor: 1.3,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (context, a, b) {
                                return SignupPage();
                              },
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 30),
                child: InkWell(
                  child: Text(
                    "Continue Without Login",
                    style: TextStyle(
                        color: Colors.white,
                        decoration: TextDecoration.underline,
                        fontSize: 15),
                  ),
                  onTap: () async{
                    MainModel model = ScopedModel.of(context);
                    await model.getGeneralToken("fsc", "fsc");
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) {
                      return CalendarPage();
                    }));
                  },
                ),
              )
            ],
          )),
    );

    // return SplashScreen(
    //       seconds: 2,
    //       image: Image.asset(
    //         "assets/logo-fansport.png",
    //         fit: BoxFit.cover,
    //         width: MediaQuery.of(context).size.width * 0.80,
    //       ),
    //       photoSize: MediaQuery.of(context).size.shortestSide*0.22,
    //       imageBackground: AssetImage("assets/splashScreen.jpg"),
    //       navigateAfterSeconds: CalendarPage(),
    //       loaderColor: Colors.white,
    //     );
  }
}
