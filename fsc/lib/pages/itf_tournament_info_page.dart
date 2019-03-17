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
        backgroundColor: Theme.of(context).accentColor,
        title: Text(
          tournamentData.name,
          overflow: TextOverflow.fade,
          textScaleFactor: 0.9,
        ),
      ),
      body: Container(
        constraints: BoxConstraints.expand(),
        margin:
            EdgeInsets.only(top: 16.0, bottom: 16.0, left: 24.0, right: 24.0),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
          padding: EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                  tournamentData.name,
                  textAlign: TextAlign.center,
                  textScaleFactor: 1.8,
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                  "Date : " + tournamentData.startDate.toString(),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                  "Grade : " + tournamentData.grade,
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                  "Place : " + tournamentData.venue,
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                  "End Date : " + tournamentData.endDate.toString(),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10.0),
                child: Linkify(
                  text: tournamentData.website == null
                      ? "Website : Not Available"
                      : "Website :" + tournamentData.website,
                  onOpen: (url) {
                    launch(url);
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                  "Court Type : " + tournamentData.surface,
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10.0),
                child: Linkify(
                  text: "Link : " + tournamentData.link,
                  onOpen: (url) {
                    launch(url);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
