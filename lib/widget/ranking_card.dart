import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../scoped_model/main.dart';
import '../models/itf_ranking.dart';

class RankingCard extends StatelessWidget {
  final ITFRanking player;
  String flagImageUrl = 'assets/indiaFlag.png';

  RankingCard({this.player});

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
              margin: EdgeInsets.only(top: 5.0, left: 170.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 5.0),
                    child: Text(
                      player.name,
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
                      "Points : " + player.points.toString(),
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
                        child: Text("Events: "),
                      ),
                      SizedBox(
                        width: 3.0,
                      ),
                      Container(
                        child: Text(
                          player.events.toString(),
                        ),
                      ),
                      SizedBox(
                        width: 20.0,
                      ),
                      Text(
                        "DOB: ",
                      ),
                      SizedBox(
                        width: 3.0,
                      ),
                      Text(player.dateOfBirth.toString().replaceRange(
                          10, player.dateOfBirth.toString().length, ""))
                    ],
                  )
                ],
              ),
            ),
          ),
          Container(
            height: 120.0,
            width: 100.0,
            margin: EdgeInsets.only(top: 15.0, bottom: 15.0, left: 44.0),
            
            decoration: BoxDecoration(
              // shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  blurRadius: 1.0,
                  color: Theme.of(context).accentColor,
                )
              ],
              borderRadius: BorderRadius.all(Radius.circular(1000.0)),
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage(flagImageUrl),
              ),
            ),
            
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.05,
            margin: EdgeInsets.only(left:10.0,top: 50.0,bottom: 50.0),
            child: Text(player.rank.toString()+".",textScaleFactor: 1.5,),
          )
        ],
      ),
    );
  }
}
