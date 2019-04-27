import 'package:flutter/material.dart';
import '../models/itf_tournament.dart';
import '../pages/itf_tournament_info_page.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class ITFCardRender extends StatelessWidget {
  String name;
  String grade;
  DateTime startDate;
  String venue;
  DateTime endDate;

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
    endDate = tournamentData.endDate;
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
        height: 150.0,
        child: Stack(
          children: <Widget>[
            Container(
              height: 150.0,
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
                margin: EdgeInsets.only(top: 5.0, left: 100.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 8.0,
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 5.0),
                      child: Text(
                        name,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 14.0, fontWeight: FontWeight.bold),
                        softWrap: true,
                        textScaleFactor: 1,
                      ),
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    Container(
                      child: Text(
                        grade,
                        maxLines: 1,
                        textScaleFactor: 1,
                        overflow: TextOverflow.clip,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 14.0,
                            color: Color.fromRGBO(120, 120, 120, 1)),
                      ),
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    Container(
                      
                      child: Row(
                        children: <Widget>[
                          Icon(
                            MdiIcons.calendarClock,
                            size: 20.0,
                          ),
                          SizedBox(
                            width: 3.0,
                          ),
                          Container(
                              child: SingleChildScrollView(
                            child: Text(
                              DateFormat("dd/MM/yy")
                                      .format(startDate)
                                      .toString() +
                                  DateFormat("- dd/MM/yy")
                                      .format(endDate)
                                      .toString(),
                              style: TextStyle(
                                fontSize: 14.0,
                                color: Color.fromRGBO(120, 120, 120, 1),
                              ),
                              textScaleFactor: 1,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          )),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    Row(
                      children: <Widget>[
                        Icon(
                          MdiIcons.mapMarker,
                          size: 20.0,
                        ),
                        SizedBox(
                          width: 3.0,
                        ),
                        Container(
                            width: 120.0,
                            child: Text(
                              venue,
                              textScaleFactor: 1,
                              style: TextStyle(
                                  fontSize: 14.0,
                                  color: Color.fromRGBO(120, 120, 120, 1)),
                              maxLines: 1,
                              overflow: TextOverflow.clip,
                            )),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Container(
                margin: EdgeInsets.only(top: 15.0, bottom: 15.0, left: 35.0),
                child: Image.asset(
                  imageUrl,
                  height: 178.0,
                  width: 80.0,
                )),
          ],
        ),
      ),
    );
  }
}
