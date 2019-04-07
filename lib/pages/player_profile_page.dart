import 'package:flutter/material.dart';

import '../models/user_profile.dart';

class PlayerProfilePage extends StatelessWidget {
  UserProfile user;
  // TO BE MADEEEEEEEE
  PlayerProfilePage(this.user);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).accentColor,
          title: Text(
            "Player Profile",
            style: TextStyle(fontWeight: FontWeight.w900),
            textScaleFactor: 1.2,
          ),
        ),
        body: ListView(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.all(0),
                  width: MediaQuery.of(context).size.width,
                  child: Image(
                    image: AssetImage("assets/playerBackground.png"),
                  ),
                ),
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(left: 200.0, top: 40.0),
                        child: Text(
                          user.fullname(),
                          textScaleFactor: 1.7,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 200.0, top: 10.0),
                        child: Text(
                          user.dob,
                          style: TextStyle(color: Colors.white),
                          textScaleFactor: 1.2,
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(left: 200.0, top: 20.0),
                            child: Text(
                              "GENDER",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                              textScaleFactor: 1.3,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 40.0, top: 20.0),
                            child: Text(
                              "AGE",
                              textScaleFactor: 1.3,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(left: 200.0, top: 5.0),
                            child: Text(
                              "Male",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                              textScaleFactor: 1.3,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 75.0, top: 5.0),
                            child: Text(
                              "21",
                              textScaleFactor: 1.3,
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(left: 40, top: 50),
                            child: Text(
                              "BACKHAND STYLE",
                              textScaleFactor: 1.3,
                              style: TextStyle(
                                  color: Color.fromRGBO(245, 245, 245, 1),
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 50, top: 50),
                            child: Text(
                              "STRONG HAND",
                              textScaleFactor: 1.3,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(left: 40, top: 5.0),
                            child: Text(
                              user.backhandStyle,
                              textScaleFactor: 1.3,
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 145, top: 5.0),
                            child: Text(
                              user.strongHand,
                              textScaleFactor: 1.3,
                              style: TextStyle(color: Colors.white),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 140.0,
                  height: 140.0,
                  margin: EdgeInsets.only(top: 30, left: 20.0),
                  foregroundDecoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 3.0),
                    borderRadius: BorderRadius.circular(100.0),
                    image: DecorationImage(
                      image: AssetImage("assets/player-profile.jpg"),
                    ),
                  ),
                )
              ],
            ),
            Container(
              child: Container(
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 1.0,
                  ),
                ]),
                margin: EdgeInsets.all(5.0),
                child: Column(
                  children: <Widget>[
                    Text("DATA"),
                    Text("DATA"),
                    Text("DATA"),
                    Text("DATA"),
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
