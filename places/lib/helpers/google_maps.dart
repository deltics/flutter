import '../data/models/location.dart';

class GoogleMaps {
  static const _apiKey = "AIzaSyBGdICtJzXNpB6dkMxOjTyR3qWmF5QeoSk";

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
