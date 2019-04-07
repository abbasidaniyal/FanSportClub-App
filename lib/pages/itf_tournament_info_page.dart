import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import '../models/itf_tournament.dart';
import 'package:url_launcher/url_launcher.dart';

class ITFInfoPage extends StatelessWidget {
  final ITFTournament tournamentData;

  ITFInfoPage(this.tournamentData);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          "Fan Sports Club",
          style: TextStyle(fontWeight: FontWeight.bold),
          overflow: TextOverflow.fade,
          textScaleFactor: 1.2,
        ),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Image(
              image: AssetImage("assets/tournamentInfo.jpg"),
            ),
            Container(
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 20.0, left: 25.0, right: 25.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(top: 10.0, bottom: 20.0),
                          child: Text(
                            tournamentData.name,
                            textScaleFactor: 1.3,
                            style: TextStyle(fontWeight: FontWeight.values[5]),
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 10.0),
                              child: Text(
                                "Date : ",
                                textScaleFactor: 1.1,
                                style:
                                    TextStyle(fontWeight: FontWeight.values[5]),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 10.0),
                              child: Text(
                                tournamentData.startDate
                                    .toString()
                                    .split(" ")[0],
                                textScaleFactor: 1.1,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 10.0),
                              child: Text(
                                "Venue : ",
                                textScaleFactor: 1.1,
                                style:
                                    TextStyle(fontWeight: FontWeight.values[5]),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 10.0),
                              child: Text(
                                tournamentData.venue.toString(),
                                textScaleFactor: 1.1,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 10.0),
                              child: Text(
                                "Grade : ",
                                textScaleFactor: 1.1,
                                style:
                                    TextStyle(fontWeight: FontWeight.values[5]),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 10.0),
                              child: Text(
                                tournamentData.grade.toString(),
                                textScaleFactor: 1.1,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 10.0),
                              child: Text(
                                "Surface : ",
                                textScaleFactor: 1.1,
                                style:
                                    TextStyle(fontWeight: FontWeight.values[5]),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 10.0),
                              child: Text(
                                tournamentData.surface.toString(),
                                textScaleFactor: 1.1,
                              ),
                            ),
                          ],
                        ),
                        Container(
                            margin: EdgeInsets.symmetric(vertical: 10.0),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(top: 2.0),
                                    child: Text(
                                      "Link : ",
                                      textScaleFactor: 1.1,
                                      style: TextStyle(
                                          fontWeight: FontWeight.values[5]),
                                    ),
                                  ),
                                  Container(
                                    child: Linkify(
                                      humanize: true,
                                      text: tournamentData.link == null
                                          ? "Not Available"
                                          : tournamentData.link,
                                      onOpen: (url) {
                                        launch(url);
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            )),
                        Container(
                          // margin: EdgeInsets.symmetric(vertical: 10.0),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.symmetric(vertical: 10.0),
                                  child: Text(
                                    "Website : ",
                                    textScaleFactor: 1.1,
                                    style: TextStyle(
                                        fontWeight: FontWeight.values[5]),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(vertical: 10.0),
                                  child: Linkify(
                                    humanize: true,
                                    text: tournamentData.website == null
                                        ? "Not Available"
                                        : "https://" +
                                            tournamentData.website
                                                .split(" ")[1],
                                    onOpen: (url) {
                                      launch(url);
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
