import 'package:Fan_Sports/pages/create_update_profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:scoped_model/scoped_model.dart';
import '../calendar_page.dart';

import '../../scoped_model/main.dart';

class SigningPage extends StatefulWidget {
  @override
  _SigningPageState createState() => _SigningPageState();
}

class _SigningPageState extends State<SigningPage> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              "assets/splashScreen.jpg",
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: ListView(
          dragStartBehavior: DragStartBehavior.down,
          primary: false,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.12),
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                      "assets/logo-fansport.png",
                    ),
                    fit: BoxFit.fitHeight),
              ),
            ),
            Container(
              color: Colors.grey.withOpacity(0.5),
              margin: EdgeInsets.only(top: 20, left: 30, right: 30),
              child: TextField(
                controller: username,
                cursorColor: Colors.white,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    labelText: "USERNAME OR EMAIL",
                    labelStyle: TextStyle(color: Colors.white),
                    fillColor: Colors.white,
                    border: OutlineInputBorder()),
              ),
            ),
            Container(
              color: Colors.grey.withOpacity(0.5),
              margin: EdgeInsets.only(top: 20, left: 30, right: 30),
              child: TextField(
                controller: password,
                obscureText: true,
                style: TextStyle(color: Colors.white),
                cursorColor: Colors.white,
                decoration: InputDecoration(
                  labelText: "PASSWORD",
                  labelStyle: TextStyle(color: Colors.white),
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                      //  borderSide: 1,
                      ),
                ),
              ),
            ),
            InkWell(
              child: Container(
                margin: EdgeInsets.only(
                  top: 15,
                  left: 40,
                ),
                child: Text(
                  "Forget Password?",
                  style: TextStyle(
                    color: Colors.white,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              onTap: () {
                //NAVIGATE TO FORGOT PASSWORD PAGE
              },
            ),
            Container(
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.05,
                  left: MediaQuery.of(context).size.width * 0.1,
                  right: MediaQuery.of(context).size.width * 0.1),
              child: Hero(
                tag: 123,
                child: Container(
                  // width: MediaQuery.of(context).size.width * 0.8 + 20,
                  height: MediaQuery.of(context).size.height * 0.07,
                  child: RaisedButton(
                    color: Theme.of(context).accentColor.withOpacity(0.8),
                    child: Text(
                      "LOGIN",
                      textScaleFactor: 1.3,
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      //LOGIN WITH SERVER AND GET TOKEN
                      MainModel model = ScopedModel.of(context);
                      bool status = await model.getLocalAuthToken(
                          username.text, password.text);
                      if (status) {
                        int newUser = await model.initLoggedInUser();
                        if (newUser == 1) {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  title: Text("Login Failed"),
                                  content: Text("Please try again"),
                                  actions: <Widget>[
                                    FlatButton(
                                      child: Text("Ok"),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    )
                                  ],
                                ),
                          );
                        } else if (newUser == 2) {
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) {
                            return ProfileUpdatePage(model.loggedInUser);
                          }));
                        } else {
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) {
                            return CalendarPage();
                          }));
                        }
                      } else {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                title: Text("Login Failed"),
                                content: Text("Please try again"),
                                actions: <Widget>[
                                  FlatButton(
                                    child: Text("Ok"),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  )
                                ],
                              ),
                        );
                      }
                    },
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.05),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width * 0.35,
                    height: MediaQuery.of(context).size.height * 0.07,
                    child: RaisedButton(
                      color: Color.fromRGBO(219, 50, 54, 1),
                      child: Text(
                        "GOOGLE",
                        textScaleFactor: 1.3,
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {
                        MainModel model = ScopedModel.of(context);
                        bool successSignIn = await model.googleSignIn();

                        if (successSignIn) {
                          bool successLogin = await model.serverGoogleOauth();
                          if (successLogin) {
                            bool convertToken =
                                await model.convertGoogleToken();
                            if (convertToken) {
                              int newUser = await model.initLoggedInUser();
                              if (newUser == 1) {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                        title: Text("Login Failed"),
                                        content: Text("Please try again"),
                                        actions: <Widget>[
                                          FlatButton(
                                            child: Text("Ok"),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          )
                                        ],
                                      ),
                                );
                              } else if (newUser == 2) {
                                Navigator.pushReplacement(context,
                                    MaterialPageRoute(builder: (context) {
                                  return ProfileUpdatePage(model.loggedInUser);
                                }));
                              } else {
                                Navigator.pushReplacement(context,
                                    MaterialPageRoute(builder: (context) {
                                  return CalendarPage();
                                }));
                              }
                            } else {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text("Facebook sign in failed"),
                                    content: Text("Please try again"),
                                    actions: <Widget>[
                                      FlatButton(
                                        child: Text("Ok"),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      )
                                    ],
                                  );
                                },
                              );
                            }
                          } else {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                    title: Text("Google sign in failed"),
                                    content: Text("Please try again"),
                                    actions: <Widget>[
                                      FlatButton(
                                        child: Text("Ok"),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      )
                                    ],
                                  ),
                            );
                          }
                        } else {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  title: Text("Google sign in failed"),
                                  content: Text("Please try again"),
                                  actions: <Widget>[
                                    FlatButton(
                                      child: Text("Ok"),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    )
                                  ],
                                ),
                          );
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.1,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.07,
                    width: MediaQuery.of(context).size.width * 0.35,
                    child: RaisedButton(
                      color: Color.fromRGBO(59, 89, 152, 1),
                      child: Text(
                        "FACEBOOK ",
                        textScaleFactor: 1.3,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () async {
                        MainModel model = ScopedModel.of(context);
                        bool successSignin = await model.facebookSignIn();
                        if (successSignin) {
                          bool successLogin = await model.serverFacebookOauth();
                          if (successLogin) {
                            bool convertToken =
                                await model.convertFacebookToken();
                            if (convertToken) {
                              int newUser = await model.initLoggedInUser();
                              if (newUser == 1) {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                        title: Text("Login Failed"),
                                        content: Text("Please try again"),
                                        actions: <Widget>[
                                          FlatButton(
                                            child: Text("Ok"),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          )
                                        ],
                                      ),
                                );
                              } else if (newUser == 2) {
                                Navigator.pushReplacement(context,
                                    MaterialPageRoute(builder: (context) {
                                  return ProfileUpdatePage(model.loggedInUser);
                                }));
                              } else {
                                Navigator.pushReplacement(context,
                                    MaterialPageRoute(builder: (context) {
                                  return CalendarPage();
                                }));
                              }
                            } else {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text("Facebook sign in failed"),
                                    content: Text("Please try again"),
                                    actions: <Widget>[
                                      FlatButton(
                                        child: Text("Ok"),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      )
                                    ],
                                  );
                                },
                              );
                            }
                          } else {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text("Facebook sign in failed"),
                                  content: Text("Please try again"),
                                  actions: <Widget>[
                                    FlatButton(
                                      child: Text("Ok"),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    )
                                  ],
                                );
                              },
                            );
                          }
                        } else {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text("Facebook sign in failed"),
                                content: Text("Please try again"),
                                actions: <Widget>[
                                  FlatButton(
                                    child: Text("Ok"),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  )
                                ],
                              );
                            },
                          );
                        }
                      },
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
