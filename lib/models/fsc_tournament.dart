import 'package:Fan_Sports/models/fsc_tournaments_event.dart';

import 'user_profile.dart';

class FSCTournament {
  String tournamentName;
  DateTime date;
  String venue;
  // String ageGroup;

  String description;
  String locationURL;
  String contactEmail;
  int contactNumber;
  String contactPerson;
  UserProfile tournamentWinner;

  List<TournamentEvent> eventsList;

  FSCTournament(
      {this.tournamentName,
      this.date,
      this.venue,
      this.eventsList,
      this.description,
      this.locationURL,
      this.contactPerson,
      this.contactNumber,
      this.contactEmail,
      this.tournamentWinner});
}
