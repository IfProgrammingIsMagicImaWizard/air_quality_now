import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';

import '../../models/setup.dart';
import '../../models/aqicn_stations.dart';
import '../interceptors/air_quality_interceptor.dart';

Client _client = InterceptedClient.build(
  interceptors: [
    AirQualityInterceptor(),
  ],
  requestTimeout: const Duration(seconds: 15),
);

String _parseUrl(Setup setup) {
  const double latitude10KmRadius = 0.008983 * 10;
  const double longitude10KmRadius = 0.015060 * 10;
  double lat1 = double.parse(setup.latitude) - latitude10KmRadius;
  double long1 = double.parse(setup.longitude) - longitude10KmRadius;
  double lat2 = double.parse(setup.latitude) + latitude10KmRadius;
  double long2 = double.parse(setup.longitude) + longitude10KmRadius;
  return "https://api.waqi.info/v2/map/bounds?latlng=$lat1,$long1,$lat2,$long2&networks=all&token=${setup.token}";
}

Future<Setup> isOnline(Setup setup) async {
  try {
    String url = _parseUrl(setup);
    log("Sending request: $url");
    final Response response = await _client.get(Uri.parse(_parseUrl(setup)));
    final dynamic json = jsonDecode(response.body);
    AqicnStations aqicn = AqicnStations.fromJson(json);
    return _analysis(aqicn: aqicn, setup: setup);
  } catch (e) {
    log('An error occurred while searching for stations:');
    log(e.toString());
    setup = setup.copyWith(status: e.toString());
    return setup;
  }
}

Setup _analysis({required AqicnStations aqicn, required Setup setup}) {
  List<String> scores = [];
  if (aqicn.status == "ok") {
    for (Map i in aqicn.data) {
      scores.add(i["aqi"]);
    }
    Map<String, int> elementsCount = _countElements(scores);
    if (elementsCount.containsKey("-") == false) {
      return setup.copyWith(isOnline: true);
    }
    double percentage = elementsCount["-"]! / elementsCount.length;
    if (percentage >= 0.3) {
      return setup.copyWith(
        status: 'Outside opening hours',
        isOnline: false,
      );
    }
    return setup.copyWith(isOnline: true);
  }
  return setup.copyWith(status: aqicn.status);
}

Map<String, int> _countElements(List<String> elements) {
  Map<String, int> map = {};

  for (String element in elements) {
    if (map.containsKey(element) == false) {
      map[element] = 1;
    } else {
      map[element] = map[element]! + 1;
    }
  }
  return map;
}

Map statusMessage = {200: "Sucess"};
