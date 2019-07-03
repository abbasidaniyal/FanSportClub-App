import 'package:Fan_Sports/pages/calendar_page.dart';
import 'package:Fan_Sports/widget/button.dart';
import 'package:flutter/material.dart';

import '../scoped_model/main.dart';
import 'package:scoped_model/scoped_model.dart';

class StatusPage extends StatelessWidget {
  StatusPage();

  @override
  Widget build(BuildContext context) {
    MainModel model = ScopedModel.of(context);
    print("Success");
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: <Widget>[
          Image.asset("assets/success.gif"),
          Container(
            padding: EdgeInsets.all(5.0),
            child: Text(
              "Success!",
              textScaleFactor: 2,
            ),
          ),
          MyButton("Go back to Home", () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) {
              return CalendarPage();
            }));
          }),

          // Container(
          //   padding: EdgeInsets.all(2.0),
          //   child: Text("Your booking ID : " + model.registrationID),
          // ),
          // Container(
          //   margin: EdgeInsets.all(7.0),
          //   child: model.registrationID.contains("GOLD")?Text("Do collect your gold passes!",textScaleFactor: 2,):Text(""),
          // )
        ],
      ),
    );
  }
}
