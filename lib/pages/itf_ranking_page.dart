//to be developed
import 'package:flutter/material.dart';

import '../widget/ranking_card.dart';
import '../widget/drawer.dart';

import 'package:scoped_model/scoped_model.dart';
import '../scoped_model/main.dart';

class ItfRankingPage extends StatefulWidget {
  @override
  _ItfRankingPageState createState() => _ItfRankingPageState();
}

class _ItfRankingPageState extends State<ItfRankingPage> {
  @override
  Widget build(BuildContext context) {
    MainModel model = ScopedModel.of(context);
    model.getRankingData();
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        title: Text("ITF Ranking"),
        actions: <Widget>[Icon(Icons.sort)],
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Container(
        margin: EdgeInsets.all(2.0),
        child: ListView.builder(
          itemCount: model.itfRanking.length,
          itemBuilder: (context, int index) {
            return Column(
              children: <Widget>[
                RankingCard(
                  player: model.itfRanking[index],
                ),
                Divider(
                  color: Colors.black,
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
