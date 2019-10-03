import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:scoped_model/scoped_model.dart';
import './pages/splash_screen_page.dart';
import './scoped_model/main.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
  
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  String token, refreshToken;
  preferences.containsKey("accessToken")
      ? token = preferences.get("accessToken")
      : token = null;
  preferences.containsKey("refreshToken")
      ? refreshToken = preferences.get("refreshToken")
      : refreshToken = null;
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((onValue) {
    runApp(MyApp(token, refreshToken));
  });
}

class MyApp extends StatelessWidget {
  final String token;
  final String refreshToken;
  MyApp(this.token, this.refreshToken);
  @override
  Widget build(BuildContext context) {
    return ScopedModel(
      model: MainModel(),
      child: MaterialApp(
        theme: ThemeData(
            buttonTheme: ButtonThemeData(),
            primaryColor: Color.fromRGBO(33, 33, 33, 1), //BLACK
            textSelectionColor: Color.fromRGBO(198, 237, 44, 1), //GREEN
            accentColor: Color.fromRGBO(198, 237, 44, 1),
            secondaryHeaderColor: Color.fromRGBO(33, 33, 33, 1),
            fontFamily: 'Roboto',
            textTheme: TextTheme(
              headline: TextStyle(
                color: Color.fromRGBO(198, 237, 44, 1),
              ),
              title: TextStyle(
                color: Color.fromRGBO(198, 237, 44, 1),
              ),
              caption: TextStyle(
                color: Color.fromRGBO(198, 237, 44, 1),
              ),
              subtitle: TextStyle(
                color: Colors.grey,
              ),
            )),
        routes: {
          "/": (BuildContext context) {
            MainModel model = ScopedModel.of(context);
            model.getVersion();
            // print("$token");
            token != null
                ? model.autoLogin(token, refreshToken)
                : model.getGeneralToken("fsc", "fsc");
            return WelcomePage(token, refreshToken);
          },
        },
      ),
    );
  }
}
