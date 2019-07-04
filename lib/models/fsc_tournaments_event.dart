import 'package:flutter/material.dart';

class TournamentEvent {
  @required
  int id;
  @required
  int entryFee;
  @required
  int ageCategory;
  @required
  String eventType;

  TournamentEvent({this.id, this.ageCategory, this.entryFee, this.eventType});

  @override
  String toString() {
    return eventType + " +" + ageCategory.toString();
  }
}
