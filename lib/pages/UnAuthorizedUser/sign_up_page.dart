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
                margin: EdgeInsets.only(top: 20, left: 30, right: 30),
                child: TextField(
                  controller: username,
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
                          )),
                ),
              ),
                            Container(
                margin: EdgeInsets.only(top: 20, left: 30, right: 30),
                child: TextField(
                  controller: password,
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
                    onPressed: () {},
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
                        onPressed: () {},
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
                        onPressed: () {},
                      ),
                    )
                  ],
                ),
              )
            ],
          )),
    );
  }
}
