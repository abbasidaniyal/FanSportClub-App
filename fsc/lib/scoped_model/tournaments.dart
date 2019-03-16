import 'dart:async';

import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;

import '../models/fsc_tournament.dart';
import 'dart:convert';
import 'dart:core';
import '../models/itf_tournament.dart';


mixin TournamentModel on Model {
  List<FSCTournament> fscTournaments = [];
  List<ITFTournament> itfTournaments = [];
  List<dynamic> fsc;
  List<dynamic> itf;
  bool isITFLoaded = false;
  bool isFSCLoaded = false;

  Future<void> initItfData() async {
    print("Reaching");
    await http
        .get("http://13.127.130.195:8000/tournaments/itf/")
        .then((http.Response res) {
      if (res.statusCode == 200) {
        fsc = json.decode(res.body);
        for (var event in fsc) {
          ITFTournament temp = ITFTournament(
            name: event["name"],
            grade: event["grade"],
            venue: event["venue"],
            startDate: DateTime.parse(event["start_date"].toString()),
            endDate: DateTime.parse(event["end_date"].toString()),
            link: event["link"],
            website: event["website"],
            surface: event["surface"],
          );
          itfTournaments.add(temp);
        }
        isITFLoaded = true;
      } else {
        print("ERROR");
        print(res.statusCode);
        isITFLoaded = false;
      }
    });

    
  }

  Future<void> initFscData() async {
    print("Reaching");
    await http
        .get("http://13.127.130.195:8000/tournaments/fsc/")
        .then((http.Response res) {
      if (res.statusCode == 200) {
        //print(res.body);
        fsc = json.decode(res.body);
        for (var event in fsc) {
          FSCTournament temp = FSCTournament(
              tournamentName: event["name"],
              ageGroup: event["age_group"],
              venue: event["venue"],
              date: DateTime.parse(event["date"]),
              description: event["description"]);
          // print(temp.description);
          fscTournaments.add(temp);
        }
        print(fscTournaments);
        isFSCLoaded = true;
      } else {
        print("ERROR");
        print(res.statusCode);
        isFSCLoaded = false;
      }
    });

    //SORTING THE INCOMING ARRAY
    fscTournaments.sort((a, b) {
      return a.date.compareTo(b.date);
    });
  }
}
