import 'package:flutter/material.dart';

class RankingCard extends StatelessWidget {
  final String name;
  final int events;
  final flagImageUrl;
  final int points;
  final int rank;
  final DateTime dob;

  String startMonth, endMonth;
  DateTime startDate, endDate;
  int startDay, endDay, startMonthInt, endMonthInt, year;

  RankingCard(this.name, this.events, this.flagImageUrl, this.dob, this.points,
      this.rank);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120.0,
      child: Stack(
        children: <Widget>[
          Container(
            height: 142.0,
            margin: EdgeInsets.only(top: 3.0, bottom: 3.0),
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
                      "Points : " + points.toString(),
                      maxLines: 1,
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 18.0),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        child: Text("Events"),
                      ),
                      SizedBox(
                        width: 3.0,
                      ),
                      Container(
                        child: Text(
                          events.toString(),
                        ),
                      ),
                      SizedBox(
                        width: 20.0,
                      ),
                      Text(
                        "DOB",
                      ),
                      SizedBox(
                        width: 3.0,
                      ),
                      Text(dob.toString().replaceRange(10, dob.toString().length, ""))
                    ],
                  )
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 15.0, bottom: 15.0, left: 4.0),
            child: Image(
              image: AssetImage(flagImageUrl),
              height: 120.0,
              width: 100.0,
            ),
          ),
        ],
      ),
    );
  }
}
