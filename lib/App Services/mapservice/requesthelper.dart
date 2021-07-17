import 'dart:convert';

import 'package:http/http.dart' as http;

class RequestHelper {
  static Future<dynamic> getRequest(Uri url) async {
    http.Response responce = await http.get(url);
    try {
      if (responce.statusCode == 200) {
        String data = responce.body;
        var decodedData = jsonDecode(data);
        return decodedData;
      } else {
        return "failed";
      }
    } catch (e) {
      return "failed";
    }
  }
}
