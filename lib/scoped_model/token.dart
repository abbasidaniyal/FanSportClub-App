import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;

mixin TokenAuth on Model {
  String token;

  Future<void> getToken() async {

    await http.post(
      "http://api.fansportsclub.com/api-token-auth/",
      body: {'username': 'appuser', 'password': 'fansportsclubapp'},
    ).then((http.Response res) {
      token=res.body.substring(10,50);
      
    });
  }
}
