import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_calendar/flutter_calendar.dart';

import 'dart:convert';
import 'dart:async';

import './card.dart';

class FscPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _FscPage();
  }
}

class _FscPage extends State<FscPage>
    with AutomaticKeepAliveClientMixin<FscPage> {
  List<dynamic> array = [];
  bool isLoading = false;
  DateTime selectedDate;

  ScrollController _scrollController;
  final double elementHeight = 150.0;
  final String imageUrl = 'assets/logo.jpg';

  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    fetchData();
    selectedDate = DateTime.now();
    _scrollController = ScrollController(initialScrollOffset: 0.0);
  }

  void fetchData() {
    setState(() {
      isLoading = true;
    });

    http
        .get(
            "https://my-json-server.typicode.com/abbasidaniyal/DummyDB/tournaments")
        .then((http.Response response) {
      if (response.statusCode == 200) {
        array = (json.decode(response.body) as List);
        setState(() {
          isLoading = false;
        });
      } else {
        throw Exception("Error: Server did not respond");
      }
    });
  }

  void setSelectedDate(DateTime b) {
    setState(() {
      selectedDate = b;
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  int monthToInt(String month) {
    switch (month) {
      case "Jan":
        return 1;
        break;
      case "Feb":
        return 2;
        break;
      case "Mar":
        return 3;
        break;
      case "Apr":
        return 4;
        break;
      case "May":
        return 5;
        break;
      case "Jun":
        return 6;
        break;
      case "Jul":
        return 7;
        break;
      case "Aug":
        return 8;
        break;
      case "Sep":
        return 9;
        break;
      case "Oct":
        return 10;
        break;
      case "Nov":
        return 11;
        break;
      case "Dec":
        return 12;
        break;

      default:
        return 0;
    }
  }

  void checkDateChange() {
    DateTime d;
    for (int i = 0; i < array.length; i++) {
      if (array[i]["startDate"]["month"] == "Oct" ||
          array[i]["startDate"]["month"] == "Nov" ||
          array[i]["startDate"]["month"] == "Dec") {
        d = DateTime.parse(array[i]["year"] +
            (monthToInt(array[i]["startDate"]["month"])).toString() +
            array[i]["startDate"]["date"] +
            "T11000 Z");
      } else {
        d = DateTime.parse(array[i]["year"] +
            "0" +
            (monthToInt(array[i]["startDate"]["month"])).toString() +
            array[i]["startDate"]["date"] +
            " 12:00:00 Z");
          
      }

      if (d.isAfter(selectedDate) || d == selectedDate) {
        _scrollController.animateTo(i * elementHeight,
            duration: Duration(milliseconds: 1000), curve: Curves.ease);
        break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading == true) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return Column(
        children: <Widget>[
          Container(
            child: Calendar(
              onDateSelected: (a) => setSelectedDate(a),
            ),
          ),
          Expanded(
              child: ListView.builder(
            controller: _scrollController,
            itemCount: array.length,
            itemBuilder: (BuildContext context, int index) {
              checkDateChange();
              return CardRender(array[index], monthToInt, imageUrl);
            },
          ))
        ],
      );
    }
  }
}
