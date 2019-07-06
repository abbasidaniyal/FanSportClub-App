import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'package:Fan_Sports/models/user_profile.dart';
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
      http.Response res =
          await http.get("$baseUrl/tournaments/tournaments-fsc/", headers: {
        'Authorization': token,
        // 'Authorization': 'Bearer $token'
      });
      if (res.statusCode != 200 && res.statusCode != 201)
        return false;
      else {
        //print(res.body);
        fscTournaments = [];
        fsc = json.decode(res.body);
        for (var tournamentDetails in fsc) {
          List<int> ageGroup = [];
          tournamentDetails["events_tournament"].forEach((f) {
            ageGroup.add(f["category"]);
          });
          ageGroup.sort();
          FSCTournament temp = FSCTournament(
            tournamentName: tournamentDetails["tournament_name"],
            venue: tournamentDetails["tournament_venue"],
            date: DateTime.parse(tournamentDetails["date"] + " 12:00:00z"),
            description: tournamentDetails["tournament_description"],
            locationURL: tournamentDetails["tournamentDetails_location_url"],
            contactNumber: tournamentDetails["coordinator_contact_number"],
            id: tournamentDetails["id"],
            contactEmail: tournamentDetails["coordinator_email"],
            contactPerson: tournamentDetails["coordinator_name"],
            ageGroup: ageGroup,
            tournamentWinner: tournamentDetails["tournament_winner"] != null
                ? UserProfile(
                    city: tournamentDetails["tournament_winner"]["city"],
                    dob: DateTime.parse(tournamentDetails["tournament_winner"]
                        ["date_of_birth"]),
                    backhandStyle:
                        tournamentDetails["tournament_winner"]["backhand_style"] == "DOUBLE"
                            ? BACKHANDSTYLE.DOUBLE
                            : tournamentDetails["tournament_winner"]["backhand_style"] == "SINGLE"
                                ? BACKHANDSTYLE.SINGLE
                                : BACKHANDSTYLE.MIXED,
                    name: tournamentDetails["tournament_winner"]["name"],
                    roleModel: tournamentDetails["tournament_winner"]
                        ["role_model"],
                    strongHand:
                        tournamentDetails["tournament_winner"]["strong_hand"] == "LEFT"
                            ? STRONGHAND.LEFT
                            : STRONGHAND.RIGHT,
                    homeClub: tournamentDetails["tournament_winner"]
                        ["home_club"],
                    achievements: tournamentDetails["tournament_winner"]
                        ["achievements"],
                    profilePhotoUrl: tournamentDetails["tournament_winner"]
                        ["profile_photo"],
                    gender: tournamentDetails["tournament_winner"]["gender"] == "M"
                        ? GENDER.MALE
                        : GENDER.FEMALE,
                    id: tournamentDetails["tournament_winner"]["player_id"])
                : null,
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
      print("$onError ERROR");
      itfError = true;
      isITFLoaded = false;
      notifyListeners();
      return false;
    }

    //SORTING THE INCOMING ARRAY
  }
}
