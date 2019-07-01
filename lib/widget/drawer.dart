import 'package:Fan_Sports/pages/UnAuthorizedUser/landing_page.dart';
import 'package:Fan_Sports/pages/create_update_profile.dart';
import 'package:Fan_Sports/pages/player_profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:scoped_model/scoped_model.dart';

import '../pages/about_us_page.dart';

import '../pages/ipin_page.dart';
import '../pages/calendar_page.dart';
import '../pages/cien_form_page.dart';
import '../pages/itf_ranking_page.dart';
import '../scoped_model/main.dart';
import '../pages/gallery_page.dart';
import '../pages/player_search.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    MainModel model = ScopedModel.of(context);
    return Drawer(
      child: Container(
        padding: EdgeInsets.only(left: 20.0, top: 10),
        color: Theme.of(context).primaryColor,
        child: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (overscroll) {
            overscroll.disallowGlow();
            
          },
          child: ListView(
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                  if (model.isUserSignedIn) {
                    Navigator.push(context,
                        CupertinoPageRoute(builder: (BuildContext context) {
                      return PlayerProfilePage(model.loggedInUser);
                    }));
                  } else {
                    Navigator.pushReplacement(context,
                        CupertinoPageRoute(builder: (BuildContext context) {
                      return CalendarPage();
                    }));
                  }
                },
                child: Container(
                  // margin: EdgeInsets.all(3.0),
                  // height: 200.0,
                  // width: MediaQuery.of(context).size.width * 0.25,
                  height: MediaQuery.of(context).size.width * 0.25,
                  padding: EdgeInsets.only(
                      left: 25, top: 12.0, bottom: 12.0, right: 180),
                  child: !model.isUserSignedIn
                      ? Image.asset(
                          "assets/logo-fsc.png",
                          alignment: Alignment.center,
                        )
                      : Container(
                          // alignment: Alignment(-1, 0),
                          width: MediaQuery.of(context).size.width * 0.40,
                          height: MediaQuery.of(context).size.width * 0.40,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(500.0),
                              color: Theme.of(context).primaryColor),
                          foregroundDecoration: BoxDecoration(
                            border: Border.all(
                                color: Theme.of(context).accentColor, width: 2),
                            borderRadius: BorderRadius.circular(100.0),
                            image: DecorationImage(
                              image: model.isUserSignedIn &&
                                      model.loggedInUser.profilePhotoUrl != null
                                  ? NetworkImage(
                                      model.loggedInUser.profilePhotoUrl,

                                      // fit: BoxFit.cover,

                                      // width: 50,
                                    )
                                  : AssetImage(
                                      "assets/profilePicture.jpeg",
                                    ),
                            ),
                          ),
                        ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 25, bottom: 20.0),
                child: model.isUserSignedIn
                    ? Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(top: 10),
                            child: Text(
                              model.loggedInUser.name,
                              textScaleFactor: 1.2,
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 10.0),
                            child: IconButton(
                              alignment: Alignment.center,
                              icon: Icon(
                                Icons.mode_edit,
                                color: Colors.white,
                                size: 20,
                              ),
                              onPressed: () {
                                Navigator.of(context).push(
                                    CupertinoPageRoute(builder: (context) {
                                  return ProfileUpdatePage(model.loggedInUser);
                                }));
                              },
                            ),
                          ),
                        ],
                      )
                    : Container(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(top: 20),
                        child: Text(
                          "FAN SPORTS CLUB",
                          textScaleFactor: 1.2,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
              ),
              Container(
                padding: EdgeInsets.only(right: 20.0, bottom: 10.0),
                child: Divider(
                  color: Color.fromRGBO(120, 120, 120, 1),
                  height: 1.0,
                ),
              ),
              ListTile(
                contentPadding: EdgeInsets.only(left: 25.0),
                title: Text(
                  'Calendar',
                  textScaleFactor: 1,
                  style: TextStyle(
                    color: Theme.of(context).textTheme.title.color,
                  ),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.pushReplacement(
                    context,
                    CupertinoPageRoute(
                      builder: (BuildContext context) {
                        return CalendarPage();
                      },
                    ),
                  );
                },
              ),
              ListTile(
                contentPadding: EdgeInsets.only(left: 25.0),
                title: Text(
                  'IPIN Renewal',
                  textScaleFactor: 1,
                  style: TextStyle(
                    color: Theme.of(context).textTheme.title.color,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);

                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => IPINPage(),
                    ),
                  );
                },
              ),
              model.isUserSignedIn
                  ? Container()
                  : ListTile(
                      contentPadding: EdgeInsets.only(left: 25.0),
                      title: Text(
                        'CIEN Registration',
                        textScaleFactor: 1,
                        style: TextStyle(
                          color: Theme.of(context).textTheme.title.color,
                        ),
                      ),
                      onTap: () {
                        Navigator.pop(context);

                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => CIENPage(),
                          ),
                        );
                      },
                    ),
              ListTile(
                contentPadding: EdgeInsets.only(left: 25.0),
                title: Text(
                  'ITF Ranking',
                  textScaleFactor: 1,
                  style: TextStyle(
                    color: Theme.of(context).textTheme.title.color,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);

                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => ItfRankingPage(),
                    ),
                  );
                },
              ),
              ListTile(
                  contentPadding: EdgeInsets.only(left: 25.0),
                  title: Text(
                    'Player Search',
                    textScaleFactor: 1,
                    style: TextStyle(
                      color: Theme.of(context).textTheme.title.color,
                    ),
                  ),
                  onTap: () {
                    model.intiProfileData(model.token);

                    Navigator.pop(context);

                    showSearch(
                      context: context,
                      delegate: CustomSearchDelegate(),
                    );
                  }),
              ListTile(
                contentPadding: EdgeInsets.only(left: 25.0),
                title: Text('About us',
                    textScaleFactor: 1,
                    style: TextStyle(
                      color: Theme.of(context).textTheme.title.color,
                    )),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => AboutUsPage(),
                    ),
                  );
                },
              ),
              ListTile(
                contentPadding: EdgeInsets.only(left: 25.0),
                title: Text(
                  'Gallery',
                  style: TextStyle(
                    color: Theme.of(context).textTheme.title.color,
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => GalleryPage(),
                    ),
                  );
                },
              ),
              ListTile(
                contentPadding: EdgeInsets.only(left: 25.0),
                title: Text(
                  'Payment',
                  style: TextStyle(
                    color: Theme.of(context).textTheme.title.color,
                  ),
                ),
                onTap: () async {
                  await model.payment(
                      address: "",
                      amountInRZPSyntax: "",
                      contact: "",
                      description: "",
                      email: "",
                      name: "TESTER");
                },
              ),
              ListTile(
                contentPadding: EdgeInsets.only(left: 25.0),
                title: Text(
                  model.isUserSignedIn ? 'Logout' : "Login",
                  style: TextStyle(
                    color: Theme.of(context).textTheme.title.color,
                  ),
                ),
                onTap: () {
                  // Navigator.pop(context);

                  model.logoutUser().then(
                    (onValue) {
                      model.isUserSignedIn
                          ? Navigator.pushReplacement(
                              context,
                              CupertinoPageRoute(
                                builder: (context) {
                                  return LandingPage();
                                },
                              ),
                            )
                          : Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) {
                                  return LandingPage();
                                },
                              ),
                            );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
