import 'package:Fan_Sports/pages/UnAuthorizedUser/sign_in_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:scoped_model/scoped_model.dart';
import '../calendar_page.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

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

  @override
  void setState(Function fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

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
              dragStartBehavior: DragStartBehavior.down,
              primary: false,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.12),
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                          "assets/logo-fansport.png",
                        ),
                        fit: BoxFit.fitHeight),
                  ),
                ),
                Container(
                  // decoration: BoxDecoration(
                  //   border: Border(
                  //     bottom: BorderSide(
                  //       color: Colors.white.withOpacity(0.5),
                  //       width: 1.5,
                  //     ),
                  //   ),
                  // ),
                  height: MediaQuery.of(context).size.height * 0.07,
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.02,
                      left: MediaQuery.of(context).size.width * 0.1,
                      right: MediaQuery.of(context).size.width * 0.1),
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
                      labelStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                      disabledBorder: InputBorder.none,
                      focusedErrorBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      // border: Do,
                      border: InputBorder.none,
                      // focusedBorder: OutlineInputBorder(),
                      fillColor: Colors.grey.withOpacity(0.5),
                      filled: true,
                      focusedBorder: InputBorder.none,
                      // fillColor: Colors.grey.withOpacity(0.5),
                      // fillColor: Colors.white,
                      // border: OutlineInputBorder(),

                      // border: OutlineInputBorder(),
                    ),
                  ),
                ),
                Container(
                  // decoration: BoxDecoration(
                  //   border: Border(
                  //     bottom: BorderSide(
                  //       color: Colors.white.withOpacity(0.5),
                  //       width: 1.5,
                  //     ),
                  //   ),
                  // ),
                  // color: Colors.grey.withOpacity(0.5),
                  height: MediaQuery.of(context).size.height * 0.07,
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.02,
                      left: MediaQuery.of(context).size.width * 0.1,
                      right: MediaQuery.of(context).size.width * 0.1),
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
                            filled: true,

                            disabledBorder: InputBorder.none,
                            focusedErrorBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            labelStyle:
                                TextStyle(color: Colors.white, fontSize: 12),
                            // border: Do,
                            border: InputBorder.none,
                            // focusedBorder: OutlineInputBorder(),
                            fillColor: Colors.grey.withOpacity(0.5),
                          ),
                        ),
                      ),
                      Container(
                        // width: 50.0,
                        height: 57.0,
                        color: Colors.grey.withOpacity(0.5),

                        child: IconButton(
                          icon: _obsceuretext
                              ? Icon(
                                  Icons.visibility,
                                  color: Colors.grey,
                                )
                              : Icon(Icons.visibility_off, color: Colors.grey),
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
                  height: MediaQuery.of(context).size.height * 0.07,
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.02,
                      left: MediaQuery.of(context).size.width * 0.1,
                      right: MediaQuery.of(context).size.width * 0.1),
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
                      filled: true,

                      disabledBorder: InputBorder.none,
                      focusedErrorBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      labelStyle: TextStyle(color: Colors.white, fontSize: 12),
                      // border: Do,
                      border: InputBorder.none,
                      // focusedBorder: OutlineInputBorder(),
                      fillColor: Colors.grey.withOpacity(0.5),
                    ),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.07,
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.03,
                      left: MediaQuery.of(context).size.width * 0.1,
                      right: MediaQuery.of(context).size.width * 0.1),
                  child: RaisedButton(
                    color: Theme.of(context).accentColor,
                    child: isLoading
                        ? CircularProgressIndicator()
                        : Text(
                            "SIGN UP",
                            textScaleFactor: 1.2,
                            style:
                                TextStyle(color: Color.fromRGBO(48, 48, 48, 1)),
                          ),
                    onPressed: isLoading
                        ? () {}
                        : () async {
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
                Container(
                  // width: MediaQuery.of(context).size.width * 0.35,
                  height: MediaQuery.of(context).size.height * 0.07,
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.02,
                      left: MediaQuery.of(context).size.width * 0.1,
                      right: MediaQuery.of(context).size.width * 0.1),
                  child: MaterialButton(
                    // child: ,
                    color: Color(0xFFDD4B39),
                    // child: ,
                    child: Center(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            FontAwesomeIcons.google,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Sign in with Google",
                            textScaleFactor: 1.2,
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),

                    // mini: true,
                    // text: "Google",
                    onPressed: isLoading
                        ? () {}
                        : () async {
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
                    // width: MediaQuery.of(context).size.width * 0.35,
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.02,
                        left: MediaQuery.of(context).size.width * 0.1,
                        right: MediaQuery.of(context).size.width * 0.1),
                    child: MaterialButton(
                      // child: ,
                      color: Color(0xFF3B5998),
                      // child: ,
                      child: Center(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              FontAwesomeIcons.facebookF,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Sign in with Facebook",
                              textScaleFactor: 1.2,
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),

                      // mini: true,
                      // text: "Facebook",
                      onPressed: isLoading
                          ? () {}
                          : () async {
                              MainModel model = ScopedModel.of(context);
                              bool successSignin = await model.facebookSignIn();
                              if (successSignin) {
                                bool successLogin =
                                    await model.serverFacebookOauth();
                                if (successLogin) {
                                  bool convertToken =
                                      await model.convertFacebookToken();
                                  if (convertToken) {
                                    int newUser =
                                        await model.initLoggedInUser();
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
                                          title:
                                              Text("Facebook sign in failed"),
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
                    ))
              ],
            ),
          )),
    );
  }
}
