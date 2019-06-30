import 'package:flutter/material.dart';

import 'package:scoped_model/scoped_model.dart';
import '../models/itf_ranking.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import './baseUrl.dart';

mixin ITFPlayerRankingModel on Model {
  List<ITFRanking> itfRanking = [];
  List<dynamic> ranking;
  bool isRankingLoaded = false;
  bool rankingError = false;

  Future<bool> getRankingData(String token) async {
    await http.get(
        "$baseUrl/tournaments/player-ranking-itf/",
        headers: {'Authorization': '$token',}).then(
      (http.Response res) {
        if (res.statusCode == 200) {
          itfRanking = [];
          ranking = json.decode(res.body);
          for (var players in ranking) {
            ITFRanking temp = ITFRanking(
              ageGroup: int.parse(players["age_group"]),
              category: players["category"],
              dateOfBirth: players["dob"].toString(),
              events: players["events"],
              movement: players["movement"],
              name: players["name"],
              points: players["points"],
              rank: players["rank"],
            );
            itfRanking.add(temp);

            isRankingLoaded = true;
            print("RANKING DATA LOADED");

            notifyListeners();
          }
        } else {
          print("ERROR");
          rankingError = true;
          notifyListeners();
        }
      },
    );
  }
//    * MOCK DATA *
//   void temp() {
//     ITFRanking temp;
//     temp = ITFRanking(
//       ageGroup: 35,
//       category: "D",
//       dateOfBirth: "1998",
//       events: 5,
//       movement: -3,
//       name: "Rahul Singh",
//       points: 1019,
//       rank: 35,
//     );
//     itfRanking.add(temp);

//     temp = ITFRanking(
//       ageGroup: 35,
//       category: "D",
//       dateOfBirth: "1998",
//       events: 5,
//       movement: -3,
//       name: "Mukul Singh",
//       points: 1019,
//       rank: 35,
//     );
//     itfRanking.add(temp);

//     isRankingLoaded = true;
//   }
}
