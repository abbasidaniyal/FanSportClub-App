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
      int i = 0;
      galleryImages = [];
      temp.forEach((a) {
        print(i++);
        List<UserProfile> users = [];
        a["user_tags"].forEach((x) {
          users.add(
            UserProfile(
              city: x["city"],
              dob: DateTime.parse(x["date_of_birth"]),
              backhandStyle: x["backhand_style"] == "DOUBLE"
                  ? BACKHANDSTYLE.DOUBLE
                  : x["backhand_style"] == "SINGLE"
                      ? BACKHANDSTYLE.SINGLE
                      : BACKHANDSTYLE.MIXED,
              name: x["name"],
              roleModel: x["role_model"],
              strongHand: x["strong_hand"] == "RIGHT"
                  ? STRONGHAND.RIGHT
                  : STRONGHAND.LEFT,
              homeClub: x["home_club"],
              achievements: x["achievements"],
              profilePhotoUrl: x["profile_photo"],
              id: x["player_id"],
              gender:
                  x["player_gender"] == "MALE" ? GENDER.MALE : GENDER.FEMALE,
            ),
          );
        });
        print(i - 1);
        // print(a["tournament_tag"]["tournament_description"]);
        // print();
        // print();
        // var q = json.decode(source)
        // FSCTournament tournamentzz = ;
        // print(i);

        galleryImages.add(GalleryImage(
          imageUrl: a["image"],
          tournamentDate: DateTime.parse(a["tournament_tag"]["date"]),
          tournamentName: a["tournament_tag"]["tournament_name"],
          tournammentVenue: a["tournament_tag"]["tournament_venue"],
          // tournamentTag: FSCTournament(
          //   date: DateTime.parse(a["tournament_tag"]["date"]),
          //   description: a["tournament_tag"]["tournament_description"],
          //   tournamentName: a["tournament_tag"]["tournament_name"],
          //   venue: a["tournament_tag"]["tournament_venue"],
          // ),
          description: a["description"],
          taggedUserList: users,
        ));
      });
      notifyListeners();
      return true;
    } catch (e) {
      print("error: " + e.toString());
      return false;
    }
  }
}
