import 'dart:convert';

import 'package:http/http.dart' as http;

import '../data/models/location.dart';
import '../secrets.dart';

class GoogleMaps {
  static const _apiKey = Secrets.googleMapsApiKey;

  static Future<String> getAddress({required Location location}) async {
    final addresses = await getAddresses(location: location);
    return addresses[0];
  }

  static Future<List<String>> getAddresses({required Location location}) async {
    final uri = Uri.https("maps.googleapis.com", "maps/api/geocode/json", {
      "latlng": "${location.latitude},${location.longitude}",
      "key": _apiKey,
      "result_type": "street_address",
    });

    final response = await http.get(uri);
    final json = jsonDecode(response.body)["results"];

    final List<String> result = [];
    json.forEach((item) => result.add(item["formatted_address"].toString()));
    return result;
  }

  static Uri getStaticMapUri({
    required Location location,
  }) {
    return Uri.https(
      "maps.googleapis.com",
      "maps/api/staticmap",
      {
        "center": "${location.latitude},${location.longitude}",
        "zoom": "13",
        "size": "600x250",
        "markers": "color:red|${location.latitude},${location.longitude}",
        "key": _apiKey
        // Url signing is recommended but not required.  If we were doing so, we would append a further param thus...
        // "signature": "<YOUR_SIGNATURE>",
      },
    );
  }
}
