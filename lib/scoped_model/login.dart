import 'dart:async';

import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';

import './baseUrl.dart';

mixin Login on Model {
  String token;

  Future<bool> logoutUser() async {
    token = null;
    return true;
  }

  Future<bool> getGeneralToken(username, password) async {
    try {
      http.Response res = await http.post(
        "$baseUrl/api-token-auth/",
        body: {'username': username, 'password': password},
      );
      if (res.statusCode != 200 && res.statusCode != 201) return false;

      token = res.body.substring(10, 50);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> googleSignIn() async {
    GoogleSignIn user = GoogleSignIn();
    try {
      GoogleSignInAccount signedInUser =
          await user.signIn().catchError((onError) {
        print("Error = $onError");

        return false;
      });
      GoogleSignInAuthentication gsa = await signedInUser.authentication;
      print(signedInUser.toString());
      print(gsa.toString());
      return true;
    } catch (error) {
      print("Error = $error");
      return false;
    }
  }

  Future<bool> facebookSignIn() async {
    FacebookLogin user = FacebookLogin();

    try {
      FacebookLoginResult signedInUser = await user.logInWithReadPermissions(
          ["email", 'public_profile']).catchError((onError) {
        print("Error = $onError");

        return false;
      });
      print(signedInUser.accessToken);
      print(signedInUser.status);
      print(signedInUser.errorMessage);
      return true;
    } catch (error) {
      print("Error = $error");
      return false;
    }
  }
}
