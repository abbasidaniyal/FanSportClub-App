import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../widget/drawer.dart';
import './fsc_page.dart';
import './itf_page.dart';
import '../widget/filter_modal.dart';

class CalendarPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        drawer: MyDrawer(),
        appBar: AppBar(
          backgroundColor: Theme.of(context).accentColor,
          actions: <Widget>[
            GestureDetector(
              child: Container(
                margin: EdgeInsets.all(5.0),
                child: Icon(Icons.filter_list),
              ),
              onTap: () {
                return showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return FilterModal();
                  },
                );
              },
            )
          ],
          title: Text(
            "Fan Sports Club",
            textAlign: TextAlign.left,
            textScaleFactor: 1.2,
          ),
          centerTitle: false,
          bottom: TabBar(
            tabs: <Widget>[
              Tab(
                child: Text(
                  "Club Event",
                ),
              ),
              Tab(
                child: Text(
                  "ITF Calendar",
                ),
              )
            ],
            labelColor: Theme.of(context).textTheme.title.color,
            unselectedLabelColor: Theme.of(context).textTheme.subtitle.color,
          ),
        ),
        body: TabBarView(
          children: <Widget>[FscPage(), ItfPage()],
        ),
      ),
    );
  }
}
