import 'fsc_tournaments_event.dart';

class PaidEventDetails extends TournamentEvent {
  int localPaymentId;
  String razopPayPyamentId;
  String orderId;
  
  PaidEventDetails({
    this.localPaymentId,
    this.orderId,
    this.razopPayPyamentId,
  });
}
