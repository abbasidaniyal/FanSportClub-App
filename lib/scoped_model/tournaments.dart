import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;

import '../models/fsc_tournament.dart';
import '../models/itf_tournament.dart';
import './baseUrl.dart';

mixin TournamentModel on Model {
  List<FSCTournament> fscTournaments = [];
  List<ITFTournament> itfTournaments = [];
  List<dynamic> fsc;
  List<dynamic> itf;
  bool isITFLoaded = false;
  bool isFSCLoaded = false;
  bool fscError = false;
  bool itfError = false;

  Future<bool> initItfData(String token) async {
    try {
      http.Response res =
          await http.get("$baseUrl/tournaments/tournaments-itf/", headers: {
        'Authorization': token,
        // 'Authorization': 'Bearer $token',
      });

      if (res.statusCode != 200 && res.statusCode != 201)
        return false;
      else {
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
        return true;
      }
    } catch (onError) {
      print("ERROR in ITF ");
    }
  }

  Future<bool> initFscData(String token) async {
    try {
      http.Response res = await http
          .get("$baseUrl/tournaments/tournaments-fsc/", headers: {
        'Authorization': token,
        // 'Authorization': 'Bearer $token'
      });
      if (res.statusCode != 200 && res.statusCode != 201)
        return false;
      else {
        //print(res.body);
        fscTournaments = [];
        fsc = json.decode(res.body);
        for (var event in fsc) {
          FSCTournament temp = FSCTournament(
            tournamentName: event["tournament_name"],
            ageGroup: event["age_group"],
            venue: event["tournament_venue"],
            date: DateTime.parse(event["date"] + " 12:00:00z"),
            description: event["tournament_description"],
            locationURL: event["event_location_url"],
            contactNumber: event["coordinator_contact_number"],
            contactEmail: event["coordinator_email"],
            contactPerson: event["coordinator_name"],
          );

          fscTournaments.add(temp);
        }
        fscTournaments.sort(
          (a, b) {
            return a.date.compareTo(b.date);
          },
        );
        return true;
      }
    } catch (onError) {
      print("ERROR");
      itfError = true;
      isITFLoaded = false;
      notifyListeners();
      return false;
    }

    //SORTING THE INCOMING ARRAY
  }
}
