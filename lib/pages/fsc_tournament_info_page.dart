import 'package:flutter/material.dart';

import '../models/fsc_tournament.dart';
import '../models/itf_tournament.dart';

class FSCInfoPage extends StatelessWidget {
  final FSCTournament tournamentData;

  FSCInfoPage(this.tournamentData);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).accentColor,
        title: Text(
          tournamentData.tournamentName,
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
                  tournamentData.tournamentName,
                  textAlign: TextAlign.center,
                  textScaleFactor: 1.8,
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                  "Date : " + tournamentData.date.toString(),
                  textScaleFactor: 1.2,
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                  "Grade : " + tournamentData.ageGroup,
                  textScaleFactor: 1.2,
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                  "Place : " + tournamentData.venue,
                  textScaleFactor: 1.2,
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                  "Description : " + tournamentData.description,
                  textScaleFactor: 1.2,
                ),
              ),
              // Container(
              //   margin: EdgeInsets.symmetric(vertical: 10.0),
              //   child: Text(
              //     "Website : (To be added)",
              //     textScaleFactor: 1.2,
              //   ),
              // ),
              // Container(
              //   margin: EdgeInsets.symmetric(vertical: 10.0),
              //   child: Text(
              //     "Court Type : (To be added)",
              //     textScaleFactor: 1.2,
              //   ),
              // ),
              // Container(
              //   margin: EdgeInsets.symmetric(vertical: 10.0),
              //   child: Text(
              //     "Other2 : (To be added)",
              //     textScaleFactor: 1.2,
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
