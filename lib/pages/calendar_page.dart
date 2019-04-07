import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../widget/drawer.dart';
import './fsc_page.dart';
import 'package:scoped_model/scoped_model.dart';
import '../scoped_model/main.dart';
import './itf_page.dart';
import './player_profile_page.dart';

class CalendarPage extends StatefulWidget {
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  String nameToBeSearched;
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    MainModel model = ScopedModel.of(context);
    model.intiProfileData();
  }

  @override
  Widget build(BuildContext context) {
    // MaterialLocalizations.of(context).searchFieldLabel   = 'Player Profile Search';
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        key: scaffoldKey,
        drawer: MyDrawer(),
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: CustomSearchDelegate(),
                );
              },
            ),
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
          children: <Widget>[
            FscPage(),
            ItfPage(),
          ],
        ),
      ),
    );
  }
}

class CustomSearchDelegate extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, query);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    MainModel model = ScopedModel.of(context);

    final results = model.playerProfiles
        .where((a) => a.fullname().toLowerCase().contains(query.toLowerCase()));

    return ListView.builder(
      padding: EdgeInsets.all(0),
      itemCount: results.toList().length,
      itemBuilder: (context, int index) {
        if (model.playerProfiles.length > 0) {
          return Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.symmetric(vertical: 20.0),
            child: GestureDetector(
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width * 0.1,
                    child: Icon(
                      Icons.account_circle,
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Text(
                      results.toList()[index].firstName +
                          " " +
                          results.toList()[index].lastName,
                      textScaleFactor: 1.3,
                    ),
                  )
                ],
              ),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return PlayerProfilePage(results.toList()[index]);
                    },
                  ),
                );
              },
            ),
          );
        } else
          return CircularProgressIndicator();
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    MainModel model = ScopedModel.of(context);

    final results = model.playerProfiles
        .where((a) => a.fullname().toLowerCase().contains(query.toLowerCase()));

    return ListView.builder(
      padding: EdgeInsets.all(0),
      itemCount: results.toList().length,
      itemBuilder: (context, int index) {
        if (model.playerProfiles.length > 0) {
          return Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.symmetric(vertical: 20.0),
            child: GestureDetector(
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width * 0.1,
                    child: Icon(
                      Icons.account_circle,
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Text(
                      results.toList()[index].firstName +
                          " " +
                          results.toList()[index].lastName,
                      textScaleFactor: 1.3,
                    ),
                  )
                ],
              ),
              onTap: () {
                close(context, results.toList()[index].firstName);
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return PlayerProfilePage(results.toList()[index]);
                    },
                  ),
                );
              },
            ),
          );
        } else
          return CircularProgressIndicator();
      },
    );
  }
}

