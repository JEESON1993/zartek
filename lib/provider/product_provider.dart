import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:zartech_machine_test/constants/appconstants.dart';
import 'package:zartech_machine_test/models/product_model.dart';
import 'package:zartech_machine_test/services/api_services.dart';
import 'package:http/http.dart' as http;

class StoreProvider extends ChangeNotifier {
  var store;
}
