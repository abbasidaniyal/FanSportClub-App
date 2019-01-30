import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/cupertino.dart';


import './my_drawer.dart';

class IPINPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(title: Text("Renew IPIN")),
      body: Center(
        child: RaisedButton(
          onPressed: _launchURL,
          child: Text('Renew IPIN'),
        ),
      ),
    );
  }
}

_launchURL() async {
  const url = 'https://ipin.itftennis.com/login.asp';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
