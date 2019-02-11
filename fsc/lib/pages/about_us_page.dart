import "package:flutter/material.dart";

import './drawer.dart';

class AboutUsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        title: Text("Fan Sport Club"),
        backgroundColor: Theme.of(context).accentColor,
      ),
      body: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(5.0),
            padding: EdgeInsets.all(2.0),
            child: Center(
                child: Text(
              "About us",
              textScaleFactor: 2.5,
            )),
          ),
          SizedBox(
            height: 10.0,
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(10.0),
              controller: ScrollController(initialScrollOffset: 0.0),
              children: <Widget>[
                Text(
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec sed tristique metus, sed faucibus arcu. Nulla scelerisque, felis condimentum pellentesque gravida, ipsum turpis cursus leo, eu sagittis erat lectus in purus. Curabitur ullamcorper lacus id massa varius molestie. Proin ligula diam, pellentesque et urna quis, tincidunt sollicitudin leo. Maecenas id efficitur velit. Donec tristique, lorem vitae laoreet vehicula, massa quam vestibulum arcu, at tincidunt nisi lectus pretium mauris. Nam hendrerit nulla sapien, eget efficitur eros facilisis at. Maecenas et viverra massa. In feugiat luctus nibh, a feugiat nulla. Aliquam feugiat quam quis risus bibendum, non bibendum justo dictum. Aenean lobortis vulputate euismod. Duis dictum porttitor venenatis. Maecenas a finibus ante, eget pharetra nisl. Quisque massa elit, fermentum sit amet nibh quis, sagittis sagittis arcu. Nunc varius velit urna, eu commodo leo tempor nec. In elementum malesuada neque quis faucibus. Suspendisse cursus nunc ipsum, quis malesuada neque lobortis mattis. Sed bibendum sapien purus, in accumsan magna mollis vel. Vestibulum malesuada venenatis felis, ac suscipit metus consequat at. Integer vehicula nunc id lacus hendrerit lobortis. Etiam eget nisi volutpat dui consequat ullamcorper id nec lectus. In condimentum nulla a aliquam placerat. Etiam euismod arcu quis sapien feugiat, eget sagittis lectus porta. Sed laoreet libero ac maximus luctus. Nulla imperdiet sem et ligula egestas efficitur. Quisque tincidunt vel orci vel lobortis. Donec sed tristique metus, sed faucibus arcu. Nulla scelerisque, felis condimentum pellentesque gravida, ipsum turpis cursus leo,")
              ],
            ),
          )
        ],
      ),
    );
  }
}
