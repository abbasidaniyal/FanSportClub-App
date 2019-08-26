import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import '../models/itf_tournament.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class ITFInfoPage extends StatelessWidget {
  final ITFTournament tournamentData;
  final int index;

  ITFInfoPage({this.tournamentData, this.index});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          "Fan Sports Club",
          style: TextStyle(fontWeight: FontWeight.normal, fontSize: 20),
          overflow: TextOverflow.fade,
          textScaleFactor: 1,
        ),
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
            Image(
              image: AssetImage("assets/itf-card.jpg"),
            ),
            Container(
                padding: EdgeInsets.only(top: 5.0, left: 10.0),
                child: Text(
                  "John Walton/PA Images via Getty Images",
                  textScaleFactor: 1,
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 12,
                      color: Color.fromRGBO(206, 206, 206, 1)),
                )),
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
                            textScaleFactor: 1,
                            style: TextStyle(
                                fontWeight: FontWeight.values[5], fontSize: 18),
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
                                DateFormat("dd/MM/yyy")
                                    .format(tournamentData.startDate)
                                    .toString(),
                                textScaleFactor: 1,
                                style: TextStyle(fontSize: 15),
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
                                textScaleFactor: 1,
                                style: TextStyle(
                                    fontWeight: FontWeight.values[5],
                                    fontSize: 15),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 10.0),
                              child: Text(
                                tournamentData.venue.toString(),
                                textScaleFactor: 1,
                                style: TextStyle(fontSize: 15),
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
                                textScaleFactor: 1,
                                style: TextStyle(
                                    fontWeight: FontWeight.values[5],
                                    fontSize: 15),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 10.0),
                              child: Text(
                                tournamentData.grade.toString(),
                                textScaleFactor: 1,
                                style: TextStyle(fontSize: 15),
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
                                textScaleFactor: 1,
                                style: TextStyle(
                                    fontWeight: FontWeight.values[5],
                                    fontSize: 15),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 10.0),
                              child: Text(
                                tournamentData.surface.toString(),
                                textScaleFactor: 1,
                                style: TextStyle(fontSize: 15),
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
                                      textScaleFactor: 1,
                                      style: TextStyle(
                                          fontWeight: FontWeight.values[5],
                                          fontSize: 15),
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
                                    textScaleFactor: 1,
                                    style: TextStyle(
                                        fontWeight: FontWeight.values[5],
                                        fontSize: 15),
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
                                                .split(" ")[0], //change to 1
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
