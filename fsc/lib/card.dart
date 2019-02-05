import 'package:flutter/material.dart';

import './pages/tournament_info_page.dart';

class CardRender extends StatelessWidget {
  String name;
  String grade;
  String date;
  String location;
  final Function toInt;
  final Map<String, dynamic> tournamentData;
  final imageUrl;

  String startMonth, endMonth;
  DateTime startDate, endDate;
  int startDay, endDay, startMonthInt, endMonthInt, year;

  CardRender(this.tournamentData, this.toInt,this.imageUrl) {
    name = tournamentData["name"];
    grade = tournamentData["grade"];
    location = tournamentData["place"];

    startDay = int.parse(tournamentData["startDate"]["date"]);
    startMonth = tournamentData["startDate"]["month"];

    endDay = int.parse(tournamentData["endDate"]["date"]);
    endMonth = tournamentData["endDate"]["month"];

    year = int.parse(tournamentData["year"]);


    startMonthInt=toInt(startMonth);
    endMonthInt=toInt(endMonth);

  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Tournament(tournamentData)));
      },
      child: Container(
        height: 150.0,
        child: Stack(
          children: <Widget>[
            Container(
              height: 150.0,
              margin: EdgeInsets.only(
                  top: 16.0, bottom: 16.0, left: 24.0, right: 24.0),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 3.0,
                    offset: Offset(8.0, 8.0),
                  ),
                ],
              ),
              child: Container(
                margin: EdgeInsets.only(top: 5.0, left: 130.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(right: 5.0),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        padding: EdgeInsets.only(right: 5.0),
                        controller: ScrollController(keepScrollOffset: false),
                        child: Text(
                          name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 25.0),
                        ),
                      ),
                    ),
                    Container(
                      child: Text(
                        "Grade : " + grade,
                        maxLines: 1,
                        textAlign: TextAlign.left,
                        style: TextStyle(fontSize: 18.0),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Icon(
                          Icons.date_range,
                          size: 25.0,
                        ),
                        Container(
                            width: 100.0,
                            child: Text(
                              startDay.toString() +
                                  " " +
                                  startMonth +
                                  " " +
                                  year.toString(),
                              maxLines: 1,
                              textScaleFactor: 1.2,
                            )),
                        SizedBox(
                          width: 20.0,
                        ),
                        Icon(
                          Icons.directions,
                          size: 25.0,
                        ),
                        Text(
                          location,
                          textScaleFactor: 1.2,
                        ),
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
