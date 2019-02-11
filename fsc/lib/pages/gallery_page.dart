import "package:flutter/material.dart";

import './drawer.dart';

class GalleryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(title: Text("Fan Sport Club"),backgroundColor:Theme.of(context).accentColor,
          ),
      body: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(5.0),
            padding: EdgeInsets.all(2.0),
            child: Center(
                child: Text(
              "Gallery",
              textScaleFactor: 2.5,
            )),
          ),
          SizedBox(
            height: 10.0,
          ),
          Column(
            children: <Widget>[
              Card(
                child: Image.asset("assets/logo.jpg"),
              )
              
            ],
          )
        ],
      ),
    );
  }
}
