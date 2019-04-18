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
  bool fscError = false;
  bool itfError = false;

  Future<void> initItfData(String token) async {
    print("Reaching");
    await http.get("http://api.fansportsclub.com/tournaments/tournaments-itf/",
        headers: {'Authorization': 'Token $token'}).then(
      (http.Response res) {
        if (res.statusCode == 200) {
          itfTournaments = [];
          fsc = json.decode(res.body);
          for (var event in fsc) {
            ITFTournament temp = ITFTournament(
              name: event["tournament_name"],
              grade: event["grade"],
              venue: event["venue"],
              startDate:
                  DateTime.parse(event["start_date"].toString() + " 12:00:00z"),
              endDate:
                  DateTime.parse(event["end_date"].toString() + " 12:00:00z"),
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
          itfError = true;
          isITFLoaded = false;
        }
        notifyListeners();
      },
    );
  }

  Future<void> initFscData(String token) async {
    print("Reaching");
    print('Authorization: Token $token');
    await http.get("http://api.fansportsclub.com/tournaments/tournaments-fsc/",
        headers: {'Authorization': 'Token $token'}).then((http.Response res) {
      if (res.statusCode == 200) {
        //print(res.body);
        fscTournaments = [];
        fsc = json.decode(res.body);
        for (var event in fsc) {
          FSCTournament temp = FSCTournament(
              tournamentName: event["tournament_name"],
              ageGroup: event["age_group"],
              venue: event["tournament_venue"],
              date: DateTime.parse(event["date"] + " 12:00:00z"),
              description: event["tournament_description"]);
          // print(temp.description);
          fscTournaments.add(temp);
        }
        print(fscTournaments);
        isFSCLoaded = true;
      } else {
        print("ERROR");
        print(res.statusCode);
        isFSCLoaded = false;
        fscError = true;
        notifyListeners();
      }
    });

    //SORTING THE INCOMING ARRAY
    fscTournaments.sort(
      (a, b) {
        return a.date.compareTo(b.date);
      },
    );
  }
}