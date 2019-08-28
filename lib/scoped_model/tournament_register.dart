import 'dart:convert';

import 'package:Fan_Sports/models/fsc_tournaments_event.dart';
import 'package:Fan_Sports/models/user_profile.dart';
import 'package:Fan_Sports/scoped_model/baseUrl.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;

import '../models/fsc_tournament.dart';

mixin TournamentReigisterModel on Model {
  FSCTournament selectedTournament;
  List<TournamentEvent> selectedTournamentEvents = [];
  TournamentEvent selectedEvent;

  Future<bool> selectTournamentGetEvents(
      FSCTournament tournament, String token, UserProfile user) async {
    try {
      selectedTournament = tournament;
      http.Response res = await http.get(
        "$baseUrl/tournaments/club-events/${selectedTournament.id}",
        headers: {
          'Authorization': '$token',
        },
      );
      print(res.body);
      if (res.statusCode != 200 && res.statusCode != 201) return false;

      List<dynamic> temp = json.decode(res.body);
      selectedTournamentEvents = [];
      temp.forEach((event) {
        TournamentEvent newEvent = TournamentEvent(
            ageCategory: event["category"],
            entryFee: event["price_of_event"],
            typeOfEvent: event["event_type"]["type_of_event"],
            descriptionOfEvent: event["event_type"]["description_of_type"],
            id: event["id"],
            );
        print(newEvent);
        if (newEvent.ageCategory <= user.userAge()) {
          selectedTournamentEvents.add(newEvent);
        }
        ;
      });
      return true;
    } catch (error) {
      print("ERROR : $error");
      return false;
    }
  }
}
