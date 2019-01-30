import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_calendar/flutter_calendar.dart';

import 'dart:core';

import 'dart:convert';

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
  bool get wantKeepAlive => true;

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

        // array.sort((a,b)=> a.get('name').compareTo(b('name'))  );

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
