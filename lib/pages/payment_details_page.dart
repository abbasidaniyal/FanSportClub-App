import 'package:Fan_Sports/models/fsc_tournaments_event.dart';
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

  @override
  void initState() {
    // TODO: implement initState
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
                  onSaved: (d) {},

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
                ),
              ),
              Container(
                margin: EdgeInsets.all(10.0),
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
                        style: TextStyle(
                            color: Colors.grey.shade700, fontSize: 15),
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
                    () async {
                      MainModel model = ScopedModel.of(context);
                      //validate and save and them send. Write validators
                      bool success = await model.payment();
                      if (success) {
                      } else {}
                    },
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
