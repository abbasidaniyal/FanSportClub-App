import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import '../widget/drawer.dart';
import './fsc_page.dart';
import 'package:scoped_model/scoped_model.dart';
import '../scoped_model/main.dart';
import './itf_page.dart';
import './player_profile_page.dart';
import './player_search.dart';

class CalendarPage extends StatefulWidget {
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  String nameToBeSearched;
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    // initProfiles();
  }

  @override
  Widget build(BuildContext context) {
    MainModel model = ScopedModel.of(context);
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
      },
    );
    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, badge: true, alert: true));
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
    _firebaseMessaging.getToken().then((String token) {
      assert(token != null);
      print(token);
    });
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        key: scaffoldKey,
        drawer: MyDrawer(),
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: Text(
            "Fan Sports Club",
            textScaleFactor: 1,
            style: TextStyle(fontWeight: FontWeight.normal, fontSize: 20),
            textAlign: TextAlign.left,
          ),
          centerTitle: false,
          bottom: TabBar(
            tabs: <Widget>[
              Tab(
                child: Text(
                  "Club Event",
                  textScaleFactor: 1,
                ),
              ),
              Tab(
                child: Text(
                  "ITF Calendar",
                  textScaleFactor: 1,
                ),
              )
            ],
            labelColor: Theme.of(context).textTheme.title.color,
            unselectedLabelColor: Theme.of(context).textTheme.subtitle.color,
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            FscPage(),
            ItfPage(),
          ],
        ),
      ),
    );
  }
}
