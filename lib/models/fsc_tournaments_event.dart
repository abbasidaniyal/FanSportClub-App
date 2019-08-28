import 'package:flutter/material.dart';

class TournamentEvent {
  @required
  int id;
  @required
  int entryFee;
  @required
  int ageCategory;
  @required
  String typeOfEvent;
  String descriptionOfEvent;

  TournamentEvent({this.id, this.ageCategory, this.entryFee, this.descriptionOfEvent,this.typeOfEvent});

  @override
  String toString() {
    return typeOfEvent + " +" + ageCategory.toString();
  }
}
