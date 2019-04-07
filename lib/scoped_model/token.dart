import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;

mixin TokenAuth on Model {
  String token;

  void getToken() {

    http.post(
      "http://13.127.130.195:8000/api-token-auth/",
      body: {'username': 'appuser', 'password': 'fansportsclubapp'},
    ).then((http.Response res) {
      print(res.body);
      token=res.body.substring(10,50);
      print(token);
    });
  }
}
