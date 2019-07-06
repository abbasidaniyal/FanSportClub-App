import 'package:Fan_Sports/models/fsc_tournaments_event.dart';
import 'package:Fan_Sports/pages/calendar_page.dart';
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
  Map<String, dynamic> paymentData = {};
  GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  void handlePaymentSuccess(PaymentSuccessResponse response) async {
    print("SUCCESS");
    print("Signature :" + response.signature);
    print("Payment ID :" + response.paymentId);
    print("Order ID :" + response.orderId);

    MainModel model = ScopedModel.of(context);

    bool success = await model.verifyPayment(
      response.signature,
      response.orderId,
      response.paymentId,
      model.token,
    );

    if (success) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) {
            return CalendarPage();
          },
        ),
      );
    }
  }

  void handlePaymentError(PaymentFailureResponse response) {
    print("ERROR");
    print("Message : " + response.message);
    print("Code : " + response.code.toString());
    errorDialog("Could not precess payment");
    // response.code
  }

  void handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet was selected
    print("WALLET");
    print(response.walletName);
    // print(response.);
  }

  void errorDialog(String errorText) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Error"),
            content: Text(errorText),
            actions: <Widget>[
              FlatButton(
                child: Text("Ok"),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          );
        });
    // showDialog(

    //   AlertDialog()
    // );
  }

  void _submitForm(context) async {
    MainModel model = ScopedModel.of(context);
    //validate and save and them send. Write validators
    if (_globalKey.currentState.validate()) {
      _globalKey.currentState.save();
      bool generateOrderId = await model.getOrderId(
        eventID: paymentData["eventID"],
        token: model.token,
        userID: model.loggedInUser.id,
        showDialogFunction: errorDialog,
      );
      if (generateOrderId) {
        bool success = await model.payment(
          contact: paymentData["contact"],
          email: paymentData["email"],
          name: paymentData["name"],
          address: paymentData["address"],
          description:
              "Registration for event : EVENT ID = ${paymentData['eventID']}, by user : USER ID + ${model.loggedInUser.id}",
          handleExternalWallet: handleExternalWallet,
          handlePaymentError: handlePaymentError,
          handlePaymentSuccess: handlePaymentSuccess,
        );
        if (success) {
        } else {}
      } else {}
    }
  }

  @override
  void initState() {
    MainModel model = ScopedModel.of(context);
    model.selectedEvent = model.selectedTournamentEvents.first;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    MainModel model = ScopedModel.of(context);
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
                  onSaved: (value) {
                    paymentData["name"] = value;
                    paymentData["userID"] = model.loggedInUser.id;
                  },
                  enabled: false,
                  initialValue: model.loggedInUser.name,
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
                child: FormField<TournamentEvent>(
                  validator: (value) {
                    // return value.isEmpty ? "Please enter a valid value" : null;
                  },

                  initialValue: model.selectedTournamentEvents.first,
                  onSaved: (value) {
                    paymentData["eventID"] = value.id;
                  },

                  //
                  builder: (FormFieldState<TournamentEvent> state) {
                    return InputDecorator(
                      decoration: InputDecoration(
                        disabledBorder: InputBorder.none,
                        labelText:
                            "Select Event in ${model.selectedTournament.tournamentName}*",
                        labelStyle: TextStyle(
                            color: Colors.grey.shade700, fontSize: 15),
                        border: UnderlineInputBorder(),
                        contentPadding: EdgeInsets.all(5.0),
                      ),
                      child: ButtonTheme(
                        buttonColor: Colors.transparent,
                        padding: EdgeInsets.all(5.0),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<TournamentEvent>(
                            hint: Text(
                                "Select Event in ${model.selectedTournament.tournamentName}*"),
                            isDense: true,
                            isExpanded: true,
                            value: state.value,
                            style: TextStyle(
                              color: Colors.black,
                            ),
                            onChanged: (TournamentEvent newValue) {
                              setState(() {
                                state.didChange(newValue);
                                model.selectedEvent = newValue;
                              });
                            },
                            items: List<
                                    DropdownMenuItem<TournamentEvent>>.generate(
                                model.selectedTournamentEvents.length, (index) {
                              return DropdownMenuItem<TournamentEvent>(
                                value: model.selectedTournamentEvents[index],
                                child: Text(
                                  model.selectedTournamentEvents[index]
                                      .toString(),
                                  textScaleFactor: 1,
                                  maxLines: 1,
                                  style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.04,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.all(10.0),
                child: TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    return value.isEmpty ? "Please enter a valid value" : null;
                  },
                  onSaved: (value) {
                    paymentData["email"] = value;
                  },
                  // enabled: false,
                  initialValue: model.loggedInUser.email,
                  decoration: InputDecoration(
                    disabledBorder: InputBorder.none,
                    labelText: "Email Address*",
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
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    return value.isEmpty ? "Please enter a valid value" : null;
                  },
                  onSaved: (value) {
                    paymentData["contact"] = value;
                  },
                  // enabled: false,
                  // initialValue: model.loggedInUser.,
                  decoration: InputDecoration(
                    disabledBorder: InputBorder.none,
                    labelText: "Contact Number*",
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
                    labelText: "Billing Address*",
                    labelStyle:
                        TextStyle(color: Colors.grey.shade700, fontSize: 15),
                    border: UnderlineInputBorder(),
                    contentPadding: EdgeInsets.all(5.0),
                  ),
                  onSaved: (value) {
                    paymentData["address"] = value;
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10.0, left: 15, bottom: 20),
                child: Row(
                  children: <Widget>[
                    Container(
                      child: Text(
                        "Entry Fee : ",
                        style: TextStyle(
                            color: Colors.grey.shade700, fontSize: 15),
                      ),
                    ),
                    Container(
                      child: Text(
                        "₹ ${model.selectedEvent.entryFee.toString()}",
                        style: TextStyle(color: Colors.black, fontSize: 15),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.all(10.0),
                padding: EdgeInsets.all(5.0),
                child: Center(
                  child: MyButton(
                    "Submit",
                    _submitForm,
                    args: context,
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
