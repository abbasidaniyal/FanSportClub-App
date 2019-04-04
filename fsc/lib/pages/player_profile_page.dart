import 'package:flutter/material.dart';

import '../models/user_profile.dart';

class PlayerProfilePage extends StatelessWidget {
  UserProfile user;
  // TO BE MADEEEEEEEE
  PlayerProfilePage(this.user);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).accentColor,
      ),
      body: Container(
        child: Text(user.firstName),
      ),
    );
  }
}
