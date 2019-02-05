import 'package:flutter/material.dart';
import './calendar_page.dart';

class WelcomePage extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/Test.jpg"),
                fit: BoxFit.cover,
                repeat: ImageRepeat.noRepeat,
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.4), BlendMode.dstATop)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(20.0),
                padding: EdgeInsets.all(10.0),
                height: 150.0,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/logo.jpg"),
                    repeat: ImageRepeat.noRepeat,
                    alignment: Alignment.center,
                  ),
                ),
              ),
              RaisedButton(
                child: Text("Click to Continue"),
                color: Theme.of(context).accentColor,
                onPressed: () {
                  return Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => CalendarPage()));
                },
              )
            ],
          )),
    );
  }
}
