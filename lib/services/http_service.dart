// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

class HttpService {
  static getResponse(Uri url) async {
    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        return response.body;
      } else {
        print(response.statusCode);
        return null;
      }
    } on HttpException catch (e) {
      print(e.message);
      return null;
    }
  }
}
