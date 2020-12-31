import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class MapUtils {
  MapUtils._();

  static Future<void> openMap(double latitude, double longitude) async {
    String googleUrl =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    } else {
      throw 'Could not open the map.';
    }
  }

  static List<LatLng> mainCoordinates = [
    LatLng(45.653819, -122.579905),
    LatLng(45.654180, -122.578876),
    LatLng(45.654206, -122.576038),
    LatLng(45.654253, -122.574480),
    LatLng(45.654212, -122.572932),
    LatLng(45.652616, -122.573410),
    LatLng(45.651553, -122.572726),
    LatLng(45.649459, -122.573398),
    LatLng(45.648161, -122.573495),
    LatLng(45.647450, -122.573954),
    LatLng(45.646440, -122.573704),
    LatLng(45.645975, -122.573703),
    LatLng(45.644912, -122.573584),
    LatLng(45.644830, -122.576064),
    LatLng(45.644723, -122.578100),
    LatLng(45.644742, -122.579251),
    LatLng(45.644976, -122.580425),
    LatLng(45.646222, -122.580526),
    LatLng(45.646987, -122.580640),
    LatLng(45.647845, -122.580853),
    LatLng(45.649734, -122.580871),
    LatLng(45.651536, -122.581434),
    LatLng(45.652195, -122.582012),
    LatLng(45.653104, -122.582294)
  ];

  static bool checkIfValidArea(LatLng tap, List<LatLng> vertices) {
    int intersectCount = 0;
    for (int j = 0; j < vertices.length - 1; j++) {
      if (rayCastIntersect(tap, vertices[j], vertices[j + 1])) {
        intersectCount++;
      }
    }
    return ((intersectCount % 2) == 1); // odd = inside, even = outside;
  }

  static bool rayCastIntersect(LatLng tap, LatLng vertA, LatLng vertB) {
    double aY = vertA.latitude;
    double bY = vertB.latitude;
    double aX = vertA.longitude;
    double bX = vertB.longitude;
    double pY = tap.latitude;
    double pX = tap.longitude;

    if ((aY > pY && bY > pY) || (aY < pY && bY < pY) || (aX < pX && bX < pX)) {
      return false; // a and b can't both be above or below pt.y, and a or
      // b must be east of pt.x
    }
    double m = (aY - bY) / (aX - bX); // Rise over run
    double bee = (-aX) * m + aY; // y = mx + b
    double x = (pY - bee) / m; // algebra is neat!

    return x > pX;
  }
}
