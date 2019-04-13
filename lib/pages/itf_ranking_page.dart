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
  bool isLoaded = false;
  List<int> ageGroup = [35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 85];
  int selectedAgeIndex = 0;

  List<String> category = ['Doubles', 'Singles'];
  int selectedCategoryIndex = 0;

  @override
  void initState() {
    super.initState();
    MainModel model = ScopedModel.of(context);
    model.getRankingData(model.token); //UNCOMMENTED
    // model.temp();
  }

  Widget filter() {
    return Container(
      child: Column(
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Age Group"),
              DropdownButton<int>(
                hint: Text(ageGroup[selectedAgeIndex].toString()),
                items: ageGroup.map((int value) {
                  return new DropdownMenuItem<int>(
                    value: value,
                    child: new Text("+" + value.toString()),
                  );
                }).toList(),
                onChanged: (int a) {
                  print(a);
                  setState(() {
                    selectedAgeIndex = ageGroup.indexOf(a);
                  });
                  Navigator.pop(context);
                },
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Category"),
              DropdownButton<String>(
                hint: Text(category[selectedCategoryIndex].toString()),
                items: category.map((String value) {
                  return new DropdownMenuItem<String>(
                    value: value,
                    child: new Text(value),
                  );
                }).toList(),
                onChanged: (String a) {
                  print(a);
                  setState(() {
                    selectedCategoryIndex = category.indexOf(a);
                  });
                  Navigator.pop(context);
                },
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget buildBody() {
    return ScopedModelDescendant(
      builder: (BuildContext context, Widget child, MainModel model) {
        if (model.isRankingLoaded == true) {
          return Container(
            color: Colors.white,
            margin: EdgeInsets.all(2.0),
            child: ListView.builder(
              itemCount: model.itfRanking.length,
              itemBuilder: (BuildContext context, int index) {
                if ((model.itfRanking[index].ageGroup ==
                        ageGroup[selectedAgeIndex]) &&
                    model.itfRanking[index].category ==
                        category[selectedCategoryIndex][0]) {
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
                } else {
                  return Container();
                }
              },
            ),
          );
        } else {
          return Container(
            color: Colors.white,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        title: Text("ITF Ranking"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return filter();
                },
              );
            },
          )
        ],
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Stack(
        children: <Widget>[
          Center(
            child: Text("Nothing to Display"),
          ),
          buildBody()
        ],
      ),
    );
  }
}
