import 'dart:convert';

import 'package:sunrise_sunset/models/auto_complete_model.dart';
import 'package:http/http.dart' as http;
import 'package:sunrise_sunset/models/sunride_sunset_model.dart';

class ApiServices {
  Future<AutoCompleteModel?> autoCompleteService(String placeName) async {
    try {
      var url =
          "https://geocoding-api.open-meteo.com/v1/search?name=$placeName&count=5";

      var response = await http.get(Uri.parse(url));
      print(response.body);
      if (response.statusCode == 200) {
        AutoCompleteModel autoCompleteModel =
            AutoCompleteModel.fromJson(json.decode(response.body));
        return autoCompleteModel;
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {}
    return null;
  }

    Future<Sunrise_Sunset_Model?> autoSunsetServiceService(double lat , double lng) async {
    try {
      var url =
          "https://api.sunrise-sunset.org/json?lat=$lat&lng=$lng";

      var response = await http.get(Uri.parse(url));
      print(response.body);
      if (response.statusCode == 200) {
      Sunrise_Sunset_Model  sunrise_sunset_model =
            Sunrise_Sunset_Model.fromJson(json.decode(response.body));
        return sunrise_sunset_model;
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {}
    return null;
  }
}
