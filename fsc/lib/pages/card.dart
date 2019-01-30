import 'package:flutter/material.dart';

class CardRender extends StatelessWidget {
  String name;
  String grade;
  String date;
  String location;
  final Map<String, dynamic> array;

  String startMonth, endMonth;
  DateTime startDate, endDate;
  int startDay, endDay, startMonthInt, endMonthInt, year;

  CardRender(this.array) {
    name = array["name"];
    grade = array["grade"];
    location = array["place"];

    startDay = int.parse(array["startDate"]["date"]);
    startMonth = array["startDate"]["month"];

    endDay = int.parse(array["endDate"]["date"]);
    endMonth = array["endDate"]["month"];

    year = int.parse(array["year"]);

    switch (startMonth) {
      case "Jan":
        startMonthInt = 1;
        break;
      case "Feb":
        startMonthInt = 2;
        break;
      case "Mar":
        startMonthInt = 3;
        break;
      case "Apr":
        startMonthInt = 4;
        break;
      case "May":
        startMonthInt = 5;
        break;
      case "Jun":
        startMonthInt = 6;
        break;
      case "Jul":
        startMonthInt = 7;
        break;
      case "Aug":
        startMonthInt = 8;
        break;
      case "Sep":
        startMonthInt = 9;
        break;
      case "Oct":
        startMonthInt = 10;
        break;
      case "Nov":
        startMonthInt = 11;
        break;
      case "Dec":
        startMonthInt = 12;
        break;

      default:
        startMonthInt = 0;
    }

    switch (endMonth) {
      case "Jan":
        endMonthInt = 1;
        break;
      case "Feb":
        endMonthInt = 2;
        break;
      case "Mar":
        endMonthInt = 3;
        break;
      case "Apr":
        endMonthInt = 4;
        break;
      case "May":
        endMonthInt = 5;
        break;
      case "Jun":
        endMonthInt = 6;
        break;
      case "Jul":
        endMonthInt = 7;
        break;
      case "Aug":
        endMonthInt = 8;
        break;
      case "Sep":
        endMonthInt = 9;
        break;
      case "Oct":
        endMonthInt = 10;
        break;
      case "Nov":
        endMonthInt = 11;
        break;
      case "Dec":
        endMonthInt = 12;
        break;

      default:
        endMonthInt = 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
                  offset: Offset(10.0, 10.0),
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
                            startDay.toString()+" "+startMonth+" " + year.toString(),
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
              image: AssetImage("assets/logo.jpg"),
              height: 178.0,
              width: 100.0,
            ),
          ),
        ],
      ),
    );
  }
}
