import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:Fan_Sports/models/user_profile.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './baseUrl.dart';

mixin Login on Model {
  UserProfile loggedInUser = UserProfile();
  String token;
  bool isUserSignedIn = false;

  FacebookLoginResult facebookSignedInUser;
  FacebookLogin facebookUser = FacebookLogin();
  GoogleSignInAuthentication googleSignInAuthentication;
  GoogleSignIn googleUser = GoogleSignIn();
  SharedPreferences _preferences;

  Future<bool> newUser(Map<String, String> newUserData) async {
    try {
      http.Response res = await http.post(
        "$baseUrl/users/create-user/",
        headers: {
          'Authorization': '$token',
          "Content-Type": "application/json"
        },
        body: json.encode(newUserData),
      );
      print(res.body);
      if (res.statusCode != 200 && res.statusCode != 201) return false;
      return true;
    } catch (error) {
      print("ERROR : $error");
      return false;
    }
  }

  Future<int> initLoggedInUser() async {
    http.Response res;
    try {
      res = await http.get(
        "$baseUrl/users/current-user",
        headers: {
          'Authorization': '$token',
        },
      );
      if (res.statusCode != 200 && res.statusCode != 201) return 1;
    } catch (error) {
      print("ERROR =" + error);
      return 1;
    }

    var userProfileID = json.decode(res.body)["profile"];
    print(userProfileID);

    http.Response res2;
    try {
      res2 = await http.get(
        "$baseUrl/users/user-profile-update/$userProfileID",
        headers: {
          'Authorization': '$token',
        },
      );
    } catch (error) {
      print("ERROR =" + error);
      return 1;
    }
    print("BODY " + res2.body);
    var userData = json.decode(res2.body);

    if (res2.statusCode != 200 && res2.statusCode != 201) return 1;
    loggedInUser = UserProfile(
      city: userData["city"] == null ? "" : userData["city"],
      dob: userData["date_of_birth"] == null
          ? null
          : DateTime.parse(userData["date_of_birth"]),
      backhandStyle: userData["backhand_style"] == "DOUBLE"
          ? BACKHANDSTYLE.DOUBLE
          : userData["backhand_style"] == "SINGLE"
              ? BACKHANDSTYLE.SINGLE
              : BACKHANDSTYLE.MIXED,
      name: userData["name"],
      roleModel: userData["role_model"],
      strongHand: userData["strong_hand"] == "LEFT"
          ? STRONGHAND.LEFT
          : STRONGHAND.RIGHT,
      homeClub: userData["home_club"],
      achievements: userData["achievements"],
      profilePhotoUrl: userData["profile_photo"],
      gender: userData["player_gender"] == "MALE" ? GENDER.MALE : GENDER.FEMALE,
      id: userData["player_id"],
    );

    if (userData["name"] == "") {
      notifyListeners();
      return 2;
    }

    notifyListeners();
    isUserSignedIn = true;
    return 3;
  }

  Future<Null> autoLogin(storedToken) async {
    //REFRESH TOKEN

    token = storedToken;
    await initLoggedInUser();
    notifyListeners();
    return;
  }

  Future<bool> logoutUser() async {
    token = null;
    loggedInUser = null;

    try {
      GoogleSignIn().disconnect().catchError((onError) {});
    } catch (e) {
      print("Error = $e");
    }
    try {
      FacebookLogin().logOut().catchError((onError) {});
    } catch (e) {
      print("Error = $e");
    }

    _preferences = await SharedPreferences.getInstance();
    _preferences.remove("accessToken");
    isUserSignedIn = false;
    await getGeneralToken("fsc", "fsc");
    notifyListeners();
    return true;
  }

  Future<bool> getGeneralToken(username, password) async {
    try {
      http.Response res = await http.post(
        "$baseUrl/api-token-auth/",
        body: {
          'username': username,
          'password': password,
        },
      );
      // print(res.body);
      if (res.statusCode != 200 && res.statusCode != 201) return false;

      token = "Token " + json.decode(res.body)["token"];

      // print(token);

      isUserSignedIn = false;
      notifyListeners();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> getLocalAuthToken(username, password) async {
    try {
      http.Response res = await http.post(
        "$baseUrl/api-token-auth/",
        body: {
          'username': username,
          'password': password,
        },
      );
      // print(res.body);
      if (res.statusCode != 200 && res.statusCode != 201) return false;

      token = "Token " + json.decode(res.body)["token"];
      _preferences = await SharedPreferences.getInstance();
      _preferences.setString("accessToken", token);
      // print(token);

      notifyListeners();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> googleSignIn() async {
    GoogleSignIn googleUser = GoogleSignIn();

    try {
      GoogleSignInAccount signedInUser = await googleUser.signIn();

      googleSignInAuthentication = await signedInUser.authentication;
      // print(googleSignInAuthentication.toString());

      return true;
    } catch (error) {
      print("Error = $error");
      return false;
    }
  }

  Future<bool> facebookSignIn() async {
    FacebookLogin facebookUser = FacebookLogin();

    try {
      facebookSignedInUser = await facebookUser
          .logInWithReadPermissions(["email", 'public_profile']);
      // print(facebookSignedInUser.accessToken.token);
      // print(facebookSignedInUser.status);
      // print(facebookSignedInUser.errorMessage);
      return true;
    } catch (error) {
      print("Error = $error");
      return false;
    }
  }

  Future<bool> serverFacebookOauth() async {
    try {
      http.Response res = await http.post("$baseUrl/users/oauth/login/", body: {
        "provider": "facebook",
        "access_token": facebookSignedInUser.accessToken.token,
      });
      // print(res.body);

      print("Facebook Token = ${facebookSignedInUser.accessToken.token}");
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> serverGoogleOauth() async {
    try {
      http.Response res = await http.post("$baseUrl/users/oauth/login/", body: {
        "provider": "google-oauth2",
        "access_token": googleSignInAuthentication.accessToken
      });
      // print("Google Token = " + res.body);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> convertGoogleToken() async {
    try {
      http.Response res =
          await http.post("$baseUrl/users/oauth/convert-token", body: {
        'grant_type': "convert_token",
        'client_id': 'L8s8yCGLgZwFmmcna6Z9Ly5gjjoDCiiVLeK2V4qK',
        'backend': 'google-oauth2',
        'token': googleSignInAuthentication.accessToken
      });
      print(res.body);
      var temp = json.decode(res.body);
      token = "Bearer " + temp["access_token"];
      _preferences = await SharedPreferences.getInstance();
      _preferences.setString("accessToken", token);
      // print(token);

      notifyListeners();
      return true;
    } catch (error) {
      print(error);
      notifyListeners();
      return false;
    }
  }

  Future<bool> convertFacebookToken() async {
    try {
      http.Response res =
          await http.post("$baseUrl/users/oauth/convert-token", body: {
        'grant_type': "convert_token",
        'client_id': 'L8s8yCGLgZwFmmcna6Z9Ly5gjjoDCiiVLeK2V4qK',
        'backend': 'facebook',
        'token': facebookSignedInUser.accessToken.token
      });
      print(res.body);
      var temp = json.decode(res.body);
      token = "Bearer " + temp["access_token"];
      _preferences = await SharedPreferences.getInstance();
      _preferences.setString("accessToken", token);
      print(token);
      notifyListeners();
      return true;
    } catch (error) {
      print(error);
      return false;
    }
  }

  Future<bool> updateProfile(
      Map<String, String> profileData, File profileImage) async {
    try {
      http.MultipartRequest request = http.MultipartRequest(
          "PATCH",
          Uri.parse(
              "$baseUrl/users/user-profile-update/${profileData["player_id"]}"));
      request.fields.addAll(profileData);
      if (profileImage != null)
        request.files.add(await http.MultipartFile.fromPath(
            "profile_photo", profileImage.path));

      http.StreamedResponse res = await request.send();
      print(res.statusCode);
      if (res.statusCode != 200 && res.statusCode != 201) return false;

      return true;
    } catch (e) {
      print("PROFILE ERROR : $e");
      return false;
    }
  }
}
