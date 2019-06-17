import 'package:Fan_Sports/pages/UnAuthorizedUser/landing_page.dart';
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

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        padding: EdgeInsets.only(left: 20.0, top: 25),
        color: Theme.of(context).primaryColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            GestureDetector(
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
              child: Container(
                margin: EdgeInsets.all(3.0),
                padding: EdgeInsets.only(top: 40.0, bottom: 30.0),
                child: Image.asset(
                  "assets/logo-fsc.png",
                  alignment: Alignment.topLeft,
                  width: 110,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
              child: Divider(
                color: Color.fromRGBO(120, 120, 120, 1),
                height: 1.0,
              ),
            ),
            ListTile(
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
            ListTile(
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
            ScopedModelDescendant<MainModel>(
              builder: (context, child, model) {
                return ListTile(
                  title: Text(
                    'Payment',
                    style: TextStyle(
                      color: Theme.of(context).textTheme.title.color,
                    ),
                  ),
                  onTap: () async {
                    await model.payment();
                  },
                );
              },
            ),
            ScopedModelDescendant<MainModel>(
              builder: (context, child, model) {
                return ListTile(
                  title: Text(
                    model.isUserSignedIn ? 'Logout' : "Login",
                    style: TextStyle(
                      color: Theme.of(context).textTheme.title.color,
                    ),
                  ),
                  onTap: () async {
                    await model.logoutUser().then(
                      (onValue) {
                        Navigator.pushReplacement(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (context, a, s) {
                              return LandingPage();
                            },
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
