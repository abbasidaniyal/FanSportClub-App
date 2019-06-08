import 'package:http/http.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:razorpay_plugin/razorpay_plugin.dart';

mixin PaymentModel on Model {
  Future<Null> payment() async {
    String apiKey = "rzp_test_EcwB4YZMeBEleN";
    Map<String, String> notes = new Map();
    notes.putIfAbsent('billing_address', () => "Somewhere on earth");
    notes.putIfAbsent('shipping_address', () => "Somewhere near India");

    Map<String, dynamic> options = new Map();
    options.putIfAbsent("name", () => "Laptop");
    options.putIfAbsent(
        "image",
        () =>
            "https://s3.amazonaws.com/rzp-mobile/images/rzp.png"); // optional arguement
    options.putIfAbsent("description", () => "Testing razorpay transaction");
    options.putIfAbsent("amount", () => "100");
    options.putIfAbsent("email", () => "omairkhan064@gmail.com");
    options.putIfAbsent("contact", () => "+918171331341");

    // additional notes support. https://docs.razorpay.com/docs/notes
    options.putIfAbsent("notes", () => notes);

    options.putIfAbsent("theme", () => "#4D68FF"); // optional arguement
    options.putIfAbsent("api_key", () => apiKey);

    Map<dynamic, dynamic> paymentResponse = new Map();
    paymentResponse = await Razorpay.showPaymentForm(options);
    print("response $paymentResponse");
  }
}
