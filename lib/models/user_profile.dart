import 'package:flutter/material.dart';

enum GENDER {
  MALE,
  FEMALE,
}

enum STRONGHAND { LEFT, RIGHT }

enum BACKHANDSTYLE {
  SINGLE,
  DOUBLE,
  MIXED,
}

class UserProfile {
  String name;
  BACKHANDSTYLE backhandStyle;
  STRONGHAND strongHand;
  String city;
  String homeClub;
  String profession;
  String email;
  String roleModel;
  String cienNumber;
  String achievements;
  DateTime dob; //TO DATETIME
  String profilePhotoUrl;
  String username;
  GENDER gender;
  int id;

  String age() {
    return ((dob).difference(DateTime.now())).toString();
  }

  UserProfile({
    this.name,
    this.dob,
    this.strongHand,
    this.backhandStyle,
    this.city,
    this.homeClub,
    @required this.id,
    this.roleModel,
    this.gender,
    this.email,
    this.achievements,
    this.profilePhotoUrl,
  });
}
