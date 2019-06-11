import 'package:Fan_Sports/main.dart';
import 'package:flutter/foundation.dart';

import 'user_profile.dart';
import 'fsc_tournament.dart';

class GalleryImage {
  String imageUrl;
  List<UserProfile> taggedUserList;
  FSCTournament tournamentTag;
  String description;

  GalleryImage({
    this.description,
    @required this.imageUrl,
    // @required
    this.tournamentTag,
    this.taggedUserList,
  });
}
