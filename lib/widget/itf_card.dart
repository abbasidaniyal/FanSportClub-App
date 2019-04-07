import 'package:flutter/material.dart';

import 'package:fsc/models/fsc_tournament.dart';
import 'package:fsc/models/itf_tournament.dart';
import '../pages/itf_tournament_info_page.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class ITFCardRender extends StatelessWidget {
  String name;
  String grade;
  DateTime startDate;
  String venue;

  final ITFTournament tournamentData;
  final imageUrl;

  // String startMonth, endMonth;
  // DateTime startDate, endDate;
  // int startDay, endDay, startMonthInt, endMonthInt, year;

  ITFCardRender(this.tournamentData, this.imageUrl) {
    name = tournamentData.name;
    grade = tournamentData.grade;
    venue = tournamentData.venue;
    startDate = tournamentData.startDate;
    
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print("Clicked");
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ITFInfoPage(tournamentData)));
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
                borderRadius: BorderRadius.circular(3.0),
                shape: BoxShape.rectangle,
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 3.0,
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
                          grade,
                        maxLines: 1,
                        overflow: TextOverflow.clip,
                        textAlign: TextAlign.left,
                        style: TextStyle(fontSize: 16.0,color: Color.fromRGBO(120, 120, 120, 1)),
                      ),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Icon(
                          MdiIcons.calendarClock,
                          size: 20.0,
                        ),
                        SizedBox(
                          width: 3.0,
                        ),
                        Container(
                            width: 100.0,
                            child: Text(
                              startDate.toString(),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(color: Color.fromRGBO(120, 120, 120, 1)),
                              textScaleFactor: 1.1,
                            )),
                        SizedBox(
                          width: 5.0,
                        ),
                        Icon(
                          MdiIcons.mapMarker,
                          size: 20.0,
                        ),
                        SizedBox(
                          width: 3.0,
                        ),
                        Container(
                          width: 80.0,
                            child: Text(
                              
                          venue,
                          style: TextStyle(color: Color.fromRGBO(120, 120, 120, 1)),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
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
