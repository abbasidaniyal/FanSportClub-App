import 'package:flutter/material.dart';

import '../models/fsc_tournament.dart';
import 'package:intl/intl.dart';

class FSCInfoPage extends StatelessWidget {
  final FSCTournament tournamentData;

  FSCInfoPage(this.tournamentData);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          "Fan Sports Club",
          style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),
          overflow: TextOverflow.fade,
          textScaleFactor: 1,
        ),
      ),
      body: Container(
        constraints: BoxConstraints.expand(),
        child: Container(
          child: ListView(
            children: <Widget>[
              Image(
                image: AssetImage("assets/tournamentInfo.jpg"),
              ),
              Container(
                margin: EdgeInsets.only(top: 20.0, left: 25.0, right: 25.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10.0),
                      child: Text(
                        tournamentData.tournamentName,
                        textScaleFactor: 1,
                        style: TextStyle(fontWeight: FontWeight.values[5],fontSize: 18),
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 2.0),
                          child: Text(
                            "Date : ",
                            textScaleFactor: 1.1,
                            style: TextStyle(fontWeight: FontWeight.values[5],fontSize: 15),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 2.0),
                          child: Text(
                            DateFormat("dd/MM/yyy").format(tournamentData.date).toString(),
                              style: TextStyle(fontSize: 15),
                            
                            textScaleFactor: 1,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 2.0),
                          child: Text(
                            "Venue : ",
                            textScaleFactor: 1,
                            style: TextStyle(fontWeight: FontWeight.values[5],fontSize: 15),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 2.0),
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
                          margin: EdgeInsets.symmetric(vertical: 2.0),
                          child: Text(
                            "Age Group : ",
                            textScaleFactor: 1,
                            style: TextStyle(fontWeight: FontWeight.values[5],fontSize: 15),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 2.0),
                          child: Text(
                            tournamentData.ageGroup.toString(),
                            textScaleFactor: 1,
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(top: 10.0),
                          child: Text(
                            "About: ",
                            textScaleFactor: 1,
                            style: TextStyle(fontWeight: FontWeight.values[5],fontSize: 15),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 1.0),
                          child: Text(
                            tournamentData.description.toString(),
                            textScaleFactor: 1,
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                      ],
                    ),

                    // Container(
                    //   margin: EdgeInsets.symmetric(vertical: 10.0),
                    //   child: Text(
                    //     "Description : " + tournamentData.description,
                    //     textScaleFactor: 1.1,
                    //   ),
                    // ),
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
