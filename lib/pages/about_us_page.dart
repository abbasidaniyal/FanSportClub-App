import "package:flutter/material.dart";

import '../widget/drawer.dart';

class AboutUsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        title: Text("Fan Sport Club"),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 30.0),
            child: Center(
              child: Text(
                "About us",
                textScaleFactor: 1.7,
              ),
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Expanded(
            child: SingleChildScrollView(
                padding: EdgeInsets.all(15.0),
                scrollDirection: Axis.vertical,
                controller: ScrollController(initialScrollOffset: 0.0),
                child: Text(
                  """FSC is an icon of Fan Sports Club where players participate in different type of games like Tennis, Badminton, Table tennis, Squash from distant places.

Using the FSC app players will be updated about national, international, club level tournaments with more number of players as participants performing on the grounds and simultaneously involving the senior players of the nation who sometimes think of their retirement from the sports.

Using the FSC app we facilitate people to easily login for the tournaments, know the whereabouts of the events happening in India and abroad with a single click on their Andriod or iOS devices. A player can have the entire information about his individual profile, national and international rank, events being held globally and the destination tourneys  organized time to time by the tennis fraternity. 

A player looking for a doubles partner, information about the tournaments held nearby, the fee structure and facilities provided, all this can be visualized by a single click at FSC.""",
                  textScaleFactor: 1.2
                ,
                )),
          )
        ],
      ),
    );
  }
}
