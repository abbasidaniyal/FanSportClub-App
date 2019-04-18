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
  String state;
  String dob;
  String profilePhotoUrl;


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
      this.state,
      this.homeClub,
      this.roleModel,
      this.achievements,
      this.profilePhotoUrl});
}
