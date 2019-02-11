import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:mongo_dart/mongo_dart.dart';

//DEBUG FROM WELCOME_PAGE after un Commenting

dynamic getData() {
  dynamic array;
  Db d = new Db("localhost:27017/fsic_tournaments");
  d.open();

  dynamic postt= d.collection('post');

  array=  postt.find();
  return print(array);

}
