import 'package:flutter/material.dart';
import './my_drawer.dart';
import 'package:http/http.dart' as http;

class CIENPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CIENPage();
  }
}

class _CIENPage extends State<CIENPage> {
  @override
  Widget build(BuildContext context) {
    final String cienPostUrl =
        "https://my-json-server.typicode.com/abbasidaniyal/DummyDB/db";
    final _formKey = GlobalKey<FormState>();
    String name, emailID;
    Map<String, String> userData;
    int age, contactNumber;
    DateTime dob;

    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(title: Text("CIEN Renewal")),
      body: Container(
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(10.0),
                child: Text(
                  "CIEN Registration",
                  textScaleFactor: 1.7,
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
                    labelText: "Full Name",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    ),
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
                    labelText: "Age",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    ),
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
                    labelText: "Email ID",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    ),
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
                    labelText: "Contact Number",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    ),
                    contentPadding: EdgeInsets.all(5.0),
                  ),
                ),
              ),
              Container(
                child: RaisedButton(
                  child: Text("Submit"),
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      userData = {
                        "name": name,
                        "age": age.toString(),
                        "contact": contactNumber.toString(),
                        "emailid": emailID
                      };
                      http.post(cienPostUrl, body: userData).then((response) {
                        if (response.statusCode != 200) {
                          print("ERROR");
                        }
                      });
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
