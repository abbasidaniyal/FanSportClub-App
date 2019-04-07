import 'package:flutter/material.dart';

import '../models/user_profile.dart';

class PlayerProfilePage extends StatelessWidget {
  UserProfile user;
  // TO BE MADEEEEEEEE
  PlayerProfilePage(this.user);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: Text(
            "Player Profile",
            style: TextStyle(fontWeight: FontWeight.values[6]),
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
                        margin: EdgeInsets.only(left: 200.0, top: 35.0),
                        child: Text(
                          user.fullname(),
                          textScaleFactor: 1.7,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
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
                            margin: EdgeInsets.only(left: 50.0, top: 20.0),
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
                            margin: EdgeInsets.only(left: 80.0, top: 5.0),
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
                            margin: EdgeInsets.only(left: 40, top: 30),
                            child: Text(
                              "BACKHAND STYLE",
                              textScaleFactor: 1.3,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 50, top: 30),
                            child: Text(
                              "STRONG HAND",
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
                            margin: EdgeInsets.only(left: 40, top: 5.0),
                            width: MediaQuery.of(context).size.width*0.2  ,
                            child: Text(
                              user.backhandStyle,
                              textScaleFactor: 1.3,
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 120, top: 5.0),
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
                  margin: EdgeInsets.only(top: 25, left: 20.0),
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
                height: MediaQuery.of(context).size.height * 0.45,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2),
                    border: Border.all(color: Colors.grey[200], width: 1.5)),
                margin: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(left: 15.0, top: 15.0),
                      child: Text(
                        "Player Info",
                        textScaleFactor: 1.2,
                        style: TextStyle(fontWeight: FontWeight.values[5]),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20.0, left: 15.0),
                      child: Text(
                        "City",
                        textScaleFactor: 1.2,
                        style: TextStyle(color: Colors.grey[500]),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5.0, left: 15.0),
                      child: Text(
                        user.city,
                        textScaleFactor: 1.2,
                        style: TextStyle(fontWeight: FontWeight.values[0]),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 15.0, left: 15.0),
                      child: Text(
                        "Home ground/Club",
                        textScaleFactor: 1.2,
                        style: TextStyle(color: Colors.grey[500]),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5.0, left: 15.0),
                      child: Text(
                        user.homeClub,
                        textScaleFactor: 1.2,
                        style: TextStyle(fontWeight: FontWeight.values[0]),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 15.0, left: 15.0),
                      child: Text(
                        "Role Model/Favorite Player",
                        textScaleFactor: 1.2,
                        style: TextStyle(color: Colors.grey[500]),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5.0, left: 15.0),
                      child: Text(
                        user.roleModel,
                        textScaleFactor: 1.2,
                        style: TextStyle(fontWeight: FontWeight.values[0]),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 15.0, left: 15.0),
                      child: Text(
                        "Achievements",
                        textScaleFactor: 1.2,
                        style: TextStyle(color: Colors.grey[500]),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5.0, left: 15.0),
                      child: Text(
                        user.achievements ,
                        textScaleFactor: 1.2,
                        style: TextStyle(fontWeight: FontWeight.values[0]),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
