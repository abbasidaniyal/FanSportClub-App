import 'package:scoped_model/scoped_model.dart';
import '../models/user_profile.dart';
import 'package:google_sign_in/google_sign_in.dart';

mixin UserProfielModel on Model {
  UserProfile loggedInUser;
  GoogleSignIn googleSignIn = GoogleSignIn();

  Future<Null> signInWithGoogle() async {
    final GoogleSignInAccount googleAccount = await googleSignIn.signIn();

    final GoogleSignInAuthentication googleAuth =
        await googleAccount.authentication;
    print(googleAuth);
  }
}
