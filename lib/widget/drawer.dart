import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../pages/about_us_page.dart';
import '../pages/gallery_page.dart';
import '../pages/ipin_page.dart';
import '../pages/calendar_page.dart';
import '../pages/cien_form_page.dart';
import '../pages/itf_ranking_page.dart';
import '../pages/player_profile_search_page.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        padding: EdgeInsets.only(left: 20.0),
        color: Theme.of(context).primaryColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(3.0),
              padding: EdgeInsets.only(top: 40.0, bottom: 30.0),
              child: Image.asset(
                "assets/logo.png",
                alignment: Alignment.topLeft,
                width: 110,
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
                'Calender',
                style: TextStyle(
                  color: Theme.of(context).textTheme.title.color,
                ),
              ),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => CalendarPage(),
                  ),
                );
              },
            ),

            ListTile(
              title: Text('IPIN Renewal',
                  style: TextStyle(
                    color: Theme.of(context).textTheme.title.color,
                  )),
              onTap: () {
                Navigator.of(context).pop();
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
                style: TextStyle(
                  color: Theme.of(context).textTheme.title.color,
                ),
              ),
              onTap: () {
                Navigator.of(context).pop();
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
                style: TextStyle(
                  color: Theme.of(context).textTheme.title.color,
                ),
              ),
              onTap: () {
                Navigator.of(context).pop();
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
                  style: TextStyle(
                    color: Theme.of(context).textTheme.title.color,
                  )),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => AboutUsPage(),
                  ),
                );
              },
            ),
            // ListTile(
            //   title: Text(
            //     'Gallery',
            //     style: TextStyle(
            //       color: Theme.of(context).textTheme.title.color,
            //     ),
            //   ),
            //   onTap: () {
            //     Navigator.push(
            //       context,
            //       CupertinoPageRoute(
            //         builder: (context) => GalleryPage(),
            //       ),
            //     );
            //   },
            // ),
            // ListTile(
            //   title: Text(
            //     'Player Profile',
            //     style: TextStyle(
            //       color: Theme.of(context).textTheme.title.color,
            //     ),
            //   ),
            //   onTap: () {
            //     Navigator.push(
            //       context,
            //       CupertinoPageRoute(
            //         builder: (context) => PlayerProfileSearch(),
            //       ),
            //     );
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}
