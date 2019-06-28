import 'package:Fan_Sports/widget/button.dart';
import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:flutter/widgets.dart';
import 'package:scoped_model/scoped_model.dart';
import '../scoped_model/main.dart';

class PaymentConfirmPage extends StatefulWidget {
  @override
  _PaymentConfirmPageState createState() => _PaymentConfirmPageState();
}

class _PaymentConfirmPageState extends State<PaymentConfirmPage> {
  var paymentData = {};
  GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  Map<String, dynamic> options = new Map();
    
  Future<Null> payment() async {
    String apiKey = "rzp_test_EcwB4YZMeBEleN";
    Map<String, String> notes = new Map();
    notes.putIfAbsent('billing_address', () => "Somewhere on earth");
    notes.putIfAbsent('shipping_address', () => "Somewhere near India");

    options.putIfAbsent("name", () => "Mr John Doe");
    options.putIfAbsent(
        "image",
        () =>
            "https://s3.amazonaws.com/rzp-mobile/images/rzp.png"); 
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

  void submitForm() async {
    bool success = await payment();
    if (success) {
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Payment Details"),
      ),
      body: Container(
        child: Form(
          key: _globalKey,
          child: ListView(
            children: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.width * 0.03,
                    horizontal: MediaQuery.of(context).size.width * 0.03),
                child: Text(
                  "Confirm and fill the Details then proceed",
                  textScaleFactor: 1.2,
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.03),
                child: Text(
                  "(All * fields are mandatory)",
                  textScaleFactor: 0.9,
                  textAlign: TextAlign.left,
                ),
              ),
              Container(
                margin: EdgeInsets.all(10.0),
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    return value.isEmpty ? "Please enter a valid value" : null;
                  },
                  decoration: InputDecoration(
                    disabledBorder: InputBorder.none,
                    labelText: "Full Name*",
                    labelStyle:
                        TextStyle(color: Colors.grey.shade700, fontSize: 15),
                    border: UnderlineInputBorder(),
                    contentPadding: EdgeInsets.all(5.0),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(10.0),
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    return value.isEmpty ? "Please enter a valid value" : null;
                  },
                  decoration: InputDecoration(
                    disabledBorder: InputBorder.none,
                    labelText: "Address*",
                    labelStyle:
                        TextStyle(color: Colors.grey.shade700, fontSize: 15),
                    border: UnderlineInputBorder(),
                    contentPadding: EdgeInsets.all(5.0),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(10.0),
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    return value.isEmpty ? "Please enter a valid value" : null;
                  },
                  decoration: InputDecoration(
                    disabledBorder: InputBorder.none,
                    labelText: "Full Name*",
                    labelStyle:
                        TextStyle(color: Colors.grey.shade700, fontSize: 15),
                    border: UnderlineInputBorder(),
                    contentPadding: EdgeInsets.all(5.0),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(10.0),
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    return value.isEmpty ? "Please enter a valid value" : null;
                  },
                  decoration: InputDecoration(
                    disabledBorder: InputBorder.none,
                    labelText: "Full Name*",
                    labelStyle:
                        TextStyle(color: Colors.grey.shade700, fontSize: 15),
                    border: UnderlineInputBorder(),
                    contentPadding: EdgeInsets.all(5.0),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(10.0),
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    return value.isEmpty ? "Please enter a valid value" : null;
                  },
                  decoration: InputDecoration(
                    disabledBorder: InputBorder.none,
                    labelText: "Full Name*",
                    labelStyle:
                        TextStyle(color: Colors.grey.shade700, fontSize: 15),
                    border: UnderlineInputBorder(),
                    contentPadding: EdgeInsets.all(5.0),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(10.0),
                padding: EdgeInsets.all(5.0),
                child: Center(
                  child: MyButton(
                    "Submit",
                    submitForm,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
