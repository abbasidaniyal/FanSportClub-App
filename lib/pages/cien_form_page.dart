import 'package:flutter/material.dart';
import '../widget/drawer.dart';
import '../widget/button.dart';
import '../scoped_model/main.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:intl/intl.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class CIENPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CIENPage();
  }
}

class _CIENPage extends State<CIENPage> {
  final _formKey = GlobalKey<FormState>();
  String name, emailID, ipin, city, state;
  Map<String, String> userData;
  int contactNumber;
  DateTime dob;

  void submitForm(context) {
    if (_formKey.currentState.validate() && dob != null && state != null) {
      Scaffold.of(context).showSnackBar(
        SnackBar(
          duration: Duration(seconds: 3),
          content: Text("Processing..."),
        ),
      );
      userData = {
        "Name ": name,
        "Contact Number ": contactNumber.toString(),
        "Email ID ": emailID,
        "Date Of Birth": dob.toString().split(" ")[0],
        "IPIN": ipin,
        "City": city,
        "State": state,
      };
      MainModel model = ScopedModel.of(context);
      model.mail(userData, model.token).then(
        (status) async {
          if (!status) {
            Scaffold.of(context).showSnackBar(
              SnackBar(
                duration: Duration(seconds: 5),
                content: Text("Something went wrong :("),
                backgroundColor: Theme.of(context).primaryColor,
              ),
            );
          } else {
            setState(
              () {
                _formKey.currentState.reset();
                dob = null;
                state = null;
              },
            );
            Scaffold.of(context).showSnackBar(
              SnackBar(
                duration: Duration(seconds: 5),
                content: Text("Thank you! We will get back to you soon!"),
                backgroundColor: Theme.of(context).primaryColor,
              ),
            );
          }
        },
      );
    } else if (dob == null && state == null) {
      Scaffold.of(context).removeCurrentSnackBar();
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text("Date of Birth and State can not be empty"),
          duration: Duration(seconds: 3),
        ),
      );
    } else if (dob == null) {
      Scaffold.of(context).removeCurrentSnackBar();
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text("Date of Birth can not be empty"),
          duration: Duration(seconds: 3),
        ),
      );
    } else if (state == null) {
      Scaffold.of(context).removeCurrentSnackBar();
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text("State can not be empty"),
          duration: Duration(seconds: 3),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        title: Text("CIEN Registration"),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Container(
        margin: EdgeInsets.only(left: 8.0, right: 8.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.width * 0.03,
                    horizontal: MediaQuery.of(context).size.width * 0.03),
                child: Text(
                  "The CIEN (Contestant Individual Enrollment Number) is brought to you by FSC. All players who wish to compete in club tournaments, destination tourneys are required to have a CIEN. It provides access to tournament entries and keeps you up to date at all times. You can enter for tournaments by your CIEN online.\nPlease fill all the details to register for your CIEN number.",
                  textScaleFactor: 1.2,
                ),
              ),
              
              Container(
                child: Text(
                  "   (All * fields are mandatory)",
                  textScaleFactor: 0.9,
                  textAlign: TextAlign.left,
                ),
              ),
              Container(
                margin: EdgeInsets.all(10.0),
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    name = value;
                    return name.isEmpty ? "Please enter a valid value" : null;
                  },
                  decoration: InputDecoration(
                    disabledBorder: InputBorder.none,
                    labelText: "Full Name*",
                    border: UnderlineInputBorder(),
                    contentPadding: EdgeInsets.all(5.0),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(10.0),
                child: TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    emailID = value;
                    bool emailValid =
                        RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(emailID);

                    if (!emailValid) {
                      return "Invalid Email ID";
                    }
                  },
                  decoration: InputDecoration(
                    labelText: "Email ID*",
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
                    if (value.isEmpty) {
                      return "Please enter your number";
                    }

                    contactNumber = int.parse(value, onError: (error) {
                      return 0;
                    });
                    if (contactNumber > 9999999999 ||
                        contactNumber < 3000000000) {
                      return "Please enter a valid number";
                    }
                  },
                  decoration: InputDecoration(
                    labelText: "Contact Number*",
                    border: UnderlineInputBorder(),
                    contentPadding: EdgeInsets.all(5.0),
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  child: Container(
                    width: MediaQuery.of(context).size.width,

                    // height: 100.0,
                    child: Row(
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width * 0.4,
                          margin: EdgeInsets.only(
                              top: 20.0, right: 10.0, bottom: 10.0, left: 10.0),
                          padding: EdgeInsets.symmetric(horizontal: 5.0),
                          child: Text(
                            "Date of Birth*",
                            textScaleFactor: 1.15,
                            style: TextStyle(color: Colors.grey.shade700),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.4,
                          margin: EdgeInsets.zero,
                          alignment: Alignment.centerLeft,

                          // color: Theme.of(context).primaryColor,
                          // textColor: Theme.of(context).accentColor,
                          // shape: RoundedRectangleBorder(
                          //   borderRadius: BorderRadius.circular(5.0),
                          // ),
                          child: dob == null
                              ? Text("")
                              : Text(
                                  DateFormat("dd/MM/yyy").format(dob).toString().split(" ")[0],
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                        ),
                      ],
                    ),
                  ),
                  onTap: () async {
                    DatePicker.showDatePicker(
                      context,
                      showTitleActions: true,
                      currentTime: dob == null ? DateTime.now() : dob,
                      locale: LocaleType.en,
                      minTime: DateTime(1940, 1, 1),
                      maxTime: DateTime.now(),
                      onConfirm: (date) {
                        setState(
                          () {
                            dob = date;
                          },
                        );
                      },
                    );
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10.0),
                child: Divider(
                  color: Colors.black,
                  height: 7.0,
                ),
              ),
              Container(
                margin: EdgeInsets.all(10.0),
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  validator: (value) {},
                  decoration: InputDecoration(
                    disabledBorder: InputBorder.none,
                    labelText: "IPIN",
                    border: UnderlineInputBorder(),
                    contentPadding: EdgeInsets.all(5.0),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(10.0),
                child: TextFormField(
                  enableInteractiveSelection: true,
                  // inputFormatters: TextInputFormatter(),
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    city = value;
                    return city.isEmpty ? "Please enter a valid value" : null;
                  },
                  decoration: InputDecoration(
                    disabledBorder: InputBorder.none,
                    labelText: "City*",
                    border: UnderlineInputBorder(),
                    contentPadding: EdgeInsets.all(5.0),
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  child: Container(
                    width: MediaQuery.of(context).size.width,

                    // height: 100.0,
                    child: Row(
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width * 0.4,
                          margin: EdgeInsets.only(
                              top: 20.0, right: 10.0, bottom: 10.0, left: 10.0),
                          padding: EdgeInsets.symmetric(horizontal: 5.0),
                          child: Text(
                            "State*",
                            textScaleFactor: 1.15,
                            style: TextStyle(color: Colors.grey.shade700),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.4,
                          margin: EdgeInsets.zero,
                          alignment: Alignment.centerLeft,

                          // color: Theme.of(context).primaryColor,
                          // textColor: Theme.of(context).accentColor,
                          // shape: RoundedRectangleBorder(
                          //   borderRadius: BorderRadius.circular(5.0),
                          // ),
                          child: state == null
                              ? Text("")
                              : Text(
                                  state.toString(),
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                        ),
                      ],
                    ),
                  ),
                  onTap: () async {
                    Picker picker = Picker(
                      hideHeader: true,
                      title: Text(
                        "State",
                        textScaleFactor: 1.1,
                        style: TextStyle(color: Colors.grey.shade700),
                      ),
                      onConfirm: (Picker p, List l) {
                        setState(() {
                          state = p.getSelectedValues().join().toString();
                        });
                      },
                      adapter: PickerDataAdapter<String>(
                        pickerdata: [
                          'Andhra Pradesh',
                          'Andaman and Nicobar Islands',
                          'Arunachal Pradesh',
                          'Assam',
                          'Bihar',
                          'Chandigarh',
                          'Chhattisgarh',
                          'Dadra and Nagar Haveli',
                          'Daman and Diu',
                          'Delhi',
                          'Goa',
                          'Gujarat',
                          'Haryana',
                          'Himachal Pradesh',
                          'Jammu and Kashmir',
                          'Jharkhand',
                          'Karnataka',
                          'Kerala',
                          'Lakshadweep',
                          'Madhya Pradesh',
                          'Maharashtra',
                          'Manipur',
                          'Meghalaya',
                          'Mizoram',
                          'Nagaland',
                          'Odisha',
                          'Puducherry',
                          'Punjab',
                          'Rajasthan',
                          'Sikkim',
                          'Tamil Nadu',
                          'Telangana',
                          'Tripura',
                          'Uttarakhand',
                          'Uttar Pradesh',
                          'West Bengal',
                        ],
                      ),
                    );
                    picker.showDialog(context);
                  },
                ),
                // child: TextFormField(
                //   keyboardType: TextInputType.text,
                //   validator: (value) {
                //     state = value;
                //     return state.isEmpty ? "Please enter a valid value" : null;
                //   },
                //   decoration: InputDecoration(
                //     disabledBorder: InputBorder.none,
                //     labelText: "State*",
                //     border: UnderlineInputBorder(),
                //     contentPadding: EdgeInsets.all(5.0),
                //   ),
                // ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10.0),
                child: Divider(
                  color: Colors.black,
                  height: 7.0,
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Builder(
                builder: (context) {
                  return Container(
                    margin: EdgeInsets.all(10.0),
                    padding: EdgeInsets.all(5.0),
                    child: Center(
                      child: MyButton(
                        "Submit",
                        submitForm,
                        args: context,
                      ),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
