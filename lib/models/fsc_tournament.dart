import 'package:flutter/material.dart';

class FSCTournament {
  String tournamentName;
  DateTime date;
  String venue;
  String ageGroup;
  String description;

  FSCTournament(
      {this.tournamentName,
      this.date,
      this.venue,
      this.ageGroup,
      this.description});
}
