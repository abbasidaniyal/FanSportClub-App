import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;
import 'package:google_sign_in/google_sign_in.dart';

import './baseUrl.dart';

mixin Login on Model {
  String token;

  Future<void> getGeneralToken() async {
    await http.post(
      "$baseUrl/api-token-auth/",
      body: {'username': 'fsc', 'password': 'fsc'},
    ).then((http.Response res) {
      token = res.body.substring(10, 50);
    });
  }

  Future<bool> googleSignIn() async {
    GoogleSignIn user = GoogleSignIn();
    GoogleSignInAccount signedInUser = await user.signIn();

    GoogleSignInAuthentication gsa = await signedInUser.authentication;
    print(signedInUser.toString());
    print(gsa.toString());
    return true;
  }
}
