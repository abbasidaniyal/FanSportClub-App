import 'package:scoped_model/scoped_model.dart';

import '../models/user_profile.dart';
import 'package:flutter/material.dart';

mixin UserProfileModel on Model {
  List<UserProfile> playerProfiles =[];
  Future<Null> intiProfileData() {

    UserProfile a = UserProfile(
        city: "Noida",
        dob: "17/00/1998",
        firstName: "Daniyal",
        lastName: "Abbasi",
        backhandStyle: "Single",
        strongHand: "Right",
        
        state: "UP",
        );
    UserProfile b = UserProfile(
        city: "Noida",
        dob: "17/00/1998",
        backhandStyle: "Double",
        firstName: "Omair",
        lastName: "Khan",
        strongHand: "Right",
        state: "UP");

    playerProfiles.add(a);
    playerProfiles.add(b);
    print(playerProfiles);
  }
}
