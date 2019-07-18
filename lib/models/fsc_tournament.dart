import 'package:Fan_Sports/models/fsc_tournaments_event.dart';

import 'user_profile.dart';

class FSCTournament {
  String tournamentName;
  DateTime date;
  String venue;
  int id;
  String ageGroup;

  String description;
  String locationURL;
  String contactEmail;
  int contactNumber;
  String contactPerson;
  UserProfile tournamentWinner;

  // List<TournamentEvent> eventsLis>t;

  FSCTournament({
    this.tournamentName,
    this.date,
    this.venue,
    this.id,
    // this.eventsList,
    this.description,
    this.locationURL,
    this.contactPerson,
    this.contactNumber,
    this.contactEmail,
    this.tournamentWinner,
    List<int> ageGroup,
  }) {
    this.ageGroup = "";
    ageGroup.forEach((f) {
      this.ageGroup += "+" + f.toString() + " ";
    });
  }

  // String ageCateroties() {}
}
