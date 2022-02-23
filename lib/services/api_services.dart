import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';
import 'dart:async';

import 'package:http/http.dart';
import 'package:zartech_machine_test/constants/appconstants.dart';

class ApiService {
  Future<dynamic> get(String url) async {
    //final String? token = await storage.read(key: "token");
    dynamic responseJson;
    try {
      final response =
          await http.get(Uri.parse(baseFullUrl + apiUrl + url), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        // 'Authorization': token != null ? 'Bearer $token' : '',
      });
      responseJson = _response(response);
    } on SocketException {
      Map<String, dynamic> check = {
        "error": 'Something went wrong, Try again later'
      };
      return Response(jsonEncode(check), 503);
    }
    return responseJson;
  }

  dynamic _response(http.Response response) {
    switch (response.statusCode) {
      case 200:
        return response;
      case 201:
        return response;
      case 400:
        return response;
      case 401:
        return response;
      case 403:
        return response;
      case 404:
        return response;
      case 409:
        return response;
      case 500:
        return response;
      case 503:
        return response;
      default:
      // throw FetchDataException(
      //     'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
