import 'package:Fan_Sports/pages/UnAuthorizedUser/sign_in_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:scoped_model/scoped_model.dart';
import '../calendar_page.dart';

import '../../scoped_model/main.dart';
import '../create_update_profile.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  GlobalKey<FormState> _key = GlobalKey<FormState>();
  bool _obsceuretext = true;
  bool isLoading = false;

  Map<String, String> userData = {};

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
            child: ListView(
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
                    onSaved: (text) {
                      userData["email"] = text;
                      userData["username"] = text;
                      // userData["profile"] = [""] as String;
                    },
                    validator: (email) {
                      if (!RegExp(r"^[a-zA-Z0-9._+-]+@[a-zA-Z0-9-]+\.[a-zA-Z]+")
                          .hasMatch(email)) {
                        return "Invalid Email";
                      }
                    },
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
                  child: Row(
                    children: <Widget>[
                      Flexible(
                        child: TextFormField(
                          controller: password,
                          obscureText: _obsceuretext,
                          style: TextStyle(color: Colors.white),
                          cursorColor: Colors.white,
                          onSaved: (text) {
                            userData["password"] = text;
                          },
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
                        width: 50.0,
                        child: IconButton(
                          icon: _obsceuretext
                              ? Icon(Icons.visibility)
                              : Icon(Icons.visibility_off),
                          onPressed: () {
                            setState(() {
                              _obsceuretext = !_obsceuretext;
                            });
                          },
                        ),
                      )
                    ],
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
                    validator: (confirm) {
                      if (password.text != confirm)
                        return "Passwords do not match";
                    },
                    decoration: InputDecoration(
                      labelText: "CONFIRM PASSWORD",
                      labelStyle: TextStyle(color: Colors.white),
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          //  borderSide: 1,
                          ),
                    ),
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
                      child: isLoading
                          ? CircularProgressIndicator()
                          : Text(
                              "SIGN UP",
                              textScaleFactor: 1.3,
                              style: TextStyle(color: Colors.white),
                            ),
                      onPressed: () async {
                        setState(() {
                          isLoading = true;
                        });
                        print("WOEKING 1");
                        if (_key.currentState.validate()) {
                          print("TRUE");
                          _key.currentState.save();
                          bool success = await model.newUser(userData);
                          if (success) {
                            Navigator.pop(context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return SigningPage();
                                },
                              ),
                            );
                          } else {
                            setState(() {
                              isLoading = false;
                            });
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text(
                                      "Either email address already exists or Invalid credentials"),
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
                        }
                        setState(() {
                          isLoading = false;
                        });
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
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return ProfileUpdatePage(
                                              model.loggedInUser);
                                        },
                                      ),
                                    );
                                  } else {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return CalendarPage();
                                        },
                                      ),
                                    );
                                  }
                                } else {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
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
                              bool successLogin =
                                  await model.serverFacebookOauth();
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
                                      return ProfileUpdatePage(
                                          model.loggedInUser);
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
          )),
    );
  }
}
