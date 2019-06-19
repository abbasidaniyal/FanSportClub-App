import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:scoped_model/scoped_model.dart';
import '../calendar_page.dart';

import '../../scoped_model/main.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  GlobalKey<FormState> _key = GlobalKey<FormState>();

  Widget build(BuildContext context) {
    MainModel model = ScopedModel.of(context);
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
          child: Form(
            key: _key,
            child: Column(
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
                  child: TextFormField(
                    controller: emailController,
                    cursorColor: Colors.white,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                        labelText: "EMAIL",
                        labelStyle: TextStyle(color: Colors.white),
                        fillColor: Colors.white,
                        border: OutlineInputBorder()),
                  ),
                ),
                Container(
                  color: Colors.grey.withOpacity(0.5),
                  margin: EdgeInsets.only(top: 20, left: 30, right: 30),
                  child: TextFormField(
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
                            )),
                  ),
                ),
                Container(
                  color: Colors.grey.withOpacity(0.5),
                  margin: EdgeInsets.only(top: 20, left: 30, right: 30),
                  child: TextFormField(
                    controller: confirmPassword,
                    obscureText: true,
                    style: TextStyle(color: Colors.white),
                    cursorColor: Colors.white,
                    decoration: InputDecoration(
                        labelText: "CONFIRM PASSWORD",
                        labelStyle: TextStyle(color: Colors.white),
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                            //  borderSide: 1,
                            )),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.05,
                      left: MediaQuery.of(context).size.width * 0.1,
                      right: MediaQuery.of(context).size.width * 0.1),
                  child: Container(
                    // width: MediaQuery.of(context).size.width * 0.8 + 20,
                    height: MediaQuery.of(context).size.height * 0.07,
                    child: RaisedButton(
                      color: Theme.of(context).accentColor.withOpacity(0.8),
                      child: Text(
                        "SIGN UP",
                        textScaleFactor: 1.3,
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        if (password.text == confirmPassword.text &&
                            RegExp(r"^[a-zA-Z0-9._+-]+@[a-zA-Z0-9-]+\.[a-zA-Z]+")
                                .hasMatch(emailController.text) &&
                            _key.currentState.validate()) {
                          _key.currentState.save();
                          //CALL models.localsignup()
                        }
                      },
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
                              bool successLogin =
                                  await model.serverGoogleOauth();
                              if (successLogin) {
                                bool convertToken =
                                    await model.convertGoogleToken();
                                if (convertToken) {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return CalendarPage();
                                      },
                                    ),
                                  );
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

                                Navigator.pushReplacement(context,
                                    MaterialPageRoute(builder: (context) {
                                  return CalendarPage();
                                }));
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
                            bool successSignin = await model.facebookSignIn();
                            if (successSignin) {
                              bool successLogin =
                                  await model.serverFacebookOauth();
                              if (successLogin) {
                                bool convertToken =
                                    await model.convertFacebookToken();
                                if (convertToken) {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return CalendarPage();
                                      },
                                    ),
                                  );
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
          )),
    );
  }
}
