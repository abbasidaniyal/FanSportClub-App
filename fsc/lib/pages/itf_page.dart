import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_calendar/flutter_calendar.dart';

import 'dart:convert';

import './card.dart';

class ItfPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ItfPage();
  }
}

class _ItfPage extends State<ItfPage> with AutomaticKeepAliveClientMixin<ItfPage> {
  List<dynamic> array = [];
  bool isLoading = false;

  bool get wantKeepAlive=> true;

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

  @override
  void initState() {
    super.initState();
    fetchData();
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
            child: Calendar(),
          ),
          Expanded(
              child: ListView.builder(
            itemCount: array.length,
            itemBuilder: (BuildContext context, int index) {
              return CardRender(
                array[index]["name"],
                array[index]['grade'],
                array[index]["date"],
                array[index]["place"],
              );
            },
          ))
        ],
      );
    }
  }
}
