// import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:package_info/package_info.dart';

mixin AppVersionModel on Model {
  String appVersion;

  void getVersion() async {
    PackageInfo info = await PackageInfo.fromPlatform();
    appVersion = info.version;
    notifyListeners();
  }
}
