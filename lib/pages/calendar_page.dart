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
    if (model.playerProfiles.isEmpty) {
      model.intiProfileData(model.token);
    }
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
                MainModel model = ScopedModel.of(context);
                if (model.profileError == true) {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          content: Text(
                              "Server did not respond. \nPlease check your internet connection"),
                          title: Text("ERROR"),
                        );
                      });
                } else {
                  showSearch(
                    context: context,
                    delegate: CustomSearchDelegate(),
                  );
                }
              },
            ),
          ],
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
        .where((a) => a.name.toLowerCase().contains(query.toLowerCase()));

    return ListView.builder(
      padding: EdgeInsets.all(0),
      itemCount: results.toList().length,
      itemBuilder: (context, int index) {
        if (model.playerProfiles.length > 0) {
          return Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.symmetric(vertical: 10.0),
            padding: EdgeInsets.symmetric(vertical: 10.0),
            child: GestureDetector(
              child: Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width * 0.1,
                    height: MediaQuery.of(context).size.width * 0.1,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100.0),
                        color: Colors.grey[400]),
                    margin: EdgeInsets.only(left: 10.0, right: 20.0),
                    foregroundDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100.0),
                      border: Border.all(width: 0.1, color: Colors.white),
                      image: DecorationImage(
                        image: results.toList()[index].profilePhotoUrl != null
                            ? NetworkImage(
                                results.toList()[index].profilePhotoUrl)
                            : AssetImage("assets/profilePicture.jpeg"),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    padding: EdgeInsets.symmetric(vertical: 10.0),
                    height: MediaQuery.of(context).size.width * 0.1,
                    child: Text(
                      results.toList()[index].name,
                      style: TextStyle(fontSize: 18),
                      textScaleFactor: 1,
                    ),
                  )
                ],
              ),
              onTap: () {
                // close(context, results.toList()[index].name);
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
        .where((a) => a.name.toLowerCase().contains(query.toLowerCase()));

    return ListView.builder(
      padding: EdgeInsets.all(0),
      itemCount: results.toList().length,
      itemBuilder: (context, int index) {
        if (model.playerProfiles.length > 0) {
          return Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.symmetric(vertical: 10.0),
            padding: EdgeInsets.symmetric(vertical: 10.0),
            child: GestureDetector(
              child: Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width * 0.1,
                    height: MediaQuery.of(context).size.width * 0.1,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100.0),
                        color: Colors.grey[400]),
                    margin: EdgeInsets.only(left: 10.0, right: 20.0),
                    foregroundDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100.0),
                      border: Border.all(width: 0.1, color: Colors.white),
                      image: DecorationImage(
                        image: results.toList()[index].profilePhotoUrl != null
                            ? NetworkImage(
                                results.toList()[index].profilePhotoUrl)
                            : AssetImage("assets/profilePicture.jpeg"),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    padding: EdgeInsets.symmetric(vertical: 10.0),
                    height: MediaQuery.of(context).size.width * 0.1,
                    child: Text(
                      results.toList()[index].name,
                      style: TextStyle(fontSize: 18),
                      textScaleFactor: 1,
                    ),
                  )
                ],
              ),
              onTap: () {
                // close(context, results.toList()[index].name);
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
