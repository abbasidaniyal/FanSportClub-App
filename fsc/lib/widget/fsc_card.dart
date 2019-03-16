import 'package:flutter/material.dart';

import 'package:fsc/models/fsc_tournament.dart';
import 'package:fsc/models/itf_tournament.dart';
import '../pages/fsc_tournament_info_page.dart';

class FSCCardRender extends StatelessWidget {
  String name;
  String age_group;
  DateTime date;
  String venue;
  String description;

  final FSCTournament tournamentData;
  final imageUrl;

  // String startMonth, endMonth;
  // DateTime startDate, endDate;
  // int startDay, endDay, startMonthInt, endMonthInt, year;

  FSCCardRender(this.tournamentData, this.imageUrl) {
    name = tournamentData.tournamentName;
    age_group = tournamentData.ageGroup;
    venue = tournamentData.venue;
    date = tournamentData.date;
    description = tournamentData.description;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => FSCInfoPage(tournamentData)));
      },
      child: Container(
        height: 140.0,
        child: Stack(
          children: <Widget>[
            Container(
              height: 140.0,
              margin: EdgeInsets.only(
                  top: 10.0, bottom: 10.0, left: 24.0, right: 24.0),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.rectangle,
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 3.0,
                    offset: Offset(2.0, 2.0),
                  ),
                ],
              ),
              child: Container(
                margin: EdgeInsets.only(top: 5.0, left: 130.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 5.0),
                      child: Text(
                        name,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.bold),
                        softWrap: true,
                        textScaleFactor: 1,
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      child: Text(
                        "Grade : " + age_group,
                        maxLines: 1,
                        overflow: TextOverflow.clip,
                        textAlign: TextAlign.left,
                        style: TextStyle(fontSize: 18.0),
                      ),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Icon(
                          Icons.calendar_today,
                          size: 20.0,
                        ),
                        SizedBox(
                          width: 3.0,
                        ),
                        Container(
                            width: 100.0,
                            child: Text(
                              date.toString(),
                              maxLines: 1,
                              overflow: TextOverflow.clip,
                              textScaleFactor: 1.1,
                            )),
                        SizedBox(
                          width: 5.0,
                        ),
                        Icon(
                          Icons.navigation,
                          size: 20.0,
                        ),
                        SizedBox(
                          width: 3.0,
                        ),
                        Container(
                          width: 80.0,
                            child: Text(
                              
                          venue,
                          maxLines: 1,
                          overflow: TextOverflow.clip,
                          textScaleFactor: 1.1,
                        )),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 15.0, bottom: 15.0, left: 40.0),
              child: Image(
                image: AssetImage(imageUrl),
                height: 178.0,
                width: 100.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
