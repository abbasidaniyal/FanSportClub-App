import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/fsc_tournament.dart';
import '../pages/fsc_tournament_info_page.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class FSCCardRender extends StatelessWidget {
  int index;
  String name;
  String age_group;
  DateTime date;
  String venue;
  String description;

  final FSCTournament tournamentData;
  final String imageUrl;

  // String startMonth, endMonth;
  // DateTime startDate, endDate;
  // int startDay, endDay, startMonthInt, endMonthInt, year;

  FSCCardRender(this.tournamentData, this.imageUrl, this.index) {
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
                builder: (context) => FSCInfoPage(tournamentData, index)));
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
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(3.0),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 3.0,
                    offset: Offset(0.0, 0.0),
                  ),
                ],
              ),
              child: Container(
                margin: EdgeInsets.only(top: 5.0, left: 90.0),
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
                        // "",
                        "Age Groups : " + age_group,
                        textScaleFactor: 1,
                        maxLines: 1,
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
                            width: MediaQuery.of(context).size.width * 0.40,
                            child: Text(
                              DateFormat("EEE, dd/MM/yyy")
                                  .format(date)
                                  .toString(),
                              textScaleFactor: 1,
                              style: TextStyle(
                                  fontSize: 14.0,
                                  color: Color.fromRGBO(120, 120, 120, 1)),
                              maxLines: 1,
                              overflow: TextOverflow.clip,
                              // textScaleFactor: 1.1,
                            )),
                        SizedBox(
                          width: 5.0,
                        ),
                      ],
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
                        Flexible(
                          child: Container(
                              // width: 120.0,
                              child: Text(
                            venue,
                            textScaleFactor: 1,

                            style: TextStyle(
                                fontSize: 14.0,
                                color: Color.fromRGBO(120, 120, 120, 1)),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            // textScaleFactor: 1.1,
                          )),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 40.0, bottom: 15.0, left: 40.0),
              child: Image(
                image: AssetImage(imageUrl),
                // height: 150.0,
                width: 55.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
