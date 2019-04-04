import 'package:flutter/material.dart';

import 'package:scoped_model/scoped_model.dart';
import '../models/itf_ranking.dart';

mixin ITFPlayerRankingModel on Model {
  List<ITFRanking> itfRanking = [];

  Future<Null> getRankingData() {
    //API INTEGRATION TO BE MADE

    ITFRanking a = ITFRanking(
        ageGroup: 35,
        category: "Doubles",
        dateOfBirth: "12-09-1998",
        events: 123,
        name: "Daniyal",
        movement: -5,
        points: 2252,
        rank: 6);

    ITFRanking b = ITFRanking(
        ageGroup: 35,
        category: "Doubles",
        dateOfBirth: "10-09-1998",
        events: 122,
        name: "Omair",
        movement: 2,
        points: 2252,
        rank: 4);

    itfRanking.add(a);
    itfRanking.add(b);
  }
}
