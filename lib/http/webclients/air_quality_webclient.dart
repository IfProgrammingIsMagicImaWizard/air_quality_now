import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';

import '../../models/setup.dart';
import '../../models/air_quality_info.dart';
import '../../models/aqicn.dart';
import '../interceptors/air_quality_interceptor.dart';
import 'stations_webclient.dart';

Client client = InterceptedClient.build(
  interceptors: [
    AirQualityInterceptor(),
  ],
  requestTimeout: const Duration(seconds: 15),
);

String _parseUrl(Setup setup) {
  return "https://api.waqi.info/feed/geo:${setup.latitude};${setup.longitude}/?token=${setup.token}";
}

Future<Setup> loadApi(Setup setup, {bool newEntry = false}) async {
  try {
    String lastLocation = location(setup);
    setup = await isOnline(setup);

    String url = _parseUrl(setup);
    log("Sending request: $url");
    final Response response = await client.get(Uri.parse(url));
    final dynamic json = jsonDecode(response.body);
    Aqicn aqicn = Aqicn.fromJson(json);
    if (aqicn.status == "ok") {
      AirQualityInfo info = AirQualityInfo(
          location: ((setup.isOnline == false && newEntry) ||
                  (setup.isOnline == false && lastLocation == '...'))
              ? '...'
              : aqicn.location,
          score: aqicn.score,
          lastStatusCode:
              '${response.statusCode.toString()} - ${statusMessage(response.statusCode)}');
      setup = setup.copyWith(
          info: info,
          statusCode: response.statusCode,
          status: statusMessage(response.statusCode));

      return setup;
    } else {
      return setup.copyWith(status: aqicn.status);
    }
  } catch (e) {
    log('An error occurred while searching for information:');
    log(e.toString());
    return setup.copyWith(status: e.toString());
  }
}

String location(Setup setup) {
  if (setup.info != null) {
    return setup.info!.location;
  } else {
    return "...";
  }
}

String statusMessage(int int) {
  Map map = {
    100: "Continue",
    101: "Switching Protocol",
    102: "Processing",
    103: "Early Hints",
    200: "Sucess",
    201: "Created",
    202: "Accepted",
    203: "Non-Authoritative Information",
    204: "No Content",
    205: "Reset Content",
    206: "Partial Content",
    207: "Multi-Status",
    208: "Multi-Status",
    226: "IM Used",
    300: "Multiple Choice",
    301: "Moved Permanently",
    302: "Found",
    303: "See Other",
    304: "Not Modified",
    305: "Use Proxy",
    306: "unused",
    307: "Temporary Redirect",
    308: "Permanent Redirect",
    400: "Bad Request",
    401: "Unauthorized",
    402: "Payment Required",
    403: "Forbidden",
    404: "Not Found",
    405: "Method Not Allowed",
    406: "Not Acceptable",
    407: "Proxy Authentication Required",
    408: "Request Timeout",
    409: "Conflict",
    410: "Gone",
    411: "Length Required",
    412: "Precondition Failed",
    413: "Payload Too Large",
    414: "URI Too Long",
    415: "Unsupported Media Type",
    416: "Requested Range Not Satisfiable",
    417: "Expectation Failed",
    418: "I'm a teapot",
    421: "Misdirected Request",
    422: "Unprocessable Entity",
    423: "Locked",
    424: "Failed Dependency",
    425: "Too Early",
    426: "Upgrade Required",
    428: "Precondition Required",
    429: "Too Many Requests",
    431: "Request Header Fields Too Large",
    451: "Unavailable For Legal Reasons",
    500: "Internal Server Error",
    501: "Not Implemented",
    502: "Bad Gateway",
    503: "Service Unavailable",
    504: "Gateway Timeout",
    505: "HTTP Version Not Supported",
    506: "Variant Also Negotiates",
    507: "Insufficient Storage",
    508: "Loop Detected",
    510: "Not Extended",
    511: "Network Authentication Required",
  };

  if (map.containsKey(int)) {
    return map[int];
  } else {
    return "...";
  }
}
