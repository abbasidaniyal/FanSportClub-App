import 'package:http/http.dart';
import 'package:scoped_model/scoped_model.dart';
// import 'package:razorpay_plugin/razorpay_plugin.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

mixin PaymentModel on Model {
  Future<Null> payment() async {
    String apiKey = "rzp_test_EcwB4YZMeBEleN";
    Map<String, String> notes = new Map();
    notes.putIfAbsent('billing_address', () => "Somewhere on earth");
    notes.putIfAbsent('shipping_address', () => "Somewhere near India");

    Map<String, dynamic> options = new Map();
    options.putIfAbsent("name", () => "Mr John Doe");
    options.putIfAbsent(
        "image",
        () =>
            "https://s3.amazonaws.com/rzp-mobile/images/rzp.png"); // optional arguement
    options.putIfAbsent("description", () => "Testing razorpay transaction");
    options.putIfAbsent("amount", () => "10000");
    options.putIfAbsent("email", () => "omairkhan064@gmail.com");
    options.putIfAbsent("contact", () => "+918171331341");

    options.putIfAbsent("prefill",
        () => {"name": "John Doe", "email": "omairkhan064@gmail.com"});

    // additional notes support. https://docs.razorpay.com/docs/notes
    options.putIfAbsent("notes", () => notes);

    options.putIfAbsent("theme", () => "#4D68FF"); // optional arguement
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
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Do something when payment succeeds
    print(response.signature);
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
