import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import './about_us_page.dart';
import './gallery_page.dart';
import './ipin_page.dart';
import './calendar_page.dart';
import './cien_form_page.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(automaticallyImplyLeading: false, title: Text("FSC")),
          ListTile(
            title: Text(
              'Calender',
            ),
            onTap: () {
              Navigator.pushReplacement(context, CupertinoPageRoute(builder: (context)=>CalendarPage() ));
            },
          ),
          ListTile(
            title: Text(
              'About us',
            ),
            onTap: () {
              Navigator.pushReplacement(context,
                  CupertinoPageRoute(builder: (context) => AboutUsPage()));
            },
          ),
          ListTile(
            title: Text('IPIN Renewal'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                CupertinoPageRoute(builder: (context) => IPINPage()),
              );
            },
          ),
          ListTile(
            title: Text('CIEN Renewal'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                CupertinoPageRoute(builder: (context) => CIENPage()),
              );
            },
          ),
          ListTile(
            title: Text(
              'Gallery',
            ),
            onTap: () {
              Navigator.pushReplacement(context,
                  CupertinoPageRoute(builder: (context) => GalleryPage()));
            },
          ),
        ],
      ),
    );
  }
}
