import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

mixin SendCIENMail on Model {

  Future<bool> mail(data) async {
    bool response;
    await http
        .post(
      "http://13.127.130.195:8000/form/",
      body: json.encode(data),
    )
        .then((res) {
      if (res.statusCode != 200) {
        response= false;
      } else {
        response= true;
      }
      notifyListeners();
    });
    return response;
  }
}
