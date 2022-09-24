class Aqicn {
  final String _status;
  final Map data;

  Aqicn({
    required String status,
    required this.data,
  }) : _status = status;

  get status => (_status == "ok") ? _status : data['data'];

  copyWith({
    String? status,
    Map? data,
  }) {
    return Aqicn(status: status ?? this.status, data: data ?? this.data);
  }

  Map<String, dynamic> toJson() => {
        'status': status,
        'data': data,
      };

  Aqicn.fromJson(Map<String, dynamic> json)
      : _status = json['status'],
        data = (json['data'] is String) ? {'data': json['data']} : json['data'];

  get location {
    String fullLocation = data['city']['name'];
    List<String> locations = fullLocation.split(',');
    return locations.first;
  }

  get score => data['aqi'];
}
