import 'package:Fan_Sports/main.dart';
import './fsc_tournament.dart';
import 'package:flutter/foundation.dart';

import 'user_profile.dart';
import 'fsc_tournament.dart';

class GalleryImage {
  String imageUrl;
  List<UserProfile> taggedUserList;
  // FSCTournament tournamentTag;
  String tournamentName;
  String tournammentVenue;
  DateTime tournamentDate;
  String description;

  GalleryImage(
      {this.description,
      @required this.imageUrl,
      // this.tournamentTag,
      this.taggedUserList,
      this.tournamentDate,
      this.tournamentName,
      this.tournammentVenue});
}

// class TournamentImage {
//   FSCTournament tournament;
//   List<GalleryImage> tournamentImages;

//   TournamentImage({this.tournament, this.tournamentImages});
// }
