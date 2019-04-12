import 'package:flutter/material.dart';

import 'package:scoped_model/scoped_model.dart';
import '../models/itf_ranking.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

mixin ITFPlayerRankingModel on Model {
  List<ITFRanking> itfRanking = [];
  List<dynamic> ranking;
  bool isRankingLoaded = false;

  Future<Null> getRankingData(String token) {
    http.get("http://13.127.130.195:8000/tournaments/player-ranking-itf/",
        headers: {'Authorization': 'Token $token'}).then(
      (http.Response res) {
        if (res.statusCode == 200) {
          ranking = json.decode(res.body);
          for (var players in ranking) {
            ITFRanking temp = ITFRanking(
              ageGroup: int.parse(players["agegroup"]),
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
        }
      },
    );
  }
}
