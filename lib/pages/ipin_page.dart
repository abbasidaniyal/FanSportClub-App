import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../widget/button.dart';
import 'package:flutter/cupertino.dart';

import '../widget/drawer.dart';

class IPINPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: MyDrawer(),
        appBar: AppBar(
          title: Text(
            "Renew IPIN",
            textScaleFactor: 1,
            style: TextStyle(fontWeight: FontWeight.normal, fontSize: 20),
            textAlign: TextAlign.left,
          ),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: Container(
          // margin: EdgeInsets.only(top: 20.0),
          color: Color.fromRGBO(245, 245, 245, 0.8),
          child: ListView(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 15.0, bottom: 5.0),
                child: Center(
                  child: Text(
                    "IPIN",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    textScaleFactor: 1,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(15.0),
                child: Text(
                    """The IPIN (International Player Identification Number) is brought to you by the International Tennis Federation, the world governing body of tennis. 

All players who wish to compete in ITF Junior Circuit, ITF Pro Circuit, ITF Seniors Circuit or Uniqlo Wheelchair Tennis Tour tournaments are required to have a current IPIN Membership.

As well as allowing players to play in ITF tournaments, IPIN Membership provides access to the IPIN Online Service which helps you to manage your tennis career and keeps you up-to-date at all times! Pro Circuit players can also use the service to manage their tournament entries online.

You can obtain your IPIN Membership by paying the annual registration fee.""",
                    textScaleFactor: 1, style: TextStyle(fontSize: 17)),
              ),
              SizedBox(
                height: 35,
              ),
              Container(
                margin: EdgeInsets.all(10.0),
                padding: EdgeInsets.all(5.0),
                child: Center(child: MyButton("Renew IPIN", launchURL)),
              ),
            ],
          ),
        ));
  }
}

launchURL() async {
  const url = 'https://ipin.itftennis.com/login.asp';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
