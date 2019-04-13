import 'package:flutter/material.dart';
import '../widget/drawer.dart';
import '../widget/button.dart';
import '../scoped_model/main.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class CIENPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CIENPage();
  }
}

class _CIENPage extends State<CIENPage> {
  final _formKey = GlobalKey<FormState>();
  String name, emailID;
  Map<String, String> userData;
  int contactNumber;
  DateTime dob;

  void submitForm(context) {
    
    if (_formKey.currentState.validate()) {
      userData = {
        "Name ": name,
        "Contact Number ": contactNumber.toString(),
        "Email ID ": emailID,
        "Date Of Birth": dob.toString().split(" ")[0],
      };
      MainModel model = ScopedModel.of(context);
      model.mail(userData).then(
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
                margin: EdgeInsets.only(
                    top: 10.0, left: 10.0, right: 10.0, bottom: 2.0),
                padding: EdgeInsets.only(top: 5.0),
                child: Text(
                  "Please fill all the details to register your CIEN number.",
                  textScaleFactor: 1.2,
                  textAlign: TextAlign.left,
                ),
              ),
              Container(
                child: Text(
                  "   (All fields are mandatory*)",
                  textScaleFactor: 0.9,
                  textAlign: TextAlign.left,
                ),
              ),
              Container(
                margin: EdgeInsets.all(10.0),
                child: TextFormField(
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
                  validator: (value) {
                    if (value.isEmpty) return "Please enter a valid number";

                    contactNumber = int.parse(value);
                    if (contactNumber.isNaN ||
                        contactNumber > 9999999999 ||
                        contactNumber < 6000000000) {
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
                              top: 15.0, right: 10.0, bottom: 10.0, left: 10.0),
                          padding: EdgeInsets.all(10.0),
                          child: Text(
                            "Date of Birth*",
                            textScaleFactor: 1.1,
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
                                  dob.toString().split(" ")[0],
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
              SizedBox(
                height: 50.0,
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
