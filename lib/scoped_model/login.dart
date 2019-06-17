import 'dart:async';
import 'dart:convert';

import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';

import './baseUrl.dart';

mixin Login on Model {
  String token;
  bool isUserSignedIn;

  FacebookLoginResult facebookSignedInUser;
  FacebookLogin facebookUser = FacebookLogin();
  GoogleSignInAuthentication googleSignInAuthentication;
  GoogleSignIn googleUser = GoogleSignIn();

  Future<bool> logoutUser() async {
    token = null;
    isUserSignedIn = false;
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
      print(res.body);
      if (res.statusCode != 200 && res.statusCode != 201) return false;

      token = "Token " + json.decode(res.body)["token"];
      print(token);

      notifyListeners();
      isUserSignedIn = false;
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> googleSignIn() async {
    try {
      GoogleSignInAccount signedInUser = await googleUser.signIn();

      googleSignInAuthentication = await signedInUser.authentication;
      print(signedInUser.toString());
      print(googleSignInAuthentication.toString());

      return true;
    } catch (error) {
      print("Error = $error");
      return false;
    }
  }

  Future<bool> facebookSignIn() async {
    try {
      facebookSignedInUser = await facebookUser
          .logInWithReadPermissions(["email", 'public_profile']);
      print(facebookSignedInUser.accessToken.token);
      print(facebookSignedInUser.status);
      print(facebookSignedInUser.errorMessage);
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
      print(res.body);

      token = json.decode(res.body)["token"];
      print("Facebook Token = $token");
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
      print(res.body);
      // if (googleSignInAuthentication.idToken ==
      //     json.decode(res.body)["token"]) {
      //       //GET TOKEN FROM SERVER
      // } else {
      //   print("ID Token Does not match");
      //   return false;
      // }

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
      print(token);
      isUserSignedIn = true;
      return true;
    } catch (error) {
      print(error);
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
      print(token);
      isUserSignedIn = true;
      return true;
    } catch (error) {
      print(error);
      return false;
    }
  }
}