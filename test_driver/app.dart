import 'package:flutter_driver/driver_extension.dart';
import 'package:soccer_app/main.dart' as app;
import 'package:flutter/material.dart';

void main() {
  try {
    enableFlutterDriverExtension();
    app.main();
  } catch (e) {
    print(e.toString());
  }
}
