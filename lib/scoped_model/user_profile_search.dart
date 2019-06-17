import 'package:scoped_model/scoped_model.dart';

import '../models/user_profile.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import './baseUrl.dart';

mixin UserProfileModel on Model {
  List<UserProfile> playerProfiles = [];
  bool isProfileDataLoaded = false;
  List<dynamic> profiles = [];
  bool profileError = false;

  Future<bool> intiProfileData(String token) async {
    try {
      http.Response res =
          await http.get("$baseUrl/users/user-profile-list/", headers: {
        'Authorization': '$token',
      });
      if (res.statusCode != 200 && res.statusCode != 201)
        return false;
      else {
        profiles = [];
        profiles = json.decode(res.body);
        playerProfiles = [];

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
              id: players["player_id"]);
          playerProfiles.add(temp);
        }
        notifyListeners();
        return true;
      }
    } catch (e) {
      print("Error = $e");
      return false;
    }
  }
}
