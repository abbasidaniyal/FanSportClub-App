import 'package:scoped_model/scoped_model.dart';

import '../models/user_profile.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

mixin UserProfileModel on Model {
  List<UserProfile> playerProfiles = [];
  bool isProfileDataLoaded = false;
  List<dynamic> profiles = [];
  bool profileError = false;

  Future<void> intiProfileData(String token) async {
    playerProfiles = [];
    profiles = [];
    await http.get("http://api.fansportsclub.com/users/user-profile-list/",
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
            );
            playerProfiles.add(temp);
          }
          isProfileDataLoaded = true;
          notifyListeners();
        } else {
          profileError = true;
          notifyListeners();
        }
      },
    );
  }
}
