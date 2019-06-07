import 'package:flutter/material.dart';

import '../models/user_profile.dart';

import 'package:intl/intl.dart';

class PlayerProfilePage extends StatelessWidget {
  UserProfile user;
  int index;

  PlayerProfilePage(this.user, this.index);
  @override
  Widget build(BuildContext context) {
    double nameSize = MediaQuery.of(context).size.width * 0.05;
    double dobSize = MediaQuery.of(context).size.width * 0.04;
    double headingSize = MediaQuery.of(context).size.width * 0.04;
    double contentSize = MediaQuery.of(context).size.width * 0.04;

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: Text(
            "Player Profile",
            textScaleFactor: 1,
            style: TextStyle(fontWeight: FontWeight.normal, fontSize: 20),
            textAlign: TextAlign.left,
          ),
        ),
        body: ListView(
          children: <Widget>[
            Container(
              child: Stack(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.all(0),
                    // color: Theme.of(context).primaryColor,
                    width: MediaQuery.of(context).size.width,
                    alignment: Alignment.topCenter,
                    // height: MediaQuery.of(context).size.height * 0.40,
                    child: Image(
                      image: AssetImage("assets/playerBackground.jpg"),
                      width: MediaQuery.of(context).size.width,
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.40,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.50,
                              top: 35.0),
                          child: Text(
                            user.name,
                            textScaleFactor: 1,
                            maxLines: 1,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: nameSize),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.50,
                              top: 10.0),
                          child: Text(
                            DateFormat("dd/MM/yyy")
                                .format(DateTime.parse(user.dob)),
                            maxLines: 1,
                            textScaleFactor: 1,
                            style: TextStyle(
                                color: Colors.white, fontSize: dobSize),
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            Container(
                              width: MediaQuery.of(context).size.width * 0.2,
                              margin: EdgeInsets.only(
                                  left:
                                      MediaQuery.of(context).size.width * 0.50,
                                  top: 20.0),
                              child: Text(
                                "GENDER",
                                textScaleFactor: 1,
                                maxLines: 1,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: headingSize),
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.2,
                              margin: EdgeInsets.only(left: 30.0, top: 20.0),
                              child: Text(
                                "AGE",
                                textScaleFactor: 1,
                                maxLines: 1,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: headingSize),
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Container(
                              width: MediaQuery.of(context).size.width * 0.2,
                              margin: EdgeInsets.only(
                                  left:
                                      MediaQuery.of(context).size.width * 0.50,
                                  top: 5.0),
                              child: Text(
                                "Male",
                                textScaleFactor: 1,
                                maxLines: 1,
                                style: TextStyle(
                                    color: Colors.white, fontSize: contentSize),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 30.0, top: 5.0),
                              width: MediaQuery.of(context).size.width * 0.2,
                              child: Text(
                                ((DateTime.now()
                                            .difference(
                                                DateTime.parse(user.dob))
                                            .inDays) /
                                        365)
                                    .floor()
                                    .toString(),
                                textScaleFactor: 1,
                                style: TextStyle(
                                    color: Colors.white, fontSize: contentSize),
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(
                                  left:
                                      MediaQuery.of(context).size.width * 0.05,
                                  top: 30),
                              width: MediaQuery.of(context).size.width * 0.4,
                              child: Text(
                                "BACKHAND STYLE",
                                textScaleFactor: 1,
                                maxLines: 1,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: headingSize),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                  left:
                                      MediaQuery.of(context).size.width * 0.05,
                                  top: 30),
                              width: MediaQuery.of(context).size.width * 0.4,
                              child: Text(
                                "STRONG HAND",
                                maxLines: 1,
                                textScaleFactor: 1,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: headingSize),
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(
                                  left:
                                      MediaQuery.of(context).size.width * 0.05,
                                  top: 5),
                              width: MediaQuery.of(context).size.width * 0.4,
                              child: Text(
                                user.backhandStyle,
                                textScaleFactor: 1,
                                maxLines: 1,
                                style: TextStyle(
                                    color: Colors.white, fontSize: contentSize),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                  left:
                                      MediaQuery.of(context).size.width * 0.05,
                                  top: 5),
                              width: MediaQuery.of(context).size.width * 0.4,
                              child: Text(
                                user.strongHand,
                                textScaleFactor: 1,
                                maxLines: 1,
                                style: TextStyle(
                                    color: Colors.white, fontSize: contentSize),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Hero(
                    tag: index,
                                      child: Container(
                      width: MediaQuery.of(context).size.width * 0.35,
                      height: MediaQuery.of(context).size.width * 0.35,
                      margin: EdgeInsets.only(top: 25, left: 20.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100.0),
                          color: Theme.of(context).primaryColor),
                      foregroundDecoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 3.0),
                        borderRadius: BorderRadius.circular(100.0),
                        image: DecorationImage(
                          image: user.profilePhotoUrl != null
                              ? NetworkImage(user.profilePhotoUrl)
                              : AssetImage("assets/profilePicture.jpeg"),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              color: Colors.white,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.45,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(2.0),
                ),
                margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(left: 15.0, top: 10.0),
                      child: Text(
                        "Player Info",
                        textScaleFactor: 1,
                        style: TextStyle(
                            fontWeight: FontWeight.values[5], fontSize: 17),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20.0, left: 15.0),
                      child: Text(
                        "City",
                        textScaleFactor: 1,
                        style: TextStyle(color: Colors.grey[500]),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5.0, left: 15.0),
                      child: Text(
                        user.city,
                        textScaleFactor: 1,
                        style: TextStyle(fontWeight: FontWeight.values[0]),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 15.0, left: 15.0),
                      child: Text(
                        "Home ground/Club",
                        textScaleFactor: 1,
                        style: TextStyle(color: Colors.grey[500]),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5.0, left: 15.0),
                      child: Text(
                        user.homeClub,
                        textScaleFactor: 1,
                        style: TextStyle(fontWeight: FontWeight.values[0]),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 15.0, left: 15.0),
                      child: Text(
                        "Role Model/Favorite Player",
                        textScaleFactor: 1,
                        style: TextStyle(color: Colors.grey[500]),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5.0, left: 15.0),
                      child: Text(
                        user.roleModel,
                        textScaleFactor: 1,
                        style: TextStyle(fontWeight: FontWeight.values[0]),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 15.0, left: 15.0),
                      child: Text(
                        "Achievements",
                        textScaleFactor: 1,
                        style: TextStyle(color: Colors.grey[500]),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5.0, left: 15.0),
                      child: Text(
                        user.achievements,
                        textScaleFactor: 1,
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
