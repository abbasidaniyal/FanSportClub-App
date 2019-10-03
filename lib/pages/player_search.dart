import 'package:Fan_Sports/pages/player_profile_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../scoped_model/main.dart';

class PlayerSearch extends StatefulWidget {
  @override
  _PlayerSearchState createState() => _PlayerSearchState();
}

class _PlayerSearchState extends State<PlayerSearch> {
  bool loadingStatus;
  @override
  void initState() {
    loadingStatus = true;
    MainModel model = ScopedModel.of(context);
    model.intiProfileData(model.token).then((success) {
      if (success) {
        setState(() {
          loadingStatus = false;
        });
        showSearch(
          context: context,
          delegate: CustomSearchDelegate(),
        ).then((onValue) {
          Navigator.pop(context);
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: loadingStatus
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(),
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
        // Navigator.pop(context);
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
            child: InkWell(
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
                    //height: MediaQuery.of(context).size.width * 0.1,
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
                  CupertinoPageRoute(
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
            child: InkWell(
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
                    //height: MediaQuery.of(context).size.width * 0.1,
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
                  CupertinoPageRoute(
                    builder: (context) {
                      return PlayerProfilePage(results.toList()[index]);
                    },
                  ),
                );
              },
            ),
          );
        } else
          return buildSuggestions(context);
      },
    );
  }
}