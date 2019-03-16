import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../pages/about_us_page.dart';
import '../pages/gallery_page.dart';
import '../pages/ipin_page.dart';
import '../pages/calendar_page.dart';
import '../pages/cien_form_page.dart';
import '../pages/itf_ranking_page.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Theme.of(context).accentColor,
        child: Column(
          children: <Widget>[
            AppBar(
              automaticallyImplyLeading: false,
              title: Text("FSC"),
              backgroundColor: Theme.of(context).accentColor,
              textTheme: Theme.of(context).textTheme,
            ),
            ListTile(
              title: Text(
                'Calender',
                style: TextStyle(
                  color: Theme.of(context).textTheme.title.color,
                ),
              ),
              onTap: () {
                Navigator.pushReplacement(
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
                Navigator.pushReplacement(
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
                Navigator.pushReplacement(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => CIENPage(),
                  ),
                );
              },
            ),
            // ListTile(
            //   title: Text(
            //     'ITF Ranking',
            //     style: TextStyle(
            //       color: Theme.of(context).textTheme.title.color,
            //     ),
            //   ),
            //   onTap: () {
            //     Navigator.pushReplacement(
            //       context,
            //       CupertinoPageRoute(
            //         builder: (context) => ItfRankingPage(),
            //       ),
            //     );
            //   },
            // ),
            // ListTile(
            //   title: Text(
            //     'Gallery',
            //     style: TextStyle(
            //       color: Theme.of(context).textTheme.title.color,
            //     ),
            //   ),
            //   onTap: () {
            //     Navigator.pushReplacement(
            //       context,
            //       CupertinoPageRoute(
            //         builder: (context) => GalleryPage(),
            //       ),
            //     );
            //   },
            // ),
            ListTile(
              title: Text('About us',
                  style: TextStyle(
                    color: Theme.of(context).textTheme.title.color,
                  )),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => AboutUsPage(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
