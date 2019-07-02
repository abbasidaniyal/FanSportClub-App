class TournamentEvent {
  int id;
  int entryFee;
  int ageCategory;
  String eventType;

  TournamentEvent({this.id, this.ageCategory, this.entryFee, this.eventType});

  @override
  String toString() {
    return eventType + " +" + ageCategory.toString();
  }
}
