import 'package:flutter/material.dart';
import '../widget/drawer.dart';
import '../widget/button.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../pages/calendar_page.dart';

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
  int age, contactNumber;
  DateTime dob;

  void submitForm() {
    if (_formKey.currentState.validate()) {
      userData = {
        "name": name,
        "age": age.toString(),
        "contact": contactNumber.toString(),
        "emailid": emailID
      };

      http
          .post("http://13.127.130.195:8000/cienregistration/",
              body: json.encode(userData))
          .then((response) {
        if (response.statusCode != 200) {
          print("ERROR");
          return Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return CalendarPage();
              },
            ),
          );
        } else {
          return Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return CalendarPage();
              },
            ),
          );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        title: Text("CIEN Registration"),
        backgroundColor: Theme.of(context).accentColor,
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
                "Please fill all the details to renew your CIEN number.",
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
                  age = int.parse(value);

                  if (age.isNaN || age < 0 || age > 110) {
                    return "Please enter a valid age";
                  }
                },
                decoration: InputDecoration(
                  labelText: "Age*",
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
            SizedBox(
              height: 50.0,
            ),
            Container(
              margin: EdgeInsets.all(10.0),
              padding: EdgeInsets.all(5.0),
              child: Center(
                child: MyButton("Submit", submitForm),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
