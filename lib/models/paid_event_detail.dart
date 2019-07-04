import 'fsc_tournaments_event.dart';

 class PaidEventDetails extends TournamentEvent {
  int localPaymentId;
  String razopPayPyamentId;
  String orderId;
  String tournamentName;

  PaidEventDetails({
    this.localPaymentId,
    this.orderId,
    this.razopPayPyamentId,
    this.tournamentName,
    ageCategory,
    entryFee,
    eventType,
    eventId,
  }) : super(
          ageCategory: ageCategory,
          entryFee: entryFee,
          eventType: eventType,
          id: eventId,
        );
}
