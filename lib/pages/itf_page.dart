import 'package:flutter/material.dart';
import '../models/itf_tournament.dart';
import 'package:flutter_calendar/flutter_calendar.dart';

import 'package:scoped_model/scoped_model.dart';
import '../scoped_model/main.dart';

import '../widget/itf_card.dart';

class ItfPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ItfPage();
  }
}

class _ItfPage extends State<ItfPage>
    with AutomaticKeepAliveClientMixin<ItfPage> {
  List<ITFTournament> listOfTournaments = [];
  bool isLoading = true;
  DateTime selectedDate;
  bool isDateChanged = false;
  TextEditingController controllerLocation = TextEditingController();
  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerGrade = TextEditingController();
  TextEditingController controllerSurface = TextEditingController();
  ScrollController _scrollController;
  String nameQuery = "";
  String locationQuery = "";
  String gardeQuery = "";
  String surfaceQuery = "";

  final double elementHeight = 150.0;

  final String imageUrl = 'assets/logoITF.jpg';
  List<ITFTournament> array = [];
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    initItfData();
    selectedDate = DateTime.now();
    isDateChanged = true;

    _scrollController = ScrollController(initialScrollOffset: 0.0);
  }

  void initItfData() async {
    MainModel model = ScopedModel.of(context);
    bool success = await model.initItfData(model.token);

    if (success) {
      setState(() {
        array = model.itfTournaments;
        listOfTournaments = model.itfTournaments;
        isLoading = false;
      });
    }
  }

  void setSelectedDate(DateTime b) {
    setState(() {
      selectedDate = b;
      isDateChanged = true;
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void checkDateChange() {
    DateTime d;
    if (isDateChanged) {
      for (int i = 0; i < array.length; i++) {
        d = array[i].startDate;

        if (d.isAfter(selectedDate) || d.isAtSameMomentAs(selectedDate)) {
          _scrollController.animateTo(i * elementHeight,
              duration: Duration(milliseconds: 1000), curve: Curves.ease);
          break;
        }
      }
      isDateChanged = false;
    }
  }

  void updateFilterTournaments() {
    print("REACHING ON CHANGE 1");

    List<ITFTournament> results = listOfTournaments
        .where(
          (a) => a.venue.toLowerCase().contains(
                locationQuery.toLowerCase(),
              ),
        )
        .toList();
    results = results
        .where(
          (a) => a.name.toLowerCase().contains(
                nameQuery.toLowerCase(),
              ),
        )
        .toList();
    results = results
        .where(
          (a) => a.grade.toLowerCase().contains(
                gardeQuery.toLowerCase(),
              ),
        )
        .toList();
    results = results
        .where(
          (a) => a.surface.toLowerCase().contains(
                surfaceQuery.toLowerCase(),
              ),
        )
        .toList();

    print("REACHING ON CHANGE 2");
    setState(() {
      array = results;
      isDateChanged = true;
    });
  }

  // void filterTournamentsLocation(String query) {
  //   print("REACHING ON CHANGE 1");
  //   List<ITFTournament> results = listOfTournaments
  //       .where(
  //         (a) => a.venue.toLowerCase().contains(
  //               query.toLowerCase(),
  //             ),
  //       )
  //       .toList();
  //   print("REACHING ON CHANGE 2");
  //   setState(() {
  //     array = results;
  //   });
  // }

  // void filterTournamentsName(String query) {
  //   print("REACHING ON CHANGE 1");
  //   List<ITFTournament> results = listOfTournaments
  //       .where(
  //         (a) => a.name.toLowerCase().contains(
  //               query.toLowerCase(),
  //             ),
  //       )
  //       .toList();
  //   print("REACHING ON CHANGE 2");
  //   setState(() {
  //     array = results;
  //   });
  // }

  // void filterTournamentsGrade(String query) {
  //   print("REACHING ON CHANGE 1");
  //   List<ITFTournament> results = listOfTournaments
  //       .where(
  //         (a) => a.grade.toLowerCase().contains(
  //               query.toLowerCase(),
  //             ),
  //       )
  //       .toList();
  //   print("REACHING ON CHANGE 2");
  //   setState(() {
  //     array = results;
  //   });
  // }

  // void filterTournamentsSurface(String query) {
  //   print("REACHING ON CHANGE 1");
  //   List<ITFTournament> results = listOfTournaments
  //       .where(
  //         (a) => a.surface.toLowerCase().contains(
  //               query.toLowerCase(),
  //             ),
  //       )
  //       .toList();
  //   print("REACHING ON CHANGE 2");
  //   setState(() {
  //     array = results;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    if (isLoading == true) {
      MainModel model = ScopedModel.of(context);
      return Container(
        child: Center(
          child: CircularProgressIndicator(
            backgroundColor: Theme.of(context).primaryColor,
          ),
        ),
      );
    } else {
      return Container(
        color: Color.fromRGBO(245, 245, 245, 0.8),
        child: Column(
          children: <Widget>[
            Container(
              color: Color.fromRGBO(245, 245, 245, 0.8),
              padding: EdgeInsets.symmetric(horizontal: 5.0),
              child: Calendar(
                onDateSelected: (a) => setSelectedDate(a),
                isExpandable: false,
                showTodayAction: false,
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 5, horizontal: 7.0),
              padding: EdgeInsets.symmetric(horizontal: 5.0),
              // height: 40,
              color: Colors.white,
              // padding: EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: TextField(
                      controller: controllerName,
                      style: TextStyle(
                        fontSize: 20,
                      ),

                      decoration: InputDecoration.collapsed(
                          fillColor: Colors.white,

                          // filled: true,
                          hintText: "Search Tournament Name"),
                      keyboardType: TextInputType.text,
                      textAlign: TextAlign.start,
                      // textAlignVertical: TextAlignVertical.center,
                      onChanged: (value) {
                        print("REACHING $value");
                        setState(() {
                          nameQuery = value;
                        });
                        updateFilterTournaments();
                      },
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.clear),
                    onPressed: () {
                      setState(() {
                        nameQuery = "";
                      });
                      updateFilterTournaments();
                      controllerName.clear();
                    },
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 5, horizontal: 7.0),
              padding: EdgeInsets.symmetric(horizontal: 5.0),
              // height: 40,
              color: Colors.white,
              // padding: EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: TextField(
                      controller: controllerLocation,
                      style: TextStyle(
                        fontSize: 20,
                      ),

                      decoration: InputDecoration.collapsed(
                          fillColor: Colors.white,

                          // filled: true,
                          hintText: "Search Tournament Location"),
                      keyboardType: TextInputType.text,
                      textAlign: TextAlign.start,
                      // textAlignVertical: TextAlignVertical.center,
                      onChanged: (value) {
                        print("REACHING $value");
                        setState(() {
                          locationQuery = value;
                        });
                        updateFilterTournaments();
                      },
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.clear),
                    onPressed: () {
                      setState(() {
                        locationQuery = "";
                      });
                      updateFilterTournaments();
                      controllerLocation.clear();
                    },
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 5, horizontal: 7.0),
              padding: EdgeInsets.symmetric(horizontal: 5.0),
              // height: 40,
              color: Colors.white,
              // padding: EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: TextField(
                      controller: controllerSurface,
                      style: TextStyle(
                        fontSize: 20,
                      ),

                      decoration: InputDecoration.collapsed(
                          fillColor: Colors.white,

                          // filled: true,
                          hintText:
                              "Search Tournament Surface, Indoor/Outdoor"),
                      keyboardType: TextInputType.text,
                      textAlign: TextAlign.start,
                      // textAlignVertical: TextAlignVertical.center,
                      onChanged: (value) {
                        print("REACHING $value");
                        setState(() {
                          surfaceQuery = value;
                        });
                        updateFilterTournaments();
                      },
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.clear),
                    onPressed: () {
                      setState(() {
                        surfaceQuery = "";
                      });
                      updateFilterTournaments();
                      controllerSurface.clear();
                    },
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 5, horizontal: 7.0),
              padding: EdgeInsets.symmetric(horizontal: 5.0),
              // height: 40,
              color: Colors.white,
              // padding: EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: TextField(
                      controller: controllerGrade,
                      style: TextStyle(
                        fontSize: 20,
                      ),

                      decoration: InputDecoration.collapsed(
                          fillColor: Colors.white,

                          // filled: true,
                          hintText: "Search Tournament Grade"),
                      keyboardType: TextInputType.text,
                      textAlign: TextAlign.start,
                      // textAlignVertical: TextAlignVertical.center,
                      onChanged: (value) {
                        print("REACHING $value");
                        setState(() {
                          gardeQuery = value;
                        });
                        updateFilterTournaments();
                      },
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.clear),
                    onPressed: () {
                      setState(() {
                        gardeQuery = "";
                      });
                      updateFilterTournaments();
                      controllerGrade.clear();
                    },
                  )
                ],
              ),
            ),
            array.length <= 0
                ? Center(child: Text("No Results Found"))
                : Expanded(
                    child: Container(
                    child: ListView.builder(
                      controller: _scrollController,
                      itemCount: array.length,
                      itemBuilder: (BuildContext context, int index) {
                        checkDateChange();
                        return ITFCardRender(array[index], imageUrl, index);
                      },
                    ),
                  ))
          ],
        ),
      );
    }
  }
}
