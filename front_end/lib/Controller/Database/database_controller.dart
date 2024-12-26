// ignore_for_file: non_constant_identifier_names, unused_local_variable, constant_identifier_names

import 'dart:convert';
import 'dart:developer';
import 'package:front_end/Models/practise_model.dart';
import 'package:http/http.dart' as http;

class DatabaseController {
  static const String _END_POINT = 'http://192.168.100.62:5000';

  //  method to insert data into the Database (Create Method)
  Future<void> pushDataToBackEnd(String id, String name, String email) async {
    try {
      final body = Practise(
        id: id,
        email: email,
        name: name,
      ).toJson();
      final response = await http.post(
        Uri.parse('$_END_POINT/post'),
        headers: {
          'Content-type': 'application/json',
        },
        body: jsonEncode(body),
      );

      _handleResponse(response);
    } catch (error) {
      log(error.toString());
    }
  }

  //  method to get data from the backend
  Future<List<Practise>> getDataFromBackEnd() async {
    try {
      final response = await http.get(Uri.parse(_END_POINT));

      if (response.statusCode == 200) {
        // Parse the JSON response
        List<dynamic> jsonResponse = jsonDecode(response.body);
        // Convert the JSON response to a list of Practise objects
        List<Practise> practises =
            jsonResponse.map((json) => Practise.fromJson(json)).toList();
        log("Data Retrieved Successfully! ${response.statusCode}");
        return practises;
      } else {
        _handleGetResponse(response);
        return [];
      }
    } catch (error) {
      log(error.toString());
      return [];
    }
  }

  void _handleResponse(http.Response response) {
    if (response.statusCode == 200 || response.statusCode == 201) {
      log("Data Posted Successfully! ${response.statusCode}");
    } else if (response.statusCode == 300) {
      log("Error: Bad Request Error ${response.statusCode}");
    } else if (response.statusCode == 400) {
      log("Error Occurred! Page not found ${response.statusCode}");
    } else {
      log("No status code found!");
    }
  }

  void _handleGetResponse(http.Response response) {
    if (response.statusCode == 400) {
      log("Error: Bad Request ${response.statusCode}");
    } else if (response.statusCode == 404) {
      log("Error: Page not found ${response.statusCode}");
    } else {
      log("Error: Unexpected status code ${response.statusCode}");
    }
  }
}
