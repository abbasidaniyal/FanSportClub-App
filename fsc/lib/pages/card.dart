import 'package:flutter/material.dart';

class CardRender extends StatelessWidget {
  final String name;
  final String grade;
  final String date;
  final String location;


  CardRender(this.name, this.grade, this.date, this.location);

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
                          width: 55.0,
                          child: Text(
                            date,
                            maxLines: 1,
                            textScaleFactor: 1.2,
                          )),
                      SizedBox(
                        width: 50.0,
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
