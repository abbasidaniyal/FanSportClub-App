import 'package:Fan_Sports/pages/UnAuthorizedUser/landing_page.dart';
import 'package:Fan_Sports/pages/create_update_profile.dart';
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
                // height: 200.0,
                padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: !model.isUserSignedIn
                    ? Image.asset(
                        "assets/logo-fsc.png",
                        alignment: Alignment.topLeft,
                        width: 110,
                      )
                    : Container(
                        width: MediaQuery.of(context).size.width * 0.25,
                        height: MediaQuery.of(context).size.width * 0.25,
                        margin: EdgeInsets.only(top: 25, left: 20.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100.0),
                            color: Theme.of(context).primaryColor),
                        foregroundDecoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width: 3.0),
                          borderRadius: BorderRadius.circular(100.0),
                          image: DecorationImage(
                            image: model.isUserSignedIn &&
                                    model.loggedInUser.profilePhotoUrl != null
                                ? NetworkImage(
                                    model.loggedInUser.profilePhotoUrl)
                                : AssetImage("assets/profilePicture.jpeg"),
                          ),
                        ),
                      ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 25, bottom: 20.0),
              child: model.isUserSignedIn
                  ? Row(
                      children: <Widget>[
                        Text(
                          model.loggedInUser.name,
                          style: TextStyle(color: Colors.white),
                        ),
                        IconButton(
                          icon: Icon(Icons.mode_edit,color: Colors.white,size: 20,),
                          onPressed: () {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(builder: (context) {
                              return ProfileUpdatePage(model.loggedInUser);
                            }));
                          },
                        ),
                      ],
                    )
                  : Container(),
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
              onTap: () async {
                bool success = await model.intiProfileData(model.token);
                if (success) {
                  Navigator.pop(context);
                  showSearch(
                    context: context,
                    delegate: CustomSearchDelegate(),
                  );
                } else {}
              },
            ),
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
            ScopedModelDescendant<MainModel>(
              builder: (context, child, model) {
                return ListTile(
                  contentPadding: EdgeInsets.only(left: 25.0),
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
            ListTile(
              contentPadding: EdgeInsets.only(left: 25.0),
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
            ),
          ],
        ),
      ),
    );
  }
}
