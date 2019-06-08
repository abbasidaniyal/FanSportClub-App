import 'package:flutter/material.dart';

import '../scoped_model/main.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter_calendar/flutter_calendar.dart';
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
  bool isLoading = false;
  List<FSCTournament> array = [];
  DateTime selectedDate;
  bool isDateChanged = false;

  ScrollController _scrollController;
  final double elementHeight = 150.0;
  String imageUrl = 'assets/logo-fsc.png';
  bool get wantKeepAlive => true;

  @override
  void initState() {  
    super.initState();
    MainModel model = ScopedModel.of(context);

    if (!model.isFSCLoaded) {
      model.getToken().then((_) {
        model.initFscData(model.token).then((_) {
          if (model.isFSCLoaded) {
            setState(() {
              array = model.fscTournaments;
              isLoading = false;
            });
          } else {
            setState(() {
              isLoading = true;
            });
          }
        });
        model.intiProfileData(model.token);
      });
    } else {
      setState(() {
        array = model.fscTournaments;
        isLoading = false;
      });
    }
    selectedDate = DateTime.now();
    isDateChanged = true;

    _scrollController = ScrollController(initialScrollOffset: 0.0);
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
      if (array.last.date.isBefore(selectedDate)) {
        _scrollController.animateTo(array.length * elementHeight,
            duration: Duration(milliseconds: 1000), curve: Curves.ease);
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

  @override
  Widget build(BuildContext context) {
    // print("BEFORE BUILD"+isLoading + array.length);

    if (isLoading == true || array.length <= 0) {
      MainModel model = ScopedModel.of(context);
      if (model.fscError == true) {
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
          child: Center(
            child: CircularProgressIndicator(
              backgroundColor: Theme.of(context).primaryColor,
            ),
          ),
        );
      }
    } else {
      return Container(
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
            Expanded(
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
      );
    }
  }
}
