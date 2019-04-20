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
  bool isLoading = false;
  DateTime selectedDate;
  bool isDateChanged = false;

  ScrollController _scrollController;
  final double elementHeight = 140.0;
  final String imageUrl = 'assets/logoITF.jpg';
  List<ITFTournament> array = [];
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    MainModel model = ScopedModel.of(context);
    if (!model.isITFLoaded) {
      model.initItfData(model.token).then((s) {
        if (model.isITFLoaded) {
          setState(() {
            array = model.itfTournaments;
            isLoading = false;
          });
        } else {
          setState(() {
            isLoading = true;
          });
        }
      });
    } else {
      setState(() {
        array = model.itfTournaments;
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

  @override
  Widget build(BuildContext context) {
    if (isLoading == true || array.length <= 0) {
      MainModel model = ScopedModel.of(context);
      if (model.itfError == true) {
        return AlertDialog(
          content: Text("Server did not respond. \nPlease check your internet connection"),
          title: Text("ERROR"),
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
              color: Color.fromRGBO(245, 245, 245, 0.8),
              padding: EdgeInsets.only(left: 5.0),
              child: Calendar(
                onDateSelected: (a) => setSelectedDate(a),
                isExpandable: false,
                showTodayAction: false,
              ),
            ),
            Expanded(
                child: Container(
              child: ListView.builder(
                controller: _scrollController,
                itemCount: array.length,
                itemBuilder: (BuildContext context, int index) {
                  checkDateChange();
                  return ITFCardRender(array[index], imageUrl);
                },
              ),
            ))
          ],
        ),
      );
    }
  }
}
