import 'package:flutter/material.dart';

class UserProfile {
  String firstName;
  String lastName;
  String backhandStyle;
  String strongHand;
  String city;
  String homeClub;
  String contactNumber;
  String profession;
  String email;
  String roleModel;
  String cienNumber;
  String achievements;
  String state;
  String dob;
  String profilePhotoUrl;

  String fullname() {
    return firstName + " " + lastName;
  }

  String age() {
    return (DateTime.parse(dob.split("/").toString())
            .difference(DateTime.now()))
        .toString();
  }

  UserProfile(
      {@required this.firstName,
      @required this.lastName,
      @required this.dob,
      @required this.strongHand,
      @required this.backhandStyle,
      this.city,
      this.state,
      this.homeClub,
      this.roleModel,
      this.achievements});
}
