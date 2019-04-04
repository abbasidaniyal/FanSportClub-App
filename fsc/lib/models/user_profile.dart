import 'package:flutter/material.dart';

class UserProfile {
  String firstName;
  String lastName;
  String playStyle;
  String city;
  String state;
  String dob;

  String fullname() {
    return firstName + " " + lastName;
  }

  UserProfile(
      {@required this.firstName,
      @required this.lastName,
      @required this.city,
      @required this.dob,
      @required this.playStyle,
      @required this.state});
}
