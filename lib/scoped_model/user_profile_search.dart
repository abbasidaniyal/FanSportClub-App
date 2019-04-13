import 'package:scoped_model/scoped_model.dart';

import '../models/user_profile.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

mixin UserProfileModel on Model {
  List<UserProfile> playerProfiles = [];
  bool isProfileDataLoaded = false;
  List<dynamic> profiles = [];
  bool profileError = false;

  Future<Null> intiProfileData(String token) {

    http.get("http://13.127.130.195:8000/users/user-profile-list/",
        headers: {'Authorization': 'Token $token'}).then(
      (http.Response res) {
        if (res.statusCode == 200) {
          profiles = json.decode(res.body);
          for (var players in profiles) {
            UserProfile temp = UserProfile(
              city: players["city"],
              dob: players["date_of_birth"],
              backhandStyle: players["backhand_style"],
              name: players["name"],
              roleModel: players["role_model"],
              strongHand: players["strong_hand"],
              homeClub: players["home_club"],
              achievements: players["achievements"],
              profilePhotoUrl: players["profile_photo"],
              // state: players["city"]
            );
            playerProfiles.add(temp);

            isProfileDataLoaded = true;
            print("PROFILE DATA LOADED");
            notifyListeners();
          }
        } else {
          profileError = true;

          print("ERROR");
          notifyListeners();
        }
      },
    );
  }
}
