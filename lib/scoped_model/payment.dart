import 'package:http/http.dart';
import 'package:scoped_model/scoped_model.dart';
// import 'package:razorpay_plugin/razorpay_plugin.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

mixin PaymentModel on Model {
  Future<bool> payment({
    String address,
    String name,
    String description,
    String amountInRZPSyntax,
    String email,
    String contact,
  }) async {
    String apiKey = "rzp_test_EcwB4YZMeBEleN";
    Map<String, String> notes = new Map();
    notes.putIfAbsent('billing_address', () => address);
    notes.putIfAbsent('shipping_address', () => address);

    Map<String, dynamic> options = new Map();
    options.putIfAbsent("name", () => name);
    options.putIfAbsent(
        "image",
        () =>
            "https://s3.amazonaws.com/rzp-mobile/images/rzp.png"); // optional arguement
    options.putIfAbsent("description", () => description);
    options.putIfAbsent("amount", () => amountInRZPSyntax);
    options.putIfAbsent("email", () => email);
    options.putIfAbsent("contact", () => contact);

    options.putIfAbsent("prefill", () => {"name": name, "email": email});

    // additional notes support. https://docs.razorpay.com/docs/notes
    options.putIfAbsent("notes", () => notes);

    options.putIfAbsent("theme", () => "#C6ED2C"); // optional arguement
    options.putIfAbsent("key", () => apiKey);

    Map<dynamic, dynamic> paymentResponse = new Map();
    // paymentResponse = await Razorpay.showPaymentForm(options);

    Razorpay _razorpay = Razorpay();

    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);

    _razorpay.open(options);

    print("response $paymentResponse");
    // _razorpay.clear();
    return true;
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Do something when payment succeeds
    print("Success" + response.signature);
    print(response.paymentId);
    print(response.orderId);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
    print(response.message);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet was selected
    print(response.walletName);
  }
}
