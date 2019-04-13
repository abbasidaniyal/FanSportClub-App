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
                  """Sportsmen with interest in Tennis,Badminton, Squash,T.T. & those eager to participate in tournaments, club events & sports as well can be a part of us.
                  
                  
FSC can facilitate in the following manner during the tournaments :- \n\n
1. Accommodation facility \n
2. Coaching facility \n
3. Racquet gutting facility \n
4. Sports accessories \n
5. Transportation facility \n
6. Jain meal or Pure veg meals \n
7. Swimming in expert trainer's assistance\n
8. Player's onsite Still or Videography by Hi resolution DSLR """,
                  textScaleFactor: 1,
                )),
          )
        ],
      ),
    );
  }
}
