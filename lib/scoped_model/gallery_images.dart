import 'dart:async';
import 'dart:convert';

import 'package:Fan_Sports/models/fsc_tournament.dart';
import 'package:Fan_Sports/models/user_profile.dart';
import 'package:scoped_model/scoped_model.dart';
import '../models/gallery_image.dart';
import 'baseUrl.dart';
import 'package:http/http.dart' as http;

mixin GalleryModel on Model {
  List<GalleryImage> galleryImages = [];

  Future<bool> loadGalleryImages(token) async {
    try {
      http.Response response = await http.get("$baseUrl/gallery/", headers: {
        'Authorization': '$token',
      });
      if (response.statusCode != 200 && response.statusCode != 201)
        return false;

      var temp = json.decode(response.body);

      print(temp);
      //GET TOURNAMENT IMAGES AND USER DETAILS
      galleryImages = [];
      temp.forEach((a) {
        List<UserProfile> users = [];
        a["user_tags"].forEach((x) {
          users.add(
            UserProfile(
                city: x["city"],
                dob: x["date_of_birth"],
                backhandStyle: x["backhand_style"],
                name: x["name"],
                roleModel: x["role_model"],
                strongHand: x["strong_hand"],
                homeClub: x["home_club"],
                achievements: x["achievements"],
                profilePhotoUrl: x["profile_photo"],
                id: x["player_id"]),
          );
        });
        galleryImages.add(GalleryImage(
          imageUrl: a["image"],
          tournamentTag: FSCTournament(
            // ageGroup: a["tournament_tag"]["age_group"],
            contactEmail: a["tournament_tag"]["coordinator_email"],
            contactNumber: a["tournament_tag"]["coordinator_contact_number"],
            contactPerson: a["tournament_tag"]["coordinator_name"],
            date: DateTime.parse(a["tournament_tag"]["date"]),
            description: a["tournament_tag"]["tournament_description"],
            locationURL: a["tournament_tag"]["event_location_url"],
            tournamentName: a["tournament_tag"]["tournament_name"],
            venue: a["tournament_tag"]["tournament_venue"],
          ),
          description: a["description"],
          taggedUserList: users,
        ));
      });
      notifyListeners();
      return true;
    } catch (e) {
      print("error: " + e);
      return false;
    }
  }
}
