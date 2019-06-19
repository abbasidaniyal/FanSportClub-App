import 'dart:async';
import 'dart:convert';

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
        galleryImages.add(GalleryImage(
          imageUrl: a["image"],
          // tournamentTag: a["tournament_tag"],
          description: a["description"],
          // taggedUserList: a["user_tags"],
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
