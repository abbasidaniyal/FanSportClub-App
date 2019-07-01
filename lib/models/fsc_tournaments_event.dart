class TournamentEvent {
  int eventID;
  double entryFee;
  String ageCategory;
  String ageCategoryDescription;
  String eventType;
  String eventTypeDescription;

  TournamentEvent(
      {this.ageCategory,
      this.ageCategoryDescription,
      this.entryFee,
      this.eventID,
      this.eventType,
      this.eventTypeDescription});
}
