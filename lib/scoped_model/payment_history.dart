import 'package:Fan_Sports/models/fsc_tournaments_event.dart';
import 'package:Fan_Sports/models/paid_event_detail.dart';
import 'package:Fan_Sports/scoped_model/baseUrl.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;

mixin PaymentHistoryModel on Model {
  List<PaidEventDetails> paymentHistoryList = [];

  Future<bool> getPaymentHistory(String token, int userID) async {
    try {
      http.Response res =
          await http.get('$baseUrl/payments/payment-history/$userID', headers: {
        'Authorization': '$token',
      });
      

      if (res.statusCode != 200 && res.statusCode != 201) return false;
      print(res.body);
    } catch (error) {
      print("ERROR Payment History : $error");
    }
  }
}
