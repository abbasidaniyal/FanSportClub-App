import 'package:flutter/material.dart';
import '../widget/drawer.dart';
import '../widget/button.dart';
import '../scoped_model/main.dart';
import 'package:scoped_model/scoped_model.dart';

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
      print(userData);
      MainModel model = ScopedModel.of(context);
      model.mail(userData).then(
        (status) async {
          status = true;
          if (!status) {
            print("ERROR");
            // show
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
      body: Form(
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
            Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(
                      top: 5.0, right: 10.0, bottom: 10.0, left: 10.0),
                  padding: EdgeInsets.all(5.0),
                  child: Text(
                    "Date of Birth*",
                    textScaleFactor: 1.1,
                    style: TextStyle(color: Colors.grey.shade700),
                  ),
                ),
                Container(
                  margin: EdgeInsets.zero,
                  alignment: Alignment.centerLeft,
                  child: RaisedButton(
                    color: Theme.of(context).primaryColor,
                    textColor: Theme.of(context).accentColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0)),
                    child: dob == null
                        ? Text("Select Date of Birth")
                        : Text(dob.toString().split(" ")[0]),
                    onPressed: () async {
                      FocusManager().rootScope.detach();
                      DateTime d = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1940),
                        lastDate: DateTime(2030),
                      );

                      setState(
                        () {
                          dob = d;
                        },
                      );
                    },
                  ),
                ),
              ],
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
    );
  }
}
