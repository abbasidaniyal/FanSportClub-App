import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

mixin SendCIENMail on Model {
  Future<bool> mail(data, token) async {
    bool response;
    await http
        .post(
      "http://13.127.130.195:8000/form/",
      headers: {
        'Authorization': 'Token $token',
        "Content-Type": "application/json"
      },
      body: json.encode(data),
    )
        .then((res) {
      print(json.encode(data));
      print(res.statusCode);
      print(res.body);
      if (res.statusCode != 200) {
        response = false;
      } else {
        response = true;
      }
      notifyListeners();
    });
    return response;
  }
}
