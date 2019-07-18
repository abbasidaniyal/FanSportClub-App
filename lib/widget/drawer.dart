import 'package:Fan_Sports/pages/UnAuthorizedUser/landing_page.dart';
import 'package:Fan_Sports/pages/create_update_profile.dart';
import 'package:Fan_Sports/pages/payment_history_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
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
  String appVersion;
  @override
  Widget build(BuildContext context) {
    MainModel model = ScopedModel.of(context);
    // PackageInfo.fromPlatform().then((packageInfo) {
    //   appVersion = packageInfo.version;
    // });
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
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                      if (model.isUserSignedIn) {
                        Navigator.push(context,
                            CupertinoPageRoute(builder: (BuildContext context) {
                          return ProfileUpdatePage(model.loggedInUser);
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
                        left: 5,
                        top: 12.0,
                        bottom: 12.0,
                      ),
                      child: !model.isUserSignedIn
                          ? Image.asset(
                              "assets/logo-fsc.png",
                              alignment: Alignment.center,
                            )
                          : Container(
                              // alignment: Alignment(-1, 0),
                              width: MediaQuery.of(context).size.width * 0.20,
                              height: MediaQuery.of(context).size.width * 0.20,
                              // padding: EdgeInsets.only(right: 120),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(500.0),
                                  color: Theme.of(context).primaryColor),
                              foregroundDecoration: BoxDecoration(
                                border: Border.all(
                                    color: Theme.of(context).accentColor,
                                    width: 2),
                                borderRadius: BorderRadius.circular(100.0),
                                image: DecorationImage(
                                  image: model.isUserSignedIn &&
                                          model.loggedInUser.profilePhotoUrl !=
                                              null
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
                    padding: EdgeInsets.only(left: 25, top: 20.0),
                    child: model.isUserSignedIn
                        ? Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                            ],
                          )
                        : Container(),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.only(right: 20.0, bottom: 10.0),
                child: Divider(
                  color: Color.fromRGBO(120, 120, 120, 1),
                  height: 1.0,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 5),
                child: InkWell(
                  child: Text(
                    'Calendar',
                    textScaleFactor: 1,
                    textAlign: TextAlign.start,
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
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 5),
                child: InkWell(
                  child: Text(
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
              ),
              // Container(
              //     child: model.isUserSignedIn
              //         ? Container()
              //         : Container(
              //             padding:
              //                 EdgeInsets.symmetric(vertical: 15, horizontal: 5),
              //             child: InkWell(
              //               child: Text(
              //                 'CIEN Registration',
              //                 textScaleFactor: 1,
              //                 style: TextStyle(
              //                   color: Theme.of(context).textTheme.title.color,
              //                 ),
              //               ),
              //               onTap: () {
              //                 Navigator.pop(context);

              //                 Navigator.push(
              //                   context,
              //                   CupertinoPageRoute(
              //                     builder: (context) => CIENPage(),
              //                   ),
              //                 );
              //               },
              //             ),
              //           )),
              Container(
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 5),
                child: InkWell(
                  child: Text(
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
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 5),
                child: InkWell(
                    child: Text(
                      'Player Search',
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
                          builder: (context) => PlayerSearch(),
                        ),
                      );
                    }),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 5),
                child: InkWell(
                  child: Text('About us',
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
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 5),
                child: InkWell(
                  child: Text(
                    'Gallery',
                    textAlign: TextAlign.left,
                    textScaleFactor: 1,
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
              ),
              !model.isUserSignedIn
                  ? Container()
                  : Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 5),
                      child: InkWell(
                        child: Text(
                          'Payment History',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Theme.of(context).textTheme.title.color,
                          ),
                        ),
                        onTap: () async {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return PaymentHistory();
                          }));
                        },
                      ),
                    ),
              Container(
                padding: EdgeInsets.only(top: 20, right: 20.0, bottom: 10.0),
                child: Divider(
                  color: Color.fromRGBO(120, 120, 120, 1),
                  height: 1.0,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 5),
                child: InkWell(
                  child: Text(
                    model.isUserSignedIn ? 'Logout' : "Login",
                    textScaleFactor: 1.1,
                    style: TextStyle(
                      color: Colors.white//Theme.of(context).textTheme.title.color,
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
              ),
              // appVersion == null
              //     ? Container()
              //     : Container(
              //         child: Text(appVersion),
              //       )
            ],
          ),
        ),
      ),
    );
  }
}
