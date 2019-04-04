//to be developed
import 'package:flutter/material.dart';

import '../widget/ranking_card.dart';
import '../widget/drawer.dart';

import 'package:scoped_model/scoped_model.dart';
import '../scoped_model/itf_player_ranking.dart';




class ItfRankingPage extends StatefulWidget {
  @override
  _ItfRankingPageState createState() => _ItfRankingPageState();
}

class _ItfRankingPageState extends State<ItfRankingPage> {

  

  @override
  Widget build(BuildContext context) {
    String dobb = "20171010";
    DateTime dob = DateTime.parse(dobb);
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        title: Text("ITF Ranking"),
        actions: <Widget>[Icon(Icons.sort)],
        backgroundColor: Theme.of(context).accentColor,
      ),
      body: Container(
        margin: EdgeInsets.all(2.0),
        child: RankingCard("Rohan Sharma", 04, "assets/logo.jpg", dob, 102, 1),
      ),
    );
  }
}
