import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../models/fsc_tournament.dart';
import 'package:intl/intl.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:url_launcher/url_launcher.dart';

import '../scoped_model/main.dart';
import '../widget/button.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'payment_details_page.dart';
import 'player_profile_page.dart';

class FSCInfoPage extends StatefulWidget {
  final FSCTournament tournamentData;
  final int index;

  FSCInfoPage(this.tournamentData, this.index);

  @override
  _FSCInfoPageState createState() => _FSCInfoPageState();
}

class _FSCInfoPageState extends State<FSCInfoPage> {
  String website = "www.fansportsclub.com";
  bool isLoading = false;

  void changeStatus() {
    setState(() {
      isLoading = !isLoading;
    });
  }

  @override
  Widget build(BuildContext context) {
    MainModel model = ScopedModel.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          "Fan Sports Club",
          overflow: TextOverflow.fade,
          textScaleFactor: 1,
          style: TextStyle(fontWeight: FontWeight.normal, fontSize: 20),
          textAlign: TextAlign.left,
        ),
      ),
      body: Container(
        // padding: EdgeInsets.only(bottom: 30.0),
        constraints: BoxConstraints.expand(),
        child: Container(
          child: ListView(
            children: <Widget>[
              Image(
                image: AssetImage("assets/tournamentInfo.jpg"),
              ),
              Container(
                margin: EdgeInsets.only(top: 20.0, left: 25.0, right: 25.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10.0),
                      child: Text(
                        widget.tournamentData.tournamentName,
                        textScaleFactor: 1,
                        style: TextStyle(
                            fontWeight: FontWeight.values[5], fontSize: 18),
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 5.0),
                          child: Text(
                            "Date : ",
                            textScaleFactor: 1.1,
                            style: TextStyle(
                                fontWeight: FontWeight.values[5], fontSize: 15),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 5.0),
                          child: Text(
                            DateFormat("dd/MM/yyy")
                                .format(widget.tournamentData.date)
                                .toString(),
                            style: TextStyle(fontSize: 15),
                            textScaleFactor: 1,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 5.0),
                          child: Text(
                            "Venue : ",
                            maxLines: 2,
                            textScaleFactor: 1.1,
                            style: TextStyle(
                                fontWeight: FontWeight.values[5], fontSize: 15),
                          ),
                        ),
                        Flexible(
                          child: Container(
                            margin: EdgeInsets.symmetric(vertical: 5.0),
                            child: Text(
                              widget.tournamentData.venue.toString(),
                              textScaleFactor: 1,
                              maxLines: 5,
                              style: TextStyle(fontSize: 15),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 5.0),
                          child: Text(
                            "Age Group : ",
                            textScaleFactor: 1.1,
                            style: TextStyle(
                                fontWeight: FontWeight.values[5], fontSize: 15),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 5.0),
                          child: Text(
                            "",
                            // tournamentData.ageGroup.toString(),
                            textScaleFactor: 1,
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(top: 5.0),
                          child: Text(
                            "About: ",
                            textScaleFactor: 1.1,
                            style: TextStyle(
                                fontWeight: FontWeight.values[5], fontSize: 15),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 5.0),
                          child: Text(
                            widget.tournamentData.description.toString(),
                            textScaleFactor: 1,
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                      ],
                    ),
                    widget.tournamentData.contactPerson != null
                        ? Row(
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 5.0),
                                child: Text(
                                  "Contact Person : ",
                                  textScaleFactor: 1.1,
                                  style: TextStyle(
                                      fontWeight: FontWeight.values[5],
                                      fontSize: 15),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 5.0),
                                child: Text(
                                  widget.tournamentData.contactPerson,
                                  style: TextStyle(fontSize: 15),
                                  textScaleFactor: 1,
                                ),
                              ),
                            ],
                          )
                        : Container(),
                    widget.tournamentData.contactNumber != null
                        ? Row(
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 5.0),
                                child: Text(
                                  "Contact Number : ",
                                  textScaleFactor: 1.1,
                                  style: TextStyle(
                                      fontWeight: FontWeight.values[5],
                                      fontSize: 15),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 5.0),
                                child: InkWell(
                                  child: Container(
                                    child: Text(
                                      widget.tournamentData.contactNumber
                                          .toString(),
                                      style: TextStyle(
                                          color: Colors.blue[700],
                                          fontSize: 15),
                                      overflow: TextOverflow.clip,
                                      textScaleFactor: 1,
                                    ),
                                  ),
                                  onTap: () {
                                    launch(
                                      "tel://+91${widget.tournamentData.contactNumber}",
                                    );
                                  },
                                ),
                              ),
                            ],
                          )
                        : Container(),
                    widget.tournamentData.contactEmail != null
                        ? Row(
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 5.0),
                                child: Text(
                                  "Contact Email : ",
                                  textScaleFactor: 1.1,
                                  style: TextStyle(
                                      fontWeight: FontWeight.values[5],
                                      fontSize: 15),
                                ),
                              ),
                              Flexible(
                                child: Container(
                                  child: InkWell(
                                    child: Container(
                                      margin:
                                          EdgeInsets.symmetric(vertical: 5.0),
                                      child: Text(
                                        widget.tournamentData.contactEmail,
                                        style: TextStyle(
                                            color: Colors.blue[700],
                                            fontSize: 15),
                                        overflow: TextOverflow.ellipsis,
                                        textScaleFactor: 1,
                                      ),
                                    ),
                                    onTap: () {
                                      launch(
                                        "mailto:${widget.tournamentData.contactEmail}?subject=Tournament%20${widget.tournamentData.tournamentName}%20Enquiry%20From%20App",
                                      );
                                    },
                                  ),
                                ),
                              )
                            ],
                          )
                        : Container(),
                    Container(
                      child: Row(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 5.0),
                            child: Text(
                              "Website : ",
                              textScaleFactor: 1.1,
                              style: TextStyle(
                                  fontWeight: FontWeight.values[5],
                                  fontSize: 15),
                            ),
                          ),
                          GestureDetector(
                            child: Text(
                              website,
                              style: TextStyle(
                                  fontSize: 15, color: Colors.blue[700]),
                              textScaleFactor: 1,
                            ),
                            onTap: () {
                              launch("http://" + website);
                            },
                          ),
                        ],
                      ),
                    ),
                    widget.tournamentData.locationURL != null
                        ? Container(
                            child: Row(
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.symmetric(vertical: 5.0),
                                  child: Text(
                                    "Navigation : ",
                                    textScaleFactor: 1.1,
                                    style: TextStyle(
                                        fontWeight: FontWeight.values[5],
                                        fontSize: 15),
                                  ),
                                ),
                                Container(
                                  height: 20.0,
                                  child: ButtonTheme(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0)),
                                    child: RaisedButton(
                                      color: Theme.of(context).primaryColor,
                                      textColor: Theme.of(context).accentColor,
                                      child: Icon(
                                        MdiIcons.navigation,
                                        size: 15,
                                      ),
                                      onPressed: () {
                                        launch(
                                            widget.tournamentData.locationURL);
                                      },
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        : Container(),
                    widget.tournamentData.tournamentWinner != null
                        ? Container(
                            child: Row(
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.symmetric(vertical: 5.0),
                                  child: Text(
                                    "Winner : ",
                                    textScaleFactor: 1.1,
                                    style: TextStyle(
                                        fontWeight: FontWeight.values[5],
                                        fontSize: 15),
                                  ),
                                ),
                                GestureDetector(
                                  child: Container(
                                    margin: EdgeInsets.symmetric(vertical: 5.0),
                                    child: Text(
                                      widget
                                          .tournamentData.tournamentWinner.name,
                                      style: TextStyle(
                                          fontWeight: FontWeight.values[5],
                                          fontSize: 15,
                                          color: Colors.blue),
                                    ),
                                  ),
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(builder: (context) {
                                      return PlayerProfilePage(widget
                                          .tournamentData.tournamentWinner);
                                    }));
                                  },
                                ),
                              ],
                            ),
                          )
                        : Container(),
                    SizedBox(
                      height: 80.0,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      bottomSheet: model.isUserSignedIn
          ? Container(
              color: Theme.of(context).primaryColor,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.06,
              alignment: Alignment(0.0, 0.0),
              child: InkWell(
                child: isLoading
                    ? CircularProgressIndicator()
                    : Text(
                        "Register",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 24, color: Theme.of(context).accentColor),
                      ),
                onTap: () async {
                  //GO TO PAYMENT CONFIRMPAGE
                  changeStatus();
                  bool success = await model.selectTournamentGetEvents(
                      widget.tournamentData, model.token);
                  if (success) {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return PaymentConfirmPage();
                    })).then((onValue) {
                      changeStatus();
                    });
                  } else {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            content: Text("Please try again"),
                            title: Text("Something went wrong"),
                            actions: <Widget>[
                              FlatButton(
                                child: Text("Ok"),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              )
                            ],
                          );
                        });
                    changeStatus();
                  }
                },
              ))
          : Container(
              height: 0.0,
            ),
    );
  }
}
