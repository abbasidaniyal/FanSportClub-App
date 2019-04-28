import 'package:flutter/material.dart';

import '../widget/ranking_card.dart';
import '../widget/drawer.dart';

import 'package:scoped_model/scoped_model.dart';
import '../scoped_model/main.dart';
import '../widget/button.dart';
import '../models/itf_ranking.dart';

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

  List<ITFRanking> array = [];

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    MainModel model = ScopedModel.of(context);

    model.getRankingData(model.token).then((onValue) {
      setState(() {
        array = model.itfRanking.where((test) {
          return (test.ageGroup == ageGroup[selectedAgeIndex]) &&
                  (test.category == category[selectedCategoryIndex][0])
              ? true
              : false;
        }).toList();
      });
    });
  }

  Widget filter() {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,

        border: Border.all(color: Theme.of(context).primaryColor),
        // borderRadius: BorderRadius.circular(5.0)
      ),
      height: MediaQuery.of(context).size.height * 0.35,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.07,
            decoration: BoxDecoration(color: Theme.of(context).primaryColor),
            child: AppBar(
              title: Text(
                "Filter Ranking",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
                textScaleFactor: 1,
                textAlign: TextAlign.left,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.1, top: 10.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Age Group : ",
                  style: TextStyle(fontSize: 18),
                  textScaleFactor: 1,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: DropdownButton<int>(
                    isExpanded: true,
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                    hint: Text(
                      ageGroup[selectedAgeIndex].toString(),
                      textScaleFactor: 1,
                    ),
                    items: ageGroup.map((int value) {
                      return DropdownMenuItem<int>(
                        value: value,
                        child: Text(
                          "+" + value.toString(),
                          textScaleFactor: 1,
                        ),
                      );
                    }).toList(),
                    onChanged: (int a) {
                      print(a);
                      setState(
                        () {
                          selectedAgeIndex = ageGroup.indexOf(a);
                        },
                      );

                      Navigator.pop(context);
                      showModalBottomSheet(
                        context: context,
                        builder: (context) => filter(),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * 0.1,
            ),
            width: MediaQuery.of(context).size.width,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Category    : ",
                  style: TextStyle(fontSize: 18),
                  textScaleFactor: 1,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: DropdownButton<String>(
                    isExpanded: true,
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                    hint: Text(
                      category[selectedCategoryIndex].toString(),
                      textScaleFactor: 1,
                    ),
                    items: category.map(
                      (String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            textScaleFactor: 1,
                          ),
                        );
                      },
                    ).toList(),
                    onChanged: (String a) {
                      print(a);
                      setState(() {
                        selectedCategoryIndex = category.indexOf(a);
                      });

                      Navigator.pop(context);

                      showModalBottomSheet(
                        context: context,
                        builder: (context) => filter(),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10.0),
            child: MyButton("Apply", () {
              setState(() {
                MainModel model = ScopedModel.of(context);

                array = model.itfRanking.where((test) {
                  return (test.ageGroup == ageGroup[selectedAgeIndex]) &&
                          (test.category == category[selectedCategoryIndex][0])
                      ? true
                      : false;
                }).toList();
              });
              Navigator.pop(context);
            }),
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
            margin: EdgeInsets.all(2.0),
            child: ListView.builder(
              itemCount: array.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  color: Colors.white,
                  child: Column(
                    children: <Widget>[
                      RankingCard(
                        player: array[index],
                      ),
                      Divider(
                        color: Colors.black,
                      )
                    ],
                  ),
                );
              },
            ),
          );
        } else {
          if (model.rankingError == true) {
            return AlertDialog(
              content: Text(
                "Server did not respond. \nPlease check your internet connection",
                textScaleFactor: 1,
              ),
              title: Text(
                "ERROR",
                textScaleFactor: 1,
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
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: MyDrawer(),
        appBar: AppBar(
          title: Text(
            "ITF Ranking",
            textScaleFactor: 1,
            style: TextStyle(fontWeight: FontWeight.normal, fontSize: 20),
            textAlign: TextAlign.left,
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.filter_list),
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) => filter(),
                );
              },
            )
          ],
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: ScopedModelDescendant<MainModel>(
          builder: (context, child, model) {
            return Stack(
              children: <Widget>[
                array.length == 0
                    ? Center(
                        child: Text(
                          "Nothing to Display",
                          textScaleFactor: 1,
                        ),
                      )
                    : Container(),
                buildBody(),
              ],
            );
          },
        ));
  }
}
