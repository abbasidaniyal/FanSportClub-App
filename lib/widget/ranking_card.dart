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
      height: MediaQuery.of(context).size.height * 0.15,
      margin: EdgeInsets.only(left: 20.0, top: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Column(
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
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  softWrap: true,
                  textScaleFactor: 1,
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 15.0),
                child: Text(
                  "Points : " + player.points.toString(),
                  maxLines: 1,
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 18.0),
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 15.0),
                    child: Text(
                      "Events: " + player.events.toString(),
                      style: TextStyle(fontSize: 18.0),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 15.0, left: 20.0),
                    child: Text(
                      "Born: " + player.dateOfBirth,
                      style: TextStyle(fontSize: 18.0),
                    ),
                  )
                ],
              )
            ],
          ),
          Container(
            child: VerticalDivider(
              color: Colors.grey,
              width: 10.0,
              // indent: 80.0,
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(),
                  child: Text(
                    "ITF Rank",
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                    softWrap: true,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20.0),
                  child: Text(
                    player.rank.toString(),
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                    softWrap: true,
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

