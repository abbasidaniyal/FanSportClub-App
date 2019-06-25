import 'user_profile.dart';
class FSCTournament {
  String tournamentName;
  DateTime date;
  String venue;
  String ageGroup;
  String description;
  String locationURL;
  String contactEmail;
  int contactNumber;
  String contactPerson;
  UserProfile tournamentWinner;

  FSCTournament(
      {this.tournamentName,
      this.date,
      this.venue,
      this.ageGroup,
      this.description,
      this.locationURL,
      this.contactPerson,
      this.contactNumber,
      this.contactEmail,
      this.tournamentWinner});
}
