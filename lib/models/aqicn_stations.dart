class AqicnStations {
  final String _status;
  final List data;

  AqicnStations({
    required String status,
    this.data = const [],
  }) : _status = status;

  get status => (_status == "ok") ? _status : data[0]['data'];

  copyWith({
    String? status,
    List<Map<String, dynamic>>? data,
  }) {
    return AqicnStations(
        status: status ?? this.status, data: data ?? this.data);
  }

  Map<String, dynamic> toJson() => {
        'status': status,
        'data': data,
      };

  AqicnStations.fromJson(Map<String, dynamic> json)
      : _status = json['status'],
        data = (json['data'] is String)
            ? List.filled(1, {'data': json['data']})
            : json['data'];
}
