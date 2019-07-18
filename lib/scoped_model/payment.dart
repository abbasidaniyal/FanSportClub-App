import 'dart:convert';

import 'package:Fan_Sports/scoped_model/baseUrl.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:scoped_model/scoped_model.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

mixin PaymentModel on Model {
  String orderID;
  int localPaymentId;

  Future<bool> getOrderId({
    String token,
    int eventID,
    int userID,
    String doublesPartner,
    Function showDialogFunction,
  }) async {
    try {
      http.Response res = await http.post("$baseUrl/payments/create-payment/",
          headers: {'Authorization': token, "Content-Type": "application/json"},
          body: json.encode({
            "event": eventID.toString(),
            "user": userID.toString(),
            "doubles_partner_name": doublesPartner,
          }));
      print(res.statusCode);
      if (res.statusCode == 400) {
        showDialogFunction(
            "You can not register for this tournament as you have exceeded the limit of participation or you have already registered for this event.");
        return false;
      }

      if (res.statusCode != 200 && res.statusCode != 201) {
        showDialogFunction(
            "Something went wrong. Try again or contact tounament admin");
        return false;
      }

      print(res.statusCode);
      print(res.body);
      orderID = json.decode(res.body)["order_id"];
      localPaymentId = json.decode(res.body)["payment_id"];
      notifyListeners();

      return true;
    } catch (error) {
      print("ERROR Create Order : $error");
      showDialogFunction(
          "Something went wrong. Try again or contact tounament admin");
      return false;
    }
  }

  Future<bool> payment({
    @required String address,
    @required String name,
    @required String description,
    @required String email,
    @required String contact,
    @required Function handlePaymentSuccess,
    @required Function handlePaymentError,
    @required Function handleExternalWallet,
  }) async {
    String apiKey = "rzp_test_YNtxPTIkfqT9x9";
    var options = {
      'key': apiKey,
      'name': name,
      'description': description,
      'order_id': orderID,
      'prefill': {'contact': contact, 'email': email}
    };

    Razorpay _razorpay = Razorpay();

    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWallet);

    await _razorpay.open(
      options,
    );

    _razorpay.clear();
    // _razorpay.clear();
    return true;
  }

  Future<bool> verifyPayment(
      String signature, String orderID, String paymentID, String token) async {
    try {
      http.Response res = await http.patch(
        "$baseUrl/payments/verify-payment/$localPaymentId",
        headers: {'Authorization': token, "Content-Type": "application/json"},
        body: json.encode({
          "razorpay_payment_id": paymentID,
          "razorpay_signature": signature,
          "two_way_auth": "C",
        }),
      );

      if (res.statusCode != 200 && res.statusCode != 201) return false;

      print(res.body);

      return true;
    } catch (error) {
      print("Error Verify Payment : $error");
      return false;
    }
  }
}
