import 'package:flutter/material.dart';

class Tournament extends StatelessWidget {
  final Map<String, dynamic> tournamentData;

  Tournament(this.tournamentData);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:Theme.of(context).accentColor,
      
        title: Text(
          tournamentData["name"],
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
                  tournamentData["name"],
                  textAlign: TextAlign.center,
                  textScaleFactor: 1.8,
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                  "Date : " + tournamentData["date"],
                  textScaleFactor: 1.2,
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                  "Grade : " + tournamentData["grade"],
                  textScaleFactor: 1.2,
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                  "Place : " + tournamentData["place"],
                  textScaleFactor: 1.2,
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                  "Address : (To be added) ",
                  textScaleFactor: 1.2,
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                  "Website : (To be added)",
                  textScaleFactor: 1.2,
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                  "Court Type : (To be added)",
                  textScaleFactor: 1.2,
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                  "Other2 : (To be added)",
                  textScaleFactor: 1.2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
