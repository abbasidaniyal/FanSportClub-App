import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import './my_drawer.dart';
import './fsc_page.dart';
import './itf_page.dart';

class CalendarPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        
        length: 2,
        child: Scaffold(
            drawer: MyDrawer(),
            appBar: AppBar(
              
              title: Text("Calendar"),
              bottom: TabBar(
                tabs: <Widget>[
                  Tab(
                    text: "FSC",
                  ),
                  Tab(
                    text: "ITF",
                  )
                ],
              ),
            ),
            body: TabBarView(
              children: <Widget>[FscPage(), ItfPage()],
            )));
  }
}
