import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter_calendar/flutter_calendar.dart';

import '../scoped_model/main.dart';
import '../models/fsc_tournament.dart';
import '../widget/fsc_card.dart';

class FscPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _FscPage();
  }
}

class _FscPage extends State<FscPage>
    with AutomaticKeepAliveClientMixin<FscPage> {
  bool isLoading = true;
  List<FSCTournament> array = [];
  List<FSCTournament> listFSCTournament = [];
  DateTime selectedDate;
  bool isSearchMode = false;
  TextEditingController controller = TextEditingController();

  bool isDateChanged = false;

  ScrollController _scrollController;
  final double elementHeight = 150.0;
  String imageUrl = 'assets/logo-fsc.png';
  bool get wantKeepAlive => true;
  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void initState() {
    super.initState();
    // MainModel model = ScopedModel.of(context);

    // if (!model.isFSCLoaded) {
    //   model.initFscData(model.token).then((_) {
    //     if (model.isFSCLoaded) {
    //       setState(() {
    //         array = model.fscTournaments;
    //         isLoading = false;
    //       });
    //     } else {
    //       setState(() {
    //         isLoading = true;
    //       });
    //     }
    //     model.intiProfileData(model.token);
    //   });
    // } else {
    //   setState(() {
    //     array = model.fscTournaments;
    //     isLoading = false;
    //   });
    // }
    initData();
    selectedDate = DateTime.now();
    isDateChanged = true;

    _scrollController = ScrollController(initialScrollOffset: 0.0);
  }

  void initData() async {
    MainModel model = ScopedModel.of(context);

    bool fscStatus = await model.initFscData(model.token);
    if (fscStatus) {
      setState(() {
        array = model.fscTournaments;
        listFSCTournament = model.fscTournaments;
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
    super.dispose();
    _scrollController.dispose();
  }

  void checkDateChange() {
    DateTime d;
    if (isDateChanged) {
      if (array.last.date.isBefore(selectedDate)) {
        _scrollController.animateTo(array.length * elementHeight,
            duration: Duration(
              milliseconds: 1000,
            ),
            curve: Curves.ease);
      } else {
        for (int i = 0; i < array.length; i++) {
          d = array[i].date;
          // print(d.toString() + "   " + selectedDate .toString());
          if (d.isAfter(selectedDate) || d == selectedDate) {
            _scrollController.animateTo(i * elementHeight,
                duration: Duration(milliseconds: 1000), curve: Curves.ease);
            break;
          }
        }
      }
      isDateChanged = false;
    }
  }

  void filterTournaments(String query) {
    print("REACHING ON CHANGE 1");
    List<FSCTournament> results = listFSCTournament
        .where(
          (a) => a.venue.toLowerCase().contains(
                query.toLowerCase(),
              ),
        )
        .toList();
    print("REACHING ON CHANGE 2");
    setState(() {
      array = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    // print("BEFORE BUILD"+isLoading + array.length);
    MainModel model = ScopedModel.of(context);

    if (isLoading == true) {
      return Container(
        child: Center(
          child: CircularProgressIndicator(
            backgroundColor: Theme.of(context).primaryColor,
          ),
        ),
      );
      // }
    } else {
      return Scaffold(
        body: Container(
          color: Color.fromRGBO(245, 245, 245, 0.8),
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(left: 5.0),
                child: Calendar(
                  onDateSelected: (a) => setSelectedDate(a),
                  isExpandable: false,
                  showTodayAction: false,
                ),
              ),
              isSearchMode
                  ? Container(
                      margin:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 24.0),
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      height: 40,
                      color: Colors.white,
                      // padding: EdgeInsets.symmetric(horizontal: 24),
                      child: Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width * 0.83,
                        child: TextField(
                          controller: controller,
                          style: TextStyle(
                            fontSize: 16,
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
                            filterTournaments(value);
                          },
                        ),
                      ),
                    )
                  : Container(),
              array.length <= 0
                  ? Center(child: Text("No Results Found"))
                  : Expanded(
                      child: Container(
                      margin: EdgeInsets.only(top: 10.0),
                      child: ListView.builder(
                        controller: _scrollController,
                        itemCount: array.length,
                        itemBuilder: (BuildContext context, int index) {
                          checkDateChange();

                          return FSCCardRender(array[index], imageUrl, index);
                        },
                      ),
                    )),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Theme.of(context).primaryColor,
          child: isSearchMode
              ? Icon(
                  Icons.clear,
                  color: Theme.of(context).accentColor,
                )
              : Icon(Icons.search, color: Theme.of(context).accentColor),
          onPressed: () {
            setState(() {
              filterTournaments("");
              controller.clear();
              isSearchMode = !isSearchMode;
            });
          },
        ),
      );
    }
  }
}
