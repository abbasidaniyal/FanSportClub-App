import 'package:flutter/material.dart';

import '../models/itf_ranking.dart';

class RankingCard extends StatelessWidget {
  final ITFRanking player;
  String flagImageUrl = 'assets/indiaFlag.png';

  RankingCard({this.player});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      height: 70,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(left: 20.0, top: 10.0, bottom: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width * 0.60,
                  margin: EdgeInsets.only(),
                  child: Text(
                    player.name,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                    style:
                        TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
                    textScaleFactor: 1,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 5.0),
                  child: Text(
                    "Points : " + player.points.toString(),
                    maxLines: 1,
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 14.0),
                    textScaleFactor: 1,
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 5.0),
                      child: Text(
                        "Events: " + player.events.toString(),
                        style: TextStyle(fontSize: 14.0),
                        textScaleFactor: 1,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5.0, left: 20.0),
                      child: Text(
                        "Born: " + player.dateOfBirth,
                        style: TextStyle(fontSize: 14.0),
                        textScaleFactor: 1,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          Container(
            child: VerticalDivider(
              color: Colors.grey,
              width: 8.0,
              // indent: 80.0,
            ),
          ),
          Container(
            // margin: EdgeInsets.only(left: 5.0),
            width: MediaQuery.of(context).size.width * 0.30,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: Text(
                    "ITF Rank",
                    overflow: TextOverflow.ellipsis,
                    textScaleFactor: 1,
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 12.0),
                  child: Text(
                    player.rank.toString(),
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                    textScaleFactor: 1,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
