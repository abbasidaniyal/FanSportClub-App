import 'dart:io';

import 'package:Fan_Sports/pages/calendar_page.dart';
import 'package:Fan_Sports/scoped_model/main.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:scoped_model/scoped_model.dart';

import '../models/user_profile.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

class ProfileUpdatePage extends StatefulWidget {
  UserProfile user;

  ProfileUpdatePage(this.user);

  @override
  _ProfileUpdatePageState createState() => _ProfileUpdatePageState();
}

class _ProfileUpdatePageState extends State<ProfileUpdatePage> {
  File profileUploadedImage;
  Map<String, String> profileData = {};
  GlobalKey<FormState> _key = GlobalKey<FormState>();
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    profileData["player_id"] = widget.user.id.toString();
  }

  void submitProfile() async {
    setState(() {
      isLoading = true;
    });
    if (_key.currentState.validate()) {
      _key.currentState.save();
      print(profileData);
      MainModel model = ScopedModel.of(context);
      bool success =
          await model.updateProfile(profileData, profileUploadedImage);

      if (success) {
        model.initLoggedInUser().then(
          (status) {
            print(model.loggedInUser.backhandStyle);
            print(status);
            if (status == 3) {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return CalendarPage();
                  },
                ),
              );
            } else {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    content: Text("Something went wrong"),
                    actions: <Widget>[
                      FlatButton(
                        child: Text("Ok"),
                        onPressed: () {
                          Navigator.of(context).pop();
                          setState(() {
                            isLoading = false;
                          });
                        },
                      )
                    ],
                  );
                },
              );
            }
          },
        );
      } else {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text("Something went wrong"),
              actions: <Widget>[
                FlatButton(
                  child: Text("Ok"),
                  onPressed: () {
                    Navigator.of(context).pop();
                    setState(() {
                      isLoading = false;
                    });
                  },
                )
              ],
            );
          },
        );
      }
    }
    setState(() {
      isLoading = false;
    });
  }

  void uploadImage() async {
    File temp = await ImagePicker.pickImage(
      source: ImageSource.gallery,
    ).catchError(
      (onError) {
        print(onError.toString());
        return;
      },
    );
    setState(() {
      profileUploadedImage = temp;
    });
    print(profileUploadedImage);
  }

  @override
  Widget build(BuildContext context) {
    double nameSize = MediaQuery.of(context).size.width * 0.05;
    double dobSize = MediaQuery.of(context).size.width * 0.04;
    double headingSize = MediaQuery.of(context).size.width * 0.04;
    double contentSize = MediaQuery.of(context).size.width * 0.04;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          "Complete Player Profile",
          textScaleFactor: 1,
          style: TextStyle(fontWeight: FontWeight.normal, fontSize: 20),
          textAlign: TextAlign.left,
        ),
      ),
      body: Form(
        key: _key,
        child: ListView(
          children: <Widget>[
            Container(
              child: Stack(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.all(0),
                    // color: Theme.of(context).primaryColor,
                    width: MediaQuery.of(context).size.width,
                    alignment: Alignment.topCenter,
                    // height: MediaQuery.of(context).size.height * 0.40,
                    child: Image(
                      image: AssetImage("assets/playerBackground.jpg"),
                      width: MediaQuery.of(context).size.width,
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.40,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.50,
                              top: 35.0),
                          child: TextFormField(
                            decoration: InputDecoration(
                              hintText: "Name",
                              border: InputBorder.none,
                              filled: false,
                              contentPadding: EdgeInsets.zero,
                              hasFloatingPlaceholder: true,
                              errorStyle: TextStyle(height: 0.4),
                              hintStyle: TextStyle(
                                  color: Colors.white.withOpacity(0.6),
                                  fontWeight: FontWeight.w700,
                                  fontSize: nameSize),
                            ),
                            initialValue: widget.user.name,
                            onSaved: (name) {
                              profileData["name"] = name;
                            },
                            validator: (name) {
                              if (name.isEmpty) return "Please enter your name";
                            },
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: nameSize,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.50,
                              top: 10.0),
                          child: DateTimePickerFormField(
                            format: DateFormat("dd/MM/yyy"),
                            inputType: InputType.date,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: dobSize,
                            ),
                            editable: false,
                            resetIcon: null,
                            decoration: InputDecoration(
                              hintText: "Date of Birth",
                              border: InputBorder.none,
                              filled: false,
                              contentPadding: EdgeInsets.zero,
                              errorStyle: TextStyle(height: 0.4),
                              hintStyle: TextStyle(
                                color: Colors.white.withOpacity(0.6),
                                fontWeight: FontWeight.w700,
                                fontSize: dobSize,
                              ),
                              hasFloatingPlaceholder: true,
                            ),
                            onChanged: (value) {
                              setState(() {
                                widget.user.dob = value;
                              });
                            },
                            onSaved: (dateOfBirth) {
                              profileData["date_of_birth"] =
                                  dateOfBirth.toString().substring(0, 10);
                              print(profileData["date_of_birth"]);
                            },
                            validator: (DateTime value) {
                              print("object");
                              if (value == null) return "Invalid Date";
                              if (value.isAfter(DateTime.parse("2000-01-01"))) {
                                print("Working");
                                return "Invalid Date";
                              }
                            },
                            initialValue: widget.user.dob,
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            Container(
                              width: MediaQuery.of(context).size.width * 0.2,
                              margin: EdgeInsets.only(
                                  left:
                                      MediaQuery.of(context).size.width * 0.50,
                                  top: 20.0),
                              child: Text(
                                "GENDER",
                                textScaleFactor: 1,
                                maxLines: 1,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: headingSize),
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.2,
                              margin: EdgeInsets.only(left: 30.0, top: 20.0),
                              child: Text(
                                "AGE",
                                textScaleFactor: 1,
                                maxLines: 1,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: headingSize),
                              ),
                            )
                          ],
                        ),
                        Row(
                          // crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              width: MediaQuery.of(context).size.width * 0.2,
                              margin: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width * 0.50,
                              ),
                              child: FormField(
                                onSaved: (value) {
                                  profileData["player_gender"] =
                                      value == GENDER.MALE ? "MALE" : "FEMALE";
                                },
                                initialValue: widget.user.gender,
                                builder: (FormFieldState<GENDER> state) {
                                  return Theme(
                                      data: Theme.of(context).copyWith(
                                          canvasColor:
                                              Theme.of(context).primaryColor),
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton<GENDER>(
                                          value: state.value,
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                          onChanged: (GENDER newValue) {
                                            setState(() {
                                              state.didChange(newValue);
                                            });
                                          },
                                          items: [
                                            DropdownMenuItem(
                                              value: GENDER.MALE,
                                              child: Text(
                                                "Male",
                                                textScaleFactor: 1,
                                                maxLines: 1,
                                                style: TextStyle(
                                                  fontSize: contentSize,
                                                ),
                                              ),
                                            ),
                                            DropdownMenuItem(
                                              value: GENDER.FEMALE,
                                              child: Text(
                                                "Female",
                                                textScaleFactor: 1,
                                                maxLines: 1,
                                                style: TextStyle(
                                                  fontSize: contentSize,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ));
                                },
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                left: 30.0,
                              ),
                              width: MediaQuery.of(context).size.width * 0.2,
                              child: widget.user.dob == null
                                  ? Container()
                                  : Text(
                                      ((DateTime.now()
                                                  .difference(widget.user.dob)
                                                  .inDays) /
                                              365)
                                          .floor()
                                          .toString(),
                                      textScaleFactor: 1,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: contentSize),
                                    ),
                            )
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(
                                  left:
                                      MediaQuery.of(context).size.width * 0.05,
                                  top: 10),
                              width: MediaQuery.of(context).size.width * 0.4,
                              child: Text(
                                "BACKHAND STYLE",
                                textScaleFactor: 1,
                                maxLines: 1,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: headingSize),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                  left:
                                      MediaQuery.of(context).size.width * 0.05,
                                  top: 10),
                              width: MediaQuery.of(context).size.width * 0.4,
                              child: Text(
                                "STRONG HAND",
                                maxLines: 1,
                                textScaleFactor: 1,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: headingSize),
                              ),
                            )
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width * 0.05,
                              ),
                              width: MediaQuery.of(context).size.width * 0.4,
                              child: FormField(
                                onSaved: (value) {
                                  value == BACKHANDSTYLE.SINGLE
                                      ? profileData["backhand_style"] = "SINGLE"
                                      : value == BACKHANDSTYLE.DOUBLE
                                          ? profileData["backhand_style"] =
                                              "DOUBLE"
                                          : profileData["backhand_style"] =
                                              "BOTH";
                                },
                                initialValue: widget.user.backhandStyle,
                                builder: (FormFieldState<BACKHANDSTYLE> state) {
                                  return Theme(
                                    data: Theme.of(context).copyWith(
                                        canvasColor:
                                            Theme.of(context).primaryColor),
                                    child: ButtonTheme(
                                      buttonColor: Colors.transparent,
                                      padding: EdgeInsets.zero,
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton<BACKHANDSTYLE>(
                                          value: state.value,
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                          onChanged: (BACKHANDSTYLE newValue) {
                                            setState(() {
                                              state.didChange(newValue);
                                            });
                                          },
                                          items: [
                                            DropdownMenuItem(
                                              value: BACKHANDSTYLE.SINGLE,
                                              child: Text(
                                                "Single Handed",
                                                textScaleFactor: 1,
                                                maxLines: 1,
                                                style: TextStyle(
                                                  fontSize: contentSize,
                                                ),
                                              ),
                                            ),
                                            DropdownMenuItem(
                                              value: BACKHANDSTYLE.DOUBLE,
                                              child: Text(
                                                "Double Handed",
                                                textScaleFactor: 1,
                                                maxLines: 1,
                                                style: TextStyle(
                                                  fontSize: contentSize,
                                                ),
                                              ),
                                            ),
                                            DropdownMenuItem(
                                              value: BACKHANDSTYLE.MIXED,
                                              child: Text(
                                                "Mixed",
                                                textScaleFactor: 1,
                                                maxLines: 1,
                                                style: TextStyle(
                                                  fontSize: contentSize,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width * 0.05,
                              ),
                              width: MediaQuery.of(context).size.width * 0.4,
                              child: FormField(
                                onSaved: (newValue) {
                                  profileData["strong_hand"] =
                                      newValue == STRONGHAND.LEFT
                                          ? "LEFT"
                                          : "RIGHT";
                                },
                                builder: (FormFieldState<STRONGHAND> state) {
                                  return Theme(
                                    data: Theme.of(context).copyWith(
                                        canvasColor:
                                            Theme.of(context).primaryColor),
                                    child: ButtonTheme(
                                      buttonColor: Colors.transparent,
                                      padding: EdgeInsets.zero,
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton<STRONGHAND>(
                                          value: widget.user.strongHand == null
                                              ? STRONGHAND.RIGHT
                                              : widget.user.strongHand,
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                          onChanged: (STRONGHAND newValue) {
                                            setState(() {
                                              widget.user.strongHand = newValue;
                                            });
                                          },
                                          items: [
                                            DropdownMenuItem(
                                              value: STRONGHAND.LEFT,
                                              child: Text(
                                                "Left Handed",
                                                textScaleFactor: 1,
                                                maxLines: 1,
                                                style: TextStyle(
                                                  fontSize: contentSize,
                                                ),
                                              ),
                                            ),
                                            DropdownMenuItem(
                                              value: STRONGHAND.RIGHT,
                                              child: Text(
                                                "Right Handed",
                                                textScaleFactor: 1,
                                                maxLines: 1,
                                                style: TextStyle(
                                                  fontSize: contentSize,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.35,
                      height: MediaQuery.of(context).size.width * 0.35,
                      margin: EdgeInsets.only(top: 25, left: 20.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100.0),
                          color: Theme.of(context).primaryColor),
                      foregroundDecoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 3.0),
                        borderRadius: BorderRadius.circular(100.0),
                        image: DecorationImage(
                          image: profileUploadedImage == null
                              ? widget.user.profilePhotoUrl != null
                                  ? NetworkImage(widget.user.profilePhotoUrl)
                                  : AssetImage("assets/profilePicture.jpeg")
                              : FileImage(profileUploadedImage),
                        ),
                      ),
                    ),
                    onTap: uploadImage,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.08,
                    height: MediaQuery.of(context).size.width * 0.08,
                    margin: EdgeInsets.only(top: 130, left: 125.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100.0),
                        color: Theme.of(context).primaryColor),
                    child: IconButton(
                      icon: Icon(
                        Icons.add_a_photo,
                        color: Theme.of(context).accentColor,
                        size: 15.0,
                      ),
                      onPressed: uploadImage,
                    ),
                  )
                ],
              ),
            ),
            Container(
              color: Colors.white,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.45,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(2.0),
                ),
                margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(
                        left: 15.0,
                      ),
                      child: Text(
                        "Player Info",
                        textScaleFactor: 1,
                        style: TextStyle(
                            fontWeight: FontWeight.values[5], fontSize: 17),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20.0, left: 15.0),
                      child: Text(
                        "City",
                        textScaleFactor: 1,
                        style: TextStyle(color: Colors.grey[500]),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5.0, left: 15.0),
                      child: TextFormField(
                        decoration: InputDecoration.collapsed(
                          hintText: "Enter your city",
                        ),
                        style: TextStyle(fontWeight: FontWeight.values[0]),
                        initialValue:
                            widget.user.city == null ? "" : widget.user.city,
                        onSaved: (city) {
                          profileData["city"] = city;
                        },
                        validator: (city) {
                          if (city.isEmpty) return "Please enter your city";
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 15.0, left: 15.0),
                      child: Text(
                        "Home Ground/Club",
                        textScaleFactor: 1,
                        style: TextStyle(color: Colors.grey[500]),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5.0, left: 15.0),
                      child: TextFormField(
                        decoration: InputDecoration.collapsed(
                            hintText: "Enter your home club",
                            hintStyle: TextStyle(
                                // color: Colors.white.withOpacity(0.6),
                                )),
                        style: TextStyle(fontWeight: FontWeight.values[0]),
                        onSaved: (homeClub) {
                          profileData["home_club"] = homeClub;
                        },
                        initialValue: widget.user.homeClub == null
                            ? ""
                            : widget.user.homeClub,
                        validator: (homeClub) {
                          if (homeClub.isEmpty)
                            return "Please enter your home club";
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 15.0, left: 15.0),
                      child: Text(
                        "Role Model/Favorite Player",
                        textScaleFactor: 1,
                        style: TextStyle(color: Colors.grey[500]),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5.0, left: 15.0),
                      child: TextFormField(
                        decoration: InputDecoration.collapsed(
                          hintText: "Enter your Role Model",
                        ),
                        style: TextStyle(fontWeight: FontWeight.values[0]),
                        initialValue: widget.user.roleModel == null
                            ? ""
                            : widget.user.roleModel,
                        validator: (roleModel) {
                          if (roleModel.isEmpty)
                            return "Please enter your role model";
                        },
                        onSaved: (roleModel) {
                          profileData["role_model"] = roleModel;
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 15.0, left: 15.0),
                      child: Text(
                        "Achievements",
                        textScaleFactor: 1,
                        style: TextStyle(color: Colors.grey[500]),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5.0, left: 15.0),
                      child: TextFormField(
                        decoration: InputDecoration.collapsed(
                          hintText: "Enter your Achievements",
                        ),
                        style: TextStyle(fontWeight: FontWeight.values[0]),
                        initialValue: widget.user.achievements == null
                            ? ""
                            : widget.user.achievements,
                        maxLines: 10,
                        minLines: 1,
                        validator: (achievements) {
                          if (achievements.isEmpty)
                            return "Please enter your achievements";
                        },
                        onSaved: (achievements) {
                          profileData["achievements"] = achievements;
                        },
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Container(
          color: Theme.of(context).primaryColor,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.06,
          alignment: Alignment(0.0, 0.0),
          child: InkWell(
              child: isLoading
                  ? CircularProgressIndicator()
                  : Text(
                      "Submit Changes",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 24, color: Theme.of(context).accentColor),
                    ),
              onTap: submitProfile)),
    );
  }
}
