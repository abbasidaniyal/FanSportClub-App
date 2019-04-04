import 'package:flutter/material.dart';

class ITFRanking {
  String name;
  int rank;
  int movement;
  String dateOfBirth;
  int events;
  double points;
  int ageGroup;
  String category;

  ITFRanking(
      {@required this.ageGroup,
      @required this.name,
      @required this.category,
      @required this.dateOfBirth,
      @required this.events,
      @required this.movement,
      @required this.points,
      @required this.rank});
}
