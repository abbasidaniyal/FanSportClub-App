import "package:flutter/material.dart";

import '../widget/drawer.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutUsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: MyDrawer(),
        appBar: AppBar(
          title: Text(
            "Fan Sports Club",
            style: TextStyle(fontWeight: FontWeight.normal,fontSize: 20),
            textScaleFactor: 1,
            textAlign: TextAlign.left,
            
          ),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: Container(
          child: Column(
            children: <Widget>[
              Flexible(
                child: ListView(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Image(
                      image: AssetImage("assets/about-cover.jpg"),
                    ),
                    Container(
                      padding: EdgeInsets.all(15.0),
                      margin: EdgeInsets.only(top: 15.0),
                      child: Center(
                        child: Text(
                          "About us",
                          style: TextStyle(fontSize: 20),
                          textScaleFactor: 1,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      padding: EdgeInsets.all(15.0),
                      child: Text(
                        """FSC is an icon of Fan Sports Club where players participate in different type of games like Tennis, Badminton, Table tennis, Squash from distant places.

Using the FSC app players will be updated about national, international, club level tournaments with more number of players as participants performing on the grounds and simultaneously involving the senior players of the nation who sometimes think of their retirement from the sports.

Using the FSC app we facilitate people to easily login for the tournaments, know the whereabouts of the events happening in India and abroad with a single click on their Andriod or iOS devices. A player can have the entire information about his individual profile, national and international rank, events being held globally and the destination tourneys  organized time to time by the tennis fraternity. 

A player looking for a doubles partner, information about the tournaments held nearby, the fee structure and facilities provided, all this can be visualized by a single click at FSC.""",
                        textScaleFactor: 1,
                        style: TextStyle(fontSize: 17),
                      ),
                    ),
                    SizedBox(
                      height: 25.0,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 15.0),
                      child: Text(
                        "For more information, mail us at :  ",
                        textScaleFactor: 1,
                        style: TextStyle(fontSize: 15),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 50.0),
                      padding: EdgeInsets.symmetric(horizontal: 15.0),
                      child: InkWell(
                        child: Container(
                          child: Text(
                            "avnish@fansportsclub.com",
                            style: TextStyle(color: Colors.blue[700],fontSize: 15),
                            overflow: TextOverflow.clip,
                            textScaleFactor: 1,
                          ),
                        ),
                        onTap: () {
                          launch(
                            "mailto:avnish@fansportsclub.com?subject=Enquiry%20From%20App",
                          );
                        },
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
