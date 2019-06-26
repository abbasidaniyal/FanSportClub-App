import 'package:flutter/material.dart';

class UserProfile {
  String name;
  String backhandStyle;
  String strongHand;
  String city;
  String homeClub;
  String profession;
  String email;
  String roleModel;
  String cienNumber;
  String achievements;
  String dob;//TO DATETIME
  String profilePhotoUrl;
  String username;
  int id;

  String age() {
    return (DateTime.parse(dob.split("/").toString())
            .difference(DateTime.now()))
        .toString();
  }

  UserProfile(
      {@required this.name,
      @required this.dob,
      @required this.strongHand,
      @required this.backhandStyle,
      this.city,
      this.homeClub,
      this.id,
      this.roleModel,
      this.achievements,
      this.profilePhotoUrl});
}
