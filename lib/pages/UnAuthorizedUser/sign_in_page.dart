import 'package:Fan_Sports/pages/create_update_profile.dart';
import 'package:Fan_Sports/scoped_model/baseUrl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:url_launcher/url_launcher.dart';
import '../calendar_page.dart';

import 'package:flutter_signin_button/flutter_signin_button.dart';

import '../../scoped_model/main.dart';

class SigningPage extends StatefulWidget {
  @override
  _SigningPageState createState() => _SigningPageState();
}

class _SigningPageState extends State<SigningPage> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  bool _obsceuretext = true;
  bool isLoading = false;
  @override
  void setState(Function fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

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
                top: MediaQuery.of(context).size.height * 0.12,
              ),
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
              //       //                   <--- left side
              //       color: Colors.white.withOpacity(0.5),
              //       width: 1.5,
              //     ),
              //   ),
              // ),
              margin: EdgeInsets.only(top: 20, left: 30, right: 30),
              child: TextField(
                controller: username,
                cursorColor: Colors.white,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: "USERNAME OR EMAIL",
                  // hasFloatingPlaceholder: false,
                  labelStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                  filled: true,
                  focusedBorder: InputBorder.none,
                  fillColor: Colors.grey.withOpacity(0.5),
                  // fillColor: Colors.white,
                  border: OutlineInputBorder(),

                  // border: OutlineInputBorder(),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10, left: 30, right: 30),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: password,
                      obscureText: _obsceuretext,
                      style: TextStyle(color: Colors.white),
                      cursorColor: Colors.white,
                      decoration: InputDecoration(
                        labelText: "PASSWORD",
                        filled: true,

                        disabledBorder: InputBorder.none,
                        focusedErrorBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        labelStyle:
                            TextStyle(color: Colors.white, fontSize: 14),
                        // border: Do,
                        border: InputBorder.none,
                        // focusedBorder: OutlineInputBorder(),
                        fillColor: Colors.grey.withOpacity(0.5),

                        // fillColor: Colors.white,
                      ),
                    ),
                  ),
                  Container(
                    color: Colors.grey.withOpacity(0.5),
                    height: 57.0,
                    child: VerticalDivider(
                      
                      color: Colors.grey,
                      
                      indent: 5,
                      endIndent: 5,
                      // height: 20.0,
                    ),
                  ),
                  Container(
                    // margin: EdgeInsets.only(top: 10),
                    height: 57.0,

                    color: Colors.grey.withOpacity(0.5),
                    child: IconButton(
                      // padding: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.75),
                      // alignment: Alignment(1,0.5),
                      icon: _obsceuretext
                          ? Icon(
                              Icons.visibility,
                              color: Colors.grey,
                              // size: 25,
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
            InkWell(
              child: Container(
                margin: EdgeInsets.only(
                  top: 20,
                  left: 31,
                ),
                child: Text(
                  "Forgot Password?",
                  style: TextStyle(
                    color: Colors.white,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              onTap: () async {
                await launch("$baseUrl/users/password/password_reset/");
              },
            ),
            Container(
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.05,
                  left: MediaQuery.of(context).size.width * 0.2,
                  right: MediaQuery.of(context).size.width * 0.2),
              child: Container(
                // width: MediaQuery.of(context).size.width * 0.8 + 20,
                height: MediaQuery.of(context).size.height * 0.065,
                decoration: BoxDecoration(
                    boxShadow: [BoxShadow(color: Colors.transparent)]),
                child: FlatButton(
                  highlightColor: Colors.transparent,
                  color: Theme.of(context).accentColor.withOpacity(1),
                  child: isLoading
                      ? CircularProgressIndicator(
                          backgroundColor: Colors.white,
                        )
                      : Text(
                          "LOGIN",
                          textScaleFactor: 1.3,
                          style: TextStyle(color: Color.fromRGBO(48, 48, 48, 1)),
                        ),
                  onPressed: isLoading == true
                      ? () {}
                      : () async {
                          setState(() {
                            isLoading = true;
                          });
                          //LOGIN WITH SERVER AND GET TOKEN
                          MainModel model = ScopedModel.of(context);
                          bool status = await model.getLocalAuthToken(
                              username.text, password.text);
                          if (status) {
                            int newUser = await model.initLoggedInUser();
                            if (newUser == 1) {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    setState(() {
                                      isLoading = false;
                                    });
                                    return AlertDialog(
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
                                    );
                                  }).then((onValue) {
                                setState(() {
                                  isLoading = false;
                                });
                              });
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
                                // setState(() {
                                //   isLoading = false;
                                // });
                                return AlertDialog(
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
                                );
                              },
                            ).then((onValue) {
                              setState(() {
                                isLoading = false;
                              });
                            });
                          }
                        },
                ),
              ),
            ),

            Container(
              // width: MediaQuery.of(context).size.width * 0.35,
              height: MediaQuery.of(context).size.height * 0.065,
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.02,
                  left: MediaQuery.of(context).size.width * 0.2,
                  right: MediaQuery.of(context).size.width * 0.2),

              child: SignInButton(
                Buttons.Google,

                // mini: true,
                // text: "Google",
                onPressed: isLoading == true
                    ? () {}
                    : () async {
                        setState(() {
                          isLoading = true;
                        });
                        MainModel model = ScopedModel.of(context);
                        bool successSignIn = await model.googleSignIn();
                        print("GOOGLE SIGN IN : $successSignIn");
                        if (successSignIn) {
                          bool successLogin = await model.serverGoogleOauth();
                          print("SERVER OAUTH : $successLogin");
                          if (successLogin) {
                            bool convertToken =
                                await model.convertGoogleToken();
                            print("CONVERT TOKEN : $convertToken");
                            if (convertToken) {
                              int newUser = await model.initLoggedInUser();
                              print("INIT LOGGED : $newUser");
                              if (newUser == 1) {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      setState(() {
                                        isLoading = false;
                                      });
                                      return AlertDialog(
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
                                      );
                                    }).then((onValue) {
                                  setState(() {
                                    isLoading = false;
                                  });
                                });
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
                              ).then((onValue) {
                                setState(() {
                                  isLoading = false;
                                });
                              });
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
                                }).then((onValue) {
                              setState(() {
                                isLoading = false;
                              });
                            });
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
                              }).then(
                            (w) {
                              setState(
                                () {
                                  isLoading = false;
                                },
                              );
                            },
                          );
                        }
                      },
              ),
            ),
            // SizedBox(
            //   width: MediaQuery.of(context).size.width * 0.2,
            // ),
            Container(
              height: MediaQuery.of(context).size.height * 0.065,
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.02,
                  left: MediaQuery.of(context).size.width * 0.2,
                  right: MediaQuery.of(context).size.width * 0.2),

              // width: MediaQuery.of(context).size.width * 0.35,
              child: SignInButton(
                Buttons.Facebook,
                // text: "Facebook",
                onPressed: isLoading == true
                    ? () {}
                    : () async {
                        setState(() {
                          isLoading = true;
                        });
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
                                    builder: (context) {
                                      // setState(() {
                                      //   isLoading = false;
                                      // });
                                      return AlertDialog(
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
                                      );
                                    }).then((onValue) {
                                  setState(() {
                                    isLoading = false;
                                  });
                                });
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
                                  // setState(() {
                                  //   isLoading = false;
                                  // });
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
                              ).then((onValue) {
                                setState(() {
                                  isLoading = false;
                                });
                              });
                            }
                          } else {
                            showDialog(
                              context: context,
                              builder: (context) {
                                // setState(() {
                                //   isLoading = false;
                                // });
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
                            ).then((onValue) {
                              setState(() {
                                isLoading = false;
                              });
                            });
                          }
                        } else {
                          showDialog(
                            context: context,
                            builder: (context) {
                              // setState(() {
                              //   isLoading = false;
                              // });
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
                          ).then((onValue) {
                            setState(() {
                              isLoading = false;
                            });
                          });
                        }
                      },
              ),
            )
          ],
        ),
      ),
    );
  }
}
